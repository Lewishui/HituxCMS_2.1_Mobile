<!-- #include file="../html_clear.asp" -->
<%'容错处理
function Post_index_to_html()
On Error Resume Next
%>
<%
'首页基本信息内容读取替换
set rs=server.createobject("adodb.recordset")
sql="select web_name,web_url,web_image,web_title,web_keywords,web_contact,web_tel,web_TopHTML,web_BottomHTML,web_description,web_copyright,web_theme from mobile_web_settings"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
web_name=rs("web_name")
web_url=rs("web_url")
web_image=rs("web_image")
web_title=rs("web_title")
web_keywords=rs("web_keywords")
web_description=rs("web_description")
web_copyright=rs("web_copyright")
web_theme=rs("web_theme")
web_consult=rs("web_contact")
web_TopHTML=rs("web_TopHTML")
web_BottomHTML=rs("web_BottomHTML")
web_tel=rs("web_tel")
end if
rs.close
set rs=nothing
%>

<% '文件夹获取
'搜索文件夹获取
set rs_1=server.createobject("adodb.recordset")
sql="select FileName,FolderName from mobile_web_Models_type where [id]=35"
rs_1.open(sql),cn,1,1
if not rs_1.eof and rs_1("FolderName")<>"" then
Search_FolderName="/"&web_Folder&"/"&rs_1("FolderName")
end if
rs_1.close
set rs_1=nothing

'文章内容文件夹获取
set rs_1=server.createobject("adodb.recordset")
sql="select FileName,FolderName from mobile_web_Models_type where [id]=5"
rs_1.open(sql),cn,1,1
if not rs_1.eof and rs_1("FolderName")<>"" then
ArticleContent_FolderName="/"&web_Folder&"/"&rs_1("FolderName")
end if
rs_1.close
set rs_1=nothing


'问吧模板类型获取
set rs_1=server.createobject("adodb.recordset")
sql="select FileName,FolderName from mobile_web_Models_type where [id]=8"
rs_1.open(sql),cn,1,1
if not rs_1.eof then
Model_FileName=rs_1("FileName")
if rs_1("FolderName")<>"" then
Model_FolderName="/"&web_Folder&"/"&rs_1("FolderName")
else
Model_FolderName="/"&web_Folder
end if
end if
rs_1.close
set rs_1=nothing
%>
<%
'底部导航
web_BottomMenu=""
set rs=server.createobject("adodb.recordset")
sql="select [name],[url],[image] from mobile_web_menu_type where BottomNav=1 order by [order]"
rs.open(sql),cn,1,1
if not rs.eof then
for i=1 to rs.recordcount

web_BottomMenu=web_BottomMenu&"<li class='LiIcon"&i&"' style='background:url(/images/up_images/"&rs("image")&") no-repeat center 5px;'><a href='"&rs("url")&"'>"&rs("name")&"</a></li> "

rs.movenext
next
end if
rs.close
set rs=nothing


'顶部导航
web_TopMenu=""
set rs=server.createobject("adodb.recordset")
sql="select * from mobile_web_menu_type where TopNav=1 order by [order]"
rs.open(sql),cn,1,1
if not rs.eof then
web_TopMenu=web_TopMenu&"<ul id='sddm'>"
for i=1 to rs.recordcount
if i=1 then
web_TopMenu=web_TopMenu&"<li class='CurrentLi'><a href='"&rs("url")&"'>"&rs("name")&"</a></li> "
else

web_TopMenu=web_TopMenu&"<li><a href='"&rs("url")&"'>"&rs("name")&"</a></li> "

end if
rs.movenext
next
web_TopMenu=web_TopMenu&"</ul>"
end if
rs.close
set rs=nothing

'顶部文字读取
set rs=server.createobject("adodb.recordset")
sql="select top 1 [id],ADtype,[ADcode] from mobile_web_ads  where [position]=37 and view_yes=1 order by [time] desc"
rs.open(sql),cn,1,1
if not rs.eof then
if rs("ADtype")=4 then
Inner_BannerTop2=Inner_BannerTop2&rs("ADcode")
else
Inner_BannerTop2=Inner_BannerTop2&"<script src='/ADs/"&rs("id")&".js' type='text/javascript'></script>"
end if 
else
Inner_BannerTop2=Inner_BannerTop2&""
end if
rs.close
set rs=nothing

