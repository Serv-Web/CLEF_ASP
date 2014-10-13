<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<%
canWrite = True
config_filename = Server.MapPath("/") & "\config.asp"
if NOT request("install") = "yes" then

	canWrite = false
	uploadDir = "/"
	client_ip_address = Request.ServerVariables("REMOTE_ADDR")
	uniq_id = cstr(timer)
	unique_filename = Server.MapPath(uploadDir) & "\temp_" & uniq_id & ".txt"
	config_filename = Server.MapPath(uploadDir) & "\config.asp"
	Set fs = Server.CreateObject("Scripting.FileSystemObject")

	if( not fs.FolderExists(Server.MapPath(uploadDir)) ) then
		'Response.Write vbLF & "Test FAILED! Directory " & uploadDir & " does not exist!" & vbLF
		'Response.Write "Please modify the ASP code in this script to match your server folders." & vbLF
	
	else
		ForWriting = 2  ' constant read/write/append
		On Error Resume Next
		Set stream = fs.OpenTextFile(unique_filename, ForWriting, True)

		stream.WriteLine("abcd")
		if Err.Number <> 0 then
			'Response.Write vbLF & "Write permission test FAILED!" & vbLF
			'Response.Write "Could not write to file in directory:" & vbLF
			'Response.Write "    " & uploadDir & vbLF
			'Response.Write "Please change write permission according to the installation instructions." & vbLF
		else
			'Response.Write vbLF & "Write permission test PASSED!" & vbLF
			canWrite = True
		end if

		stream.Close
		set stream = Nothing
		set fs = Nothing	
			On Error Goto 0
	end if
end if
	
%>
<title>Clef Classic ASP Integration - Install Script</title>
</head>

<body>
<div id="clef-wrapper">
<% if request("step") < 3 then %>
<form method="post" action="install.asp">
<input type="hidden" name="install" value="yes">
<table border="0" width="100%" cellpadding="3">
	<tr>
		<td colspan="2">
		<h2 align="center"><font face="Arial">Clef Classic ASP Integration - 
		Install Script</font></h2>
		</td>
	</tr>
	<tr>
		<td align="center">
<font face="Arial">&nbsp;Do we have write permissions?</font></td>
		<td align="center">
<b><font face="Arial"><% if canWrite then %><font color="#008000">YES</font> <% else %><font color="#FF0000">NO</font><% end if %></font></b></td>
	</tr>
<% if NOT canWrite then %>
	<tr>
		<td colspan="2">
<i><b><font face="Arial">&nbsp;Please check the write permissions on your root 
folder of this script to continue.</font></b></i></td>
	</tr>
<% else %>
	<tr>
		<td colspan="2" bgcolor="#C0C0C0">
<b><font face="Arial">Setup your Config file and Database</font></b></td>
	</tr>
	<tr>
		<td align="right">
<font face="Arial" size="2">Database Host/Server :</font></td>
		<td>
<p align="center">
<input type="text" name="db_server" placeholder="i.e localhost" size="30"></td>
	</tr>
	<tr>
		<td align="right">
<font face="Arial" size="2">Database Name :</font></td>
		<td>
<p align="center">
<input type="text" name="db_name" placeholder="i.e myDB" size="30"></td>
	</tr>
	<tr>
		<td align="right">
<font face="Arial" size="2">Database Username :</font></td>
		<td align="center">
<input type="text" name="db_user" placeholder="i.e dbusername" size="30"></td>
	</tr>
	<tr>
		<td align="right">
<font face="Arial" size="2">Database Password :</font></td>
		<td align="center">
<input type="text" name="db_pass" placeholder="i.e dbpassword" size="30"></td>
	</tr>
	<tr>
		<td align="right">
<font face="Arial" size="2">CLEF APP ID :</font></td>
		<td align="center">
<input type="text" name="clef_app" placeholder="See your clef account." size="30"></td>
	</tr>
	<tr>
		<td align="right">
<font face="Arial" size="2">CLEF APP Secret :</font></td>
		<td align="center">
<input type="text" name="clef_secret" placeholder="See your clef account." size="30"></td>
	</tr>
<% end if %>
	<tr>
		<td colspan="2">
<p align="center"><input type="submit" value="Install The Script" name="B1"></td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="#C0C0C0">
<b><font face="Arial">Installation Results</font></b></td>
	</tr>
	<tr>
		<td colspan="2">
<p align="center"><font face="Arial" size="2">
<% 
if request("install") = "yes" then
if request("step") < 2 then

':: lets update the blank config file
Set fs = Server.CreateObject("Scripting.FileSystemObject")
Set stream = fs.OpenTextFile(config_filename, 2, True)
tLine = chr(60) & chr(37)
stream.WriteLine(tline)

for each x in request.form
if x <> "B1" and x <> "install" then

tline = x & " = " & chr(34) & request.form(x) & chr(34)
stream.WriteLine(tline)

end if
next

tLine = chr(37) & chr(62)
stream.WriteLine(tline)


		stream.Close
		set stream = Nothing
		set fs = Nothing
		session("conf_status") = "File Created!"
		response.redirect("install.asp?install=yes&step=2")
else

':: lets create the database structure
if request("step") < 3 then
Set bConn = Server.CreateObject("ADODB.Connection")
bConn.Open(my_conn)

bConn.Execute("CREATE TABLE IF NOT EXISTS `clef_users` (`id` int(11) NOT NULL,`u_logoutnext` longtext NOT NULL,`u_name` longtext NOT NULL,`u_email` longtext NOT NULL,`clef_id` longtext NOT NULL)")
bConn.Execute("ALTER TABLE `clef_users` ADD PRIMARY KEY (`id`)")
bConn.Execute("ALTER TABLE `clef_users` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT")

bConn.close
set bConn = nothing
response.redirect("install.asp?install=yes&step=3")
else
db_status = "Complete"
end if

end if
%>
<table border="0" width="100%" cellpadding="3">
	<tr>
		<td>Creating The Config File...</td>
		<td><i><b><font color="#008000"><%=session("conf_status")%></font> </b></i></td>
	</tr>
	<tr>
		<td>Creating the database structure....</td>
		<td><i><b><font color="#008000"><%=db_status%></font></b></i></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<%
else
%>
Waiting on you to complete the 
form.
<% end if %>
</font></td>
	</tr>
</table>
</form>
<h1 align="center">
<% else %><font face="Arial">
Install completed, please visit <a href="default.asp">default.asp</a>
<% end if %>
</font></h1>
</div>
</body>

</html>