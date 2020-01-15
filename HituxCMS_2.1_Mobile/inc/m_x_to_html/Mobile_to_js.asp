<!-- #include file="../../inc/access.asp" -->

<%'容错处理
function Mobile_to_js()
On Error Resume Next
%>
<%
'读取替换
set rs=server.createobject("adodb.recordset")
sql="select web_Folder,web_show from mobile_web_settings"
rs.open(sql),cn,1,1
if not rs.eof  then
web_Folder=rs("web_folder")
web_ShowYes=rs("web_show")
end if
rs.close
set rs=nothing
%>
<% '读取模板内容
Set fso=Server.CreateObject("Scripting.FileSystemObject") 
Set htmlwrite=fso.OpenTextFile(Server.MapPath("/js/Functions.js")) 
replace_code=htmlwrite.ReadAll() 
htmlwrite.close 
%>

<%
replace_code=replace(replace_code,"/"&OldFolder&"/","/"&web_Folder&"/")
if web_ShowYes=1 then
replace_code=replace(replace_code,"replace(murl)","replace(NoUrl)")
else
replace_code=replace(replace_code,"replace(NoUrl)","replace(murl)")
end if
%>
<% '判断ADs文件夹是否存在，否则创建
Set Fso=Server.CreateObject("Scripting.FileSystemObject") 
If Fso.FolderExists(Server.MapPath("/js"))=false Then
NewFolderDir="/js"
call CreateFolderB(NewFolderDir)
end if
%>

<%'声明HTML文件名,指定文件路径
filepath="/js/Functions.js"
%>

<%
 '读取模板
Set fout = fso.CreateTextFile(Server.MapPath(filepath))
fout.WriteLine replace_code
fout.close
fso.close
set fso=nothing
%>

<%end function
%>