'顶部广告读取
set rs=server.createobject("adodb.recordset")
sql="select top 1 [id],ADtype,[ADcode] from mobile_web_ads  where [position]=35 and view_yes=1 order by [time] desc"
rs.open(sql),cn,1,1
if not rs.eof then
if rs("ADtype")=4 then
Inner_BannerTop=Inner_BannerTop&rs("ADcode")
else
Inner_BannerTop=Inner_BannerTop&"<script src='/ADs/"&rs("id")&".js' type='text/javascript'></script>"
end if 
else
Inner_BannerTop=Inner_BannerTop&""
end if
rs.close
set rs=nothing


'侧边栏当前栏目列表
set rs=server.createobject("adodb.recordset")
sql="select [id],[name],[folder] from [category] where ClassType=5 and ppid=1 order by [order]"
rs.open(sql),cn,1,1
if not rs.eof then
ClassID=rs("id")
ClassName1=rs("name")
ClassFolder1=rs("folder")
Block_LeftClassList=""
set rsl=server.createobject("adodb.recordset")
sql="select [name],[folder],[id],[pid],[ppid] from [category] where pid="&ClassID&" order by [order] "
rsl.open(sql),cn,1,1
Block_LeftClassList=Block_LeftClassList&"<ul>"
if not rsl.eof then
for i=1 to rsl.recordcount
if rsl("id")=ClassID then
Block_LeftClassList=Block_LeftClassList&"<li class='current'><A href='/"&web_Folder&"/"&ClassFolder1&"/"&rsl("Folder")&"'>"&rsl("name")&"</A></li> "
else
Block_LeftClassList=Block_LeftClassList&"<li><A href='/"&web_Folder&"/"&ClassFolder1&"/"&rsl("Folder")&"'>"&rsl("name")&"</A></li> "
end if
rsl.movenext
next
else
Block_LeftClassList=Block_LeftClassList&""
end if
Block_LeftClassList=Block_LeftClassList&"</ul>"
rsl.close
set rsl=nothing

end if
rs.close
set rs=nothing
%>
<!--common use end-->

<%
 '列表读取替换
sql="select [id] from web_article_comment where view_yes=1 and article_id=0  order by [time]"
set rs1=server.createObject("ADODB.Recordset")
rs1.open sql,cn,1,1
%><%
if not rs1.eof then
rs1.pagesize=5
totalpage=rs1.pagecount

for j=1 to totalpage
rs_order=1
sql="select * from web_article_comment where view_yes=1 and article_id=0  order by [time]"
set rs=server.createObject("ADODB.Recordset")
rs.open sql,cn,1,1
if not rs.eof then

rscount=rs.recordcount
whichpage=j 
rs.pagesize=5
totalpage=rs.pagecount
rs.absolutepage=whichpage
howmanyrecs=0
list_block=""
do while not rs.eof and howmanyrecs<rs.pagesize
%><%
if rs("name")<>"" then
comment_name=rs("name")
else
comment_name=rs("ip")
end if

if rs("recontent")<>"" then
comment_replay="<div class='Freply'><div class='FRtitle'>回 复</div><p>"&rs("recontent")&"</p></div>"
else
comment_replay=""
end if
rs_Pagesize=(j-1)*rs.pagesize
rs_order=rs_order+rs_pagesize

list_block=list_block&"<div class='FeedBlock'><div class='Fleft'>"
list_block=list_block&"<div class='Ficon'><img src='/images/PostIcon.gif'></div>"
list_block=list_block&"<div class='Fname'>"&rs("name")&"</div></div>"
list_block=list_block&"<div class='Fright'><div class='Fcontent'>"
list_block=list_block&"<div class='Ftime'>"&rs("time")&"</div>"
list_block=list_block&"<p>"&rs("content")&"</p>"
list_block=list_block&comment_replay
list_block=list_block&"</div><div class='Fline'></div><div class='clearfix'></div>"
list_block=list_block&"</div></div><div class='clearfix'></div> "
%>
<%
rs.movenext
rs_order=rs_order+1-rs_Pagesize
howmanyrecs=howmanyrecs+1
loop
end if
rs.close
set rs=nothing
%>

