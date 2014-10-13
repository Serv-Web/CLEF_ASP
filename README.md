CLEF_ASP
========

CLEF AUTHENTICATION USING CLASSIC ASP AND MYSQL

To use this script on your own hosting server please note the following instructions and requirements.
Requirements :	
ASP Server
MySQL server
Write Permissions on root folder
XMLHTTP

To Install This Script :

Create a blank MYSQL database and user.

Unzip & upload this script to your desired location.

Run the script http://whereveryouuploaded.com/install.asp

Fill out the details i.e database and clef information.

Click Install and visit your site http://whereveryouuploaded.com

- To Add extra pages to the script:

Create a blank YOURFILE.ASP page

Copy the INCLUDE files at the top of default.asp into the top of your new page

<!--#include file="json.asp"-->
<!--#include file="aspJSON1.17.asp" -->
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->

To hide members only data use the string:=

if session("login") <> "" then
':: do something here as a user is logged in
else
':: do something here is user is NOT logged in.
end if
