<!-- #include file="../access.asp" -->
<!-- #include file="../html_clear.asp" -->


<%'容错处理
function Chat_to_js()
On Error Resume Next
%>
<%
'模板内容读取替换
set rs=server.createobject("adodb.recordset")
sql="select * from web_service "
rs.open(sql),cn,1,1
if not rs.eof  then
web_ChatYes=rs("view_yes")
web_top=rs("top")
web_qq=split(rs("name"),"|")
TypeID=rs("stype")
Counts=ubound(web_qq)
for i=0 to Counts
select case TypeID
case 1
web_qqs=web_qqs&"document.writeln(""<li><a target=\'_blank\' href=\'tencent:\/\/message\/?uin="&web_qq(i)&"&Site=www.yhocn.cn&Menu=yes\'>客服"&i+1&"<\/a><\/li>""); "

case 2
web_qqs=web_qqs&"'<tr>' + "
web_qqs=web_qqs&"'<td style=background:none;border:0;padding-left:0px;margin:0px;padding:0px; align=center width=102 height=30>' + "
web_qqs=web_qqs&"'<span style=text-decoration:none;font-size:12;color:#3477B7;text-align:left><a style=text-decoration:none; href=tencent://message/?uin="&web_qq(i)&"&Site=www.yhocn.cn&Menu=yes target=_blank><img src=/images/qqimg/webQQ.gif style=margin:0px; padding:0px; align=texttop></a></span>' + "
web_qqs=web_qqs&"'</td>' + "
web_qqs=web_qqs&"'</tr>' + "
end select
next

'wangwang
if rs("wangwang")<>"" then
select case TypeID
case 1

web_wang="document.writeln(""<p align='center'><a target=\'_blank\' href=\'"&rs("wangwang")&"\'><img  SRC=\'/images/serviceimg/wang_icon.gif\' alt=\'在线咨询\'><\/a><\/p>""); "

case 2
web_wang=web_wang&"'<tr>' + "
web_wang=web_wang&"'<td style=background:none;border:0;padding-left:0px;margin:0px;padding:0px; align=center width=102 height=30>' + "
web_wang=web_wang&"'<span style=text-decoration:none;font-size:12;color:#3477B7;text-align:left><a style=text-decoration:none; href="&rs("wangwang")&" target=_blank><img src=/images/serviceimg/wang_icon.gif style=margin:0px; padding:0px; align=texttop></a></span>' + "
web_wang=web_wang&"'</td>' + "
web_wang=web_wang&"'</tr>' + "

end select
end if

'skype
if rs("skype")<>"" then
select case TypeID
case 1

web_Skypes="document.writeln(""<p align='center'><a href=\'"&rs("Skype")&"\' onclick=\'return skypeCheck();\'><img src=\'/images/serviceimg/skype_icon.gif\' style='border: none;\' alt=\'Call me!\' /><\/a><\/p>""); "

case 2
web_Skypes=web_Skypes&"'<tr>' + "
web_Skypes=web_Skypes&"'<td style=background:none;border:0;padding-left:0px;margin:0px;padding:0px; align=center width=102 height=30>' + "
web_Skypes=web_Skypes&"'<span style=text-decoration:none;font-size:12;color:#3477B7;text-align:left><a  href="&rs("skype")&"  target=_blank><img src=/images/serviceimg/skype_icon.gif  alt=""Call me!""></a></span>' + "
web_Skypes=web_Skypes&"'</td>' + "
web_Skypes=web_Skypes&"'</tr>' + "

end select
end if

'MSN
if rs("MSN")<>"" then
select case TypeID
case 1

web_MSNs="document.writeln(""<p align='center'><a href=\'"&rs("MSN")&"\' ><img src=\'/images/serviceimg/MSN_icon.gif\' style='border: none;\' alt=\'Contactt me!\' /><\/a><\/p>""); "

case 2
web_MSNs=web_MSNs&"'<tr>' + "
web_MSNs=web_MSNs&"'<td style=background:none;border:0;padding-left:0px;margin:0px;padding:0px; align=center width=102 height=30>' + "
web_MSNs=web_MSNs&"'<span style=text-decoration:none;font-size:12;color:#3477B7;text-align:left><a  href="&rs("MSN")&"  target=_blank><img src=/images/serviceimg/MSN_icon.gif  alt=""Contact me!""></a></span>' + "
web_MSNs=web_MSNs&"'</td>' + "
web_MSNs=web_MSNs&"'</tr>' + "

end select
end if


end if
rs.close
set rs=nothing
%>
<% '读取模板内容
if web_ChatYes=1 then
TemplatePath="/templates/common/ServiceCenterTemplate"&TypeID&".js"
else
TemplatePath="/templates/common/template.js"
end if

Set fso=Server.CreateObject("Scripting.FileSystemObject") 
Set htmlwrite=fso.OpenTextFile(Server.MapPath(TemplatePath)) 
replace_code=htmlwrite.ReadAll() 
htmlwrite.close 


%>
<%
replace_code=replace(replace_code,"$web_top$",web_top)
replace_code=replace(replace_code,"$web_qqs$",web_qqs)
replace_code=replace(replace_code,"$web_wangwang$",web_wang)
replace_code=replace(replace_code,"$web_Skypes$",web_Skypes)
replace_code=replace(replace_code,"$web_MSNs$",web_MSNs)
replace_code=replace(replace_code,"$ADs_Content$",ADs_Content)
%>

<%'声明HTML文件名,指定文件路径
filepath="/js/ServiceCenter.js"
%>
<% '生成首页静态文件
Set fout = fso.CreateTextFile(Server.MapPath(filepath))
fout.WriteLine replace_code
fout.close
fso.close
set fso=nothing
end function
%>