<%
'分页部分
list_page=""
list_page=list_page&"<div class='t_page ColorLink'>"
list_page=list_page&"总数："&rscount&"条&nbsp;&nbsp;当前页数：<span class='FontRed'>" & j & "</span>/" & totalpage &""
list_page=list_page&"<a href=index.html"&">" & "首页" & "</a>"
if whichpage=1 then
list_page=list_page&"&nbsp;&nbsp;上一页&nbsp;&nbsp;"
else
if j=2  then
list_page=list_page&"<a href=index.html"&">" & "上一页" & "</a>"
else
list_page=list_page&"<a href=list_"&j-1&".html"&">" & "上一页" & "</a>"
end if
end if

if totalpage-j>4 then
PageNO=j+4
else
PageNO=totalpage
end if

for counter=j to PageNO
if counter=1 then
list_page=list_page&"<a href=index.html"&">" & counter & "</a> "
else
if counter=j then
list_page=list_page&"<a href=list_"&counter&".html"&"><span class='FontRed'>" & counter & "</span></a> "
else
list_page=list_page&"<a href=list_"&counter&".html"&">" & counter & "</a> "
end if
end if
next

if (whichpage>totalpage or whichpage=totalpage) then
list_page=list_page&"&nbsp;&nbsp;下一页&nbsp;&nbsp;"
else
list_page=list_page&"<a href=list_"&j+1&".html"&">" & "下一页" & "</a>"
end if
if totalpage=1 then
list_page=list_page&"<a href=index.html"&">" & "尾页" & "</a></div>"
else
list_page=list_page&"<a href=list_"&totalpage&".html"&">" & "尾页" & "</a></div>"
end if
%>

<%
 '读取模板内容
Set fso=Server.CreateObject("Scripting.FileSystemObject") 
Set htmlwrite=fso.OpenTextFile(Server.MapPath("/templates/MobileTemplet/"&Model_FileName)) 
replace_code=htmlwrite.ReadAll() 
htmlwrite.close 
%>

<%'循环列表替换内容
replace_code=replace(replace_code,"$list_block$",list_block)  
replace_code=replace(replace_code,"$list_page$",list_page)    
replace_code=replace(replace_code,"$RScount$",RScount)   
%>
<%'循环其它替换内容
replace_code=replace(replace_code,"$web_name$",web_name)
replace_code=replace(replace_code,"$web_url$",web_url)
replace_code=replace(replace_code,"$web_image$",web_image)
replace_code=replace(replace_code,"$web_title$",web_title)
replace_code=replace(replace_code,"$web_copyright$",web_copyright)
replace_code=replace(replace_code,"$web_theme$",web_theme)
replace_code=replace(replace_code,"$web_consult$",web_consult)
replace_code=replace(replace_code,"$web_TopHTML$",web_TopHTML)
replace_code=replace(replace_code,"$web_BottomHTML$",web_BottomHTML)
replace_code=replace(replace_code,"$web_tel$",web_tel)
replace_code=replace(replace_code,"$search_FolderName$",search_FolderName)

replace_code=replace(replace_code,"$web_link$",web_link)
replace_code=replace(replace_code,"$InnerAD_Bottom$",InnerAD_Bottom)
replace_code=replace(replace_code,"$InnerAD_Top$",InnerAD_Top)
replace_code=replace(replace_code,"$web_BottomNav$",web_BottomNav)
replace_code=replace(replace_code,"$web_menu$",web_menu)
replace_code=replace(replace_code,"$web_indexsearch$",web_indexsearch)
replace_code=replace(replace_code,"$Block_LeftClassList$",Block_LeftClassList)
replace_code=replace(replace_code,"$ClassName1$",ClassName1)
replace_code=replace(replace_code,"$ClassFolder1$",ClassFolder1)

replace_code=replace(replace_code,"$web_TopMenu$",web_TopMenu)
replace_code=replace(replace_code,"$web_BottomMenu$",web_BottomMenu)
replace_code=replace(replace_code,"$Inner_BannerTop$",Inner_BannerTop)
replace_code=replace(replace_code,"$Inner_BannerTop2$",Inner_BannerTop2)
replace_code=replace(replace_code,"$Block01_LeftItem$",Block01_LeftItem)
replace_code=replace(replace_code,"$Block02_LeftItem$",Block02_LeftItem)
%>

