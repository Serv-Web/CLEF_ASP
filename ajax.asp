<%':: Include files such as config and functions %>
<!--#include file="json.asp"-->
<!--#include file="aspJSON1.17.asp" -->
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%
Set Conns = Server.CreateObject("ADODB.Connection")
Conns.Open(my_conn)
set rsTS = Conns.Execute("select * from clef_users where (u_logoutnext <> '' or u_logoutnext <> ' ') and clef_id = '" & session("login") & "'")
if rsTS.eof or rsTS.bof then
response.write "No Login Found!"
else
response.write "logout"
end if
rsTS.close
set rsTS = nothing
%>