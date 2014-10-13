<%
'::functions file
':: this is your mySQL connection string you MAY need to change this depending on your hosting environment.

my_conn = "DRIVER={MySQL ODBC 3.51 Driver}; SERVER=" & db_server & "; DATABASE=" & db_name & "; UID=" & db_user & ";PASSWORD=" & db_pass & "; OPTION=3"


function executeSQL(sqlcode)
Set eobjsConn = Server.CreateObject("ADODB.Connection")

eobjsConn.Open(my_conn)
eobjsConn.Execute(sqlcode)

eobjsConn.close
end function

':: KEEP OUR SESSION
if session("login") <> "" then
session("login") = session("login")
end if

':: LOGOUT HOOK
if request("func") = "logout" then
executeSQL("update clef_users set u_logoutnext = '' where clef_id = '" & session("login") & "'")
session("login") = ""
response.redirect("default.asp")
end if

if request("logout_token") <> "" then
response.write "Logout Function:<br>"
str = "logout_token=" & request("logout_token") & "&app_id=" & clef_app & "&app_secret=" & clef_secret



'set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
' set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP.4.0")
 set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
 
objHttp.open "POST", "https://clef.io/api/v1/logout", false
objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send str

json_reply = objHttp.responseText
response.write json_reply
Set oJSON = New aspJSON

'Load JSON string
oJSON.loadJSON(json_reply)

'Get single value
clef_id = oJSON.data("clef_id")
executeSQL("update clef_users set u_logoutnext = '" & now() & "' where clef_id = '" & clef_id & "'")
end if
':: LOGOUT HOOK

':: CLEF PICK UP LOGIN HOOK

if request("code") <> "" then
clef_oauthcode = request("code")
else
clef_oauthcode = ""
end if

if clef_oauthcode <> "" then
dru = "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL") & "?logout=yes"

str = "code=" & clef_oauthcode & "&app_id=" & clef_app & "&app_secret=" & clef_secret & "&logout_hook=" & dru

'set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
' set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP.4.0")
 set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
objHttp.open "POST", "https://clef.io/api/v1/authorize", false
objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send str

json_reply = objHttp.responseText
'response.write json_reply

Set oJSON = New aspJSON

'Load JSON string
oJSON.loadJSON(json_reply)

'Get single value
clef_accesstoken = oJSON.data("access_token")
'Response.Write "<br>Access Token: " & clef_accesstoken & "<br>"
set objHttp = nothing

'set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
' set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP.4.0")
 set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
objHttp.open "GET", "https://clef.io/api/v1/info?access_token=" & clef_accesstoken, false
'objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send

json_reply = objHttp.responseText
'response.write json_reply


oJSON.loadJSON(json_reply)
if clef_accesstoken <> "" then
'Get single value
'clef_accesstoken = oJSON.data("access_token")
'Response.Write "<br>Access Token: " & clef_accesstoken & "<br>"


'For Each itm In oJSON.data("info")
    'response.write itm & ": " & oJSON.data("info").item(itm) & "</br>"
    
    ':: get users details from clef
    user_clef_id = oJSON.data("info").item("id")
    user_clef_email = oJSON.data("info").item("email")
    user_clef_name = oJSON.data("info").item("first_name")
    user_clef_lastname = oJSON.data("info").item("last_name")
'Next

'response.write "Clef ID: " & user_clef_id

end if

set objHttp = nothing


end if


':: CLEF PICK UP LOGIN HOOK

if user_clef_id <> "" then

':: do a query in our database and see if the user has an existing account
':: or tell them otherwise they cannot register with clef only login to existing accounts

Set Conns = Server.CreateObject("ADODB.Connection")
Conns.Open(my_conn)
set rsTS = Conns.Execute("select * from clef_users where (u_email = '" & user_clef_email & "' or clef_id = '" & user_clef_id & "')")

if rsTS.eof or rsTS.bof then
':: They do not exist so create a new user

executeSQL("INSERT INTO CLEF_USERS (u_name, u_email, clef_id) VALUES ('" & user_clef_name & " " & user_clef_lastname & "', '" & user_clef_email & "', '" & user_clef_id & "')")
session("login") = user_clef_id
response.redirect("default.asp")

else
':: LOGIN THE USER
session("login") = user_clef_id
response.redirect("default.asp")

end if
rsTS.close
set rsTS = nothing

':: DO A CLEF LOGIN OR HOOK
end if

%>