<% '判断文件夹是否存在，否则创建
Set Fso=Server.CreateObject("Scripting.FileSystemObject") 
If Fso.FolderExists(Server.MapPath(Model_FolderName))=false Then
NewFolderDir=Model_FolderName
call CreateFolderB(NewFolderDir)
end if
%>
<%
filepath=Model_FolderName&"/list_"&j&".html"
filepath_index=Model_FolderName&"/index.html"
%>
<%
if j>1 then
'读取模板
Set fout = fso.CreateTextFile(Server.MapPath(filepath))
fout.WriteLine replace_code
fout.close
fso.close
set fso=nothing
end if

if j=1 then
Set f=fso.CreateTextFile(Server.MapPath(filepath_index),true)
f.WriteLine replace_code
f.close
end if
%>
<%
next
else
j=1
%>
<%
 '读取模板内容
Set fso=Server.CreateObject("Scripting.FileSystemObject") 
Set htmlwrite=fso.OpenTextFile(Server.MapPath("/templates/MobileTemplet/"&Model_FileName)) 
replace_code=htmlwrite.ReadAll() 
htmlwrite.close 

%>

<%'循环列表替换内容
replace_code=replace(replace_code,"$list_block$","<p align='center'> </p>") 
replace_code=replace(replace_code,"$list_page$",list_page)      
replace_code=replace(replace_code,"$RScount$","0")   
%>
<%'循环其它替换内容
replace_code=replace(replace_code,"$web_name$",web_name)
replace_code=replace(replace_code,"$web_url$",web_url)
replace_code=replace(replace_code,"$web_image$",web_image)
replace_code=replace(replace_code,"$web_title$",web_title)
replace_code=replace(replace_code,"$web_copyright$",web_copyright)
replace_code=replace(replace_code,"$web_theme$",web_theme)
replace_code=replace(replace_code,"$web_consult$",web_consult)
replace_code=replace(replace_code,"$web_TopHTML$",web_TopHTML)
replace_code=replace(replace_code,"$web_BottomHTML$",web_BottomHTML)
replace_code=replace(replace_code,"$web_tel$",web_tel)
replace_code=replace(replace_code,"$search_FolderName$",search_FolderName)

replace_code=replace(replace_code,"$web_link$",web_link)
replace_code=replace(replace_code,"$InnerAD_Bottom$",InnerAD_Bottom)
replace_code=replace(replace_code,"$InnerAD_Top$",InnerAD_Top)
replace_code=replace(replace_code,"$web_BottomNav$",web_BottomNav)
replace_code=replace(replace_code,"$web_menu$",web_menu)
replace_code=replace(replace_code,"$web_indexsearch$",web_indexsearch)
replace_code=replace(replace_code,"$Block_LeftClassList$",Block_LeftClassList)
replace_code=replace(replace_code,"$ClassName1$",ClassName1)
replace_code=replace(replace_code,"$ClassFolder1$",ClassFolder1)

replace_code=replace(replace_code,"$web_TopMenu$",web_TopMenu)
replace_code=replace(replace_code,"$web_BottomMenu$",web_BottomMenu)
replace_code=replace(replace_code,"$Inner_BannerTop$",Inner_BannerTop)
replace_code=replace(replace_code,"$Inner_BannerTop2$",Inner_BannerTop2)
replace_code=replace(replace_code,"$Block01_LeftItem$",Block01_LeftItem)
replace_code=replace(replace_code,"$Block02_LeftItem$",Block02_LeftItem)
%>

<% '判断文件夹是否存在，否则创建
Set Fso=Server.CreateObject("Scripting.FileSystemObject") 
If Fso.FolderExists(Server.MapPath(Model_FolderName))=false Then
NewFolderDir=Model_FolderName
call CreateFolderB(NewFolderDir)
end if
%>
<%
filepath_index=Model_FolderName&"/index.html"
%>
<%
Set f=fso.CreateTextFile(Server.MapPath(filepath_index),true)
f.WriteLine replace_code
f.close
%>
<%end if
rs1.close
set rs1=nothing%>

<%end function%>