<%':: Include files such as config and functions %>
<!--#include file="json.asp"-->
<!--#include file="aspJSON1.17.asp" -->
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->

<html>

<head>
<meta http-equiv="Content-Language" content="en-gb">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Clef Classic ASP Integration</title>
<link href="css/custom-theme/jquery-ui-1.10.4.custom.css" rel="stylesheet">
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui-1.10.4.custom.js"></script>
<script>
 $(function() {
$( "#tabs" ).tabs();
});
function jaxClef()
{
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    if (xmlhttp.responseText=='logout')
    {
    document.location.href='../?func=logout';
    }
    else
    {
    //alert(xmlhttp.responseText);
    }
    }
  }
xmlhttp.open("GET","ajax.asp",true);
xmlhttp.send();
setTimeout(function(){jaxClef()},10000)
}

</script>
</head>

<body onload="setTimeout(function(){jaxClef()},10000);">
<div id="clef-wrapper">
<div align="center">
<table border="0" width="80%" cellpadding="3" class="ui-widget-content ui-corner-all">
	<tr class="ui-widget-header ui-corner-all">
		<td>
		<p align="center"><b><font face="Arial">Clef Login With Classic ASP</font></b></td>
	</tr>
	<tr>
		<td>

		<table border="0" width="100%" cellpadding="3">
			<tr>
				<td width="30%">
						<p align="center"><% dru = "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL") %>
<script data-type="login" data-redirect-url="<%=dru%>" data-style="button" data-color="blue" data-app-id="<%=clef_app%>" class="clef-button" src="https://clef.io/v3/clef.js" type="text/javascript"></script>
				</td>
				<td>
				<%
				Set bConn = Server.CreateObject("ADODB.Connection")
				bConn.Open(my_conn)
				
				set rsDB = bConn.Execute("select count(*) as CNTER from clef_users")
				
				total_users = rsDB("CNTER")
				
				rsDB.close
				set rsDB = nothing
				%>
				<p align="center"><font face="Arial" size="2"><b><%=total_users%> </b>users 
				have used this sample script to register or login with Clef.</font></p>
				<table border="0" width="100%" class="ui-widget-content ui-corner-all">
					<tr class="ui-widget-header ui-corner-all">
						<td>
						<p align="right"><font face="Arial" size="2">Members 
						Only Area<img border="0" src="images/Lock-Lock-icon.png" width="16" height="16" align="right"></font></td>
					</tr>
					<tr>
						<td>
						<%
						if session("login") <> "" then
						%>
						<div id="tabs">
<ul>
<li><a href="#tabs-1">Welcome</a></li>
<li><a href="#tabs-2">Main Functions</a></li>
<li><a href="#tabs-3">Support</a></li>
</ul>
<div id="tabs-1">
			<p align="center"><i><font face="Arial" size="2">Welcome to the members area.<br>
			To use this script on your own hosting server please note the 
			following instructions and requirements.</font></i><table border="0" width="100%" cellpadding="3">
				<tr>
					<td align="right" valign="top"><font face="Arial" size="2">Requirements :</font></td>
					<td>
					<ul>
						<li><font face="Arial" size="2">ASP Server</font></li>
						<li><font face="Arial" size="2">MySQL server</font></li>
						<li><font face="Arial" size="2">Write Permissions on 
						root folder</font></li>
						<li><font face="Arial" size="2">XMLHTTP</font></li>
					</ul>
					</td>
				</tr>
				<tr>
					<td align="right" valign="top"><font face="Arial" size="2">To Install 
					This Script :</font></td>
					<td>
					<ul>
						<li><font face="Arial" size="2">Create a blank MYSQL 
						database and user.</font></li>
						<li><font face="Arial" size="2">Unzip &amp; upload this 
						script to your desired location.</font></li>
						<li><font face="Arial" size="2">Run the script
						<a href="http://whereveryouuploaded.com/install.asp">
						http://whereveryouuploaded.com/install.asp</a> </font>
						</li>
						<li><font face="Arial" size="2">Fill out the details i.e 
						database and clef information.</font></li>
						<li><font face="Arial" size="2">Click Install and visit 
						your site <a href="http://whereveryouuploaded.com">
						http://whereveryouuploaded.com</a> </font></li>
					</ul>
					<p><i><b><font face="Arial" size="2">To Add extra pages to 
					the script:</font></b></i></p>
					<ul>
						<li><font face="Arial" size="2">Create a blank 
						YOURFILE.ASP page</font></li>
						<li><font face="Arial" size="2">Copy the INCLUDE files 
						at the top of <b>default.asp </b>into the top of your 
						new page</font></li>
						<li><font face="Arial" size="2">To hide members only 
						data use the string <b>if session(&quot;login&quot;) &lt;&gt; &quot;&quot; then</b></font></li>
					</ul>
					</td>
				</tr>
				<tr>
					<td align="right"><font face="Arial" size="2">Download Link 
					:</font></td>
					<td>
					<p align="center"><a href="clef_asp.zip">
					<img border="0" src="images/hard-drive-download.png" width="32" height="32"></a></td>
				</tr>
				<tr>
					<td align="right"><font face="Arial" size="2">Like Us on 
					Facebook :</font></td>
					<td>
					<p align="center">
					<a target="_blank" href="https://www.facebook.com/servwebtd1">
					<img border="0" src="images/facebook-icon.png" width="32" height="32"></a></td>
				</tr>
			</table>
</div>
<div id="tabs-2">
<table border="0" width="100%" cellpadding="3">
	<tr>
		<td><b><font face="Arial" size="2">The main functions we use to 
		integrate clef with classic ASP:-</font></b></td>
	</tr>
	<tr>
		<td><font face="Arial" size="2">To implement your CLEF button:</font><p align="center">
		<textarea rows="5" name="S1" cols="50"><script data-type="login" data-redirect-url="http://YOURURLHERE.COM" data-style="button" data-color="blue" data-app-id="YOUR_CLEFF_APP_ID" class="clef-button" src="https://clef.io/v3/clef.js" type="text/javascript"></script>
</textarea></p>
		<p align="left"><font face="Arial" size="2">To pickup a logout hook:<br>
		<br>
		</font><font face="Arial" size="1">if request(&quot;logout_token&quot;) &lt;&gt; &quot;&quot; then
		<font color="#FF0000"><b>'(CLEF sends a logout_token variable to our 
		server)</b></font><br>
		str = &quot;logout_token=&quot; &amp; request(&quot;logout_token&quot;) &amp; &quot;&amp;app_id=&quot; &amp; clef_app 
		&amp; &quot;&amp;app_secret=&quot; &amp; clef_secret<br>
		<br>
		<br>
		'set objHttp = Server.CreateObject(&quot;Msxml2.ServerXMLHTTP&quot;)<br>
		' set objHttp = Server.CreateObject(&quot;Msxml2.ServerXMLHTTP.4.0&quot;)<br>
		set objHttp = Server.CreateObject(&quot;Microsoft.XMLHTTP&quot;)<br>
		<br>
		objHttp.open &quot;POST&quot;, &quot;https://clef.io/api/v1/logout&quot;, false<br>
		objHttp.setRequestHeader &quot;Content-type&quot;, &quot;application/x-www-form-urlencoded&quot;<br>
		objHttp.Send str<br>
		<br>
		json_reply = objHttp.responseText<br>
		response.write json_reply<br>
		Set oJSON = New aspJSON<br>
		<br>
		'Load JSON string<br>
		oJSON.loadJSON(json_reply)<br>
		<br>
		'Get single value<br>
		clef_id = oJSON.data(&quot;clef_id&quot;) <font color="#FF0000"><b>'We grab the 
		clef_id from after we authenticate with CLEF</b></font><br>
		'// Do ANYTHING HERE WITH YOUR DATABASE USING CLEF_ID VARIABLE<br>
		end if</font></p>
		<p align="left"><font face="Arial" size="2">To handle login and 
		registrations</font><font face="Arial" size="1">:</font></p>
		<p align="left"><font face="Arial" size="1">':: CLEF PICK UP LOGIN HOOK<br>
		<br>
		if request(&quot;code&quot;) &lt;&gt; &quot;&quot; then <font color="#FF0000"><b>'WE GOT A OAUTH 
		CODE FROM CLEF LETS SAVE IT</b></font><br>
		clef_oauthcode = request(&quot;code&quot;)<br>
		else<br>
		clef_oauthcode = &quot;&quot;<br>
		end if<br>
		<br>
		if clef_oauthcode &lt;&gt; &quot;&quot; then<br>
		dru = &quot;http://&quot; &amp; Request.ServerVariables(&quot;SERVER_NAME&quot;) &amp; 
		Request.ServerVariables(&quot;URL&quot;) &amp; &quot;?logout=yes&quot;<br>
		<br>
		str = &quot;code=&quot; &amp; clef_oauthcode &amp; &quot;&amp;app_id=&quot; &amp; clef_app &amp; &quot;&amp;app_secret=&quot; 
		&amp; clef_secret &amp; &quot;&amp;logout_hook=&quot; &amp; dru<br>
		<br>
		'set objHttp = Server.CreateObject(&quot;Msxml2.ServerXMLHTTP&quot;)<br>
		' set objHttp = Server.CreateObject(&quot;Msxml2.ServerXMLHTTP.4.0&quot;)<br>
		set objHttp = Server.CreateObject(&quot;Microsoft.XMLHTTP&quot;)<br>
		objHttp.open &quot;POST&quot;, &quot;https://clef.io/api/v1/authorize&quot;, false<br>
		objHttp.setRequestHeader &quot;Content-type&quot;, &quot;application/x-www-form-urlencoded&quot;<br>
		objHttp.Send str<br>
		<br>
		json_reply = objHttp.responseText<br>
		'response.write json_reply<br>
		<br>
		Set oJSON = New aspJSON<br>
		<br>
		'Load JSON string<br>
		oJSON.loadJSON(json_reply)<br>
		<br>
		'Get single value<br>
		clef_accesstoken = oJSON.data(&quot;access_token&quot;)<br>
		'Response.Write &quot;&lt;br&gt;Access Token: &quot; &amp; clef_accesstoken &amp; &quot;&lt;br&gt;&quot;<br>
		set objHttp = nothing</font></p>
		<p align="left"><font face="Arial" size="1">'// <font color="#FF0000">
		<b>WE SAVED OUR ACCESS TOKEN AS VARIABLE CLEF_ACCESSTOKEN</b></font><br>
		<br>
		'set objHttp = Server.CreateObject(&quot;Msxml2.ServerXMLHTTP&quot;)<br>
		' set objHttp = Server.CreateObject(&quot;Msxml2.ServerXMLHTTP.4.0&quot;)<br>
		set objHttp = Server.CreateObject(&quot;Microsoft.XMLHTTP&quot;)<br>
		objHttp.open &quot;GET&quot;, &quot;https://clef.io/api/v1/info?access_token=&quot; &amp; 
		clef_accesstoken, false<br>
		'objHttp.setRequestHeader &quot;Content-type&quot;, &quot;application/x-www-form-urlencoded&quot;<br>
		objHttp.Send<br>
		<br>
		json_reply = objHttp.responseText<br>
		'response.write json_reply<br>
		<br>
		<br>
		oJSON.loadJSON(json_reply)<br>
		if clef_accesstoken &lt;&gt; &quot;&quot; then<br>
		'Get single value<br>
		'clef_accesstoken = oJSON.data(&quot;access_token&quot;)<br>
		'Response.Write &quot;&lt;br&gt;Access Token: &quot; &amp; clef_accesstoken &amp; &quot;&lt;br&gt;&quot;<br>
		<br>
		<br>
		'For Each itm In oJSON.data(&quot;info&quot;)<br>
		'response.write itm &amp; &quot;: &quot; &amp; oJSON.data(&quot;info&quot;).item(itm) &amp; &quot;&lt;/br&gt;&quot;<br>
		<br>
		':: get users details from clef </font></p>
		<p align="left"><font face="Arial" size="1">'// <font color="#FF0000">
		<b>SAVE USER DETAILS FROM CLEF AS VARIABLES</b></font><br>
		<font color="#FF0000"><b>user_clef_id</b></font> = 
		oJSON.data(&quot;info&quot;).item(&quot;id&quot;)<br>
		<font color="#FF0000"><b>user_clef_email </b></font>= 
		oJSON.data(&quot;info&quot;).item(&quot;email&quot;)<br>
		<font color="#FF0000"><b>user_clef_name</b></font> = 
		oJSON.data(&quot;info&quot;).item(&quot;first_name&quot;)<br>
		<font color="#FF0000"><b>user_clef_lastname</b></font> = 
		oJSON.data(&quot;info&quot;).item(&quot;last_name&quot;)<br>
		'Next<br>
		<br>
		'response.write &quot;Clef ID: &quot; &amp; user_clef_id<br>
		<br>
		end if<br>
		<br>
		set objHttp = nothing<br>
		<br>
		<br>
		end if<br>
		<br>
		<br>
		':: CLEF PICK UP LOGIN HOOK<br>
		<br>
		if user_clef_id &lt;&gt; &quot;&quot; then</font></p>
		<p align="left"><font face="Arial" size="1">'// DO WHAT YOU WANT HERE 
		WITH OUR CLEF VARIABLES LIKE QUERY DB ETC</font></p>
		<p align="left"><font face="Arial" size="1">end if<br>
		</font><font face="Arial" size="2"><br>
&nbsp;</font></p>

		</td>
	</tr>
</table>
</div>
<div id="tabs-3">
<p align="center"><font face="Arial" size="2">We are happy to help those in need to integrate CLEF into there own custom scripts, simply drop us an email to 
<i><b>support@serv-web.co.uk</b></i> </font>
</div>
</div>
			</td>
		</tr>
		</table>
						<%
						else
						%>
						<table border="0" width="100%" cellpadding="3">
							<tr>
								<td colspan="2"><i><b>
								<font face="Arial" size="2">With This Script You 
								Can:-</font></b></i></td>
							</tr>
							<tr>
								<td align="center"><font face="Arial" size="2">
								<img border="0" src="images/check.png" width="32" height="32"></font></td>
								<td><font face="Arial" size="2">Use The 
								Auto-Installer (install.asp)</font></td>
							</tr>
							<tr>
								<td align="center"><font face="Arial" size="2">
								<img border="0" src="images/check.png" width="32" height="32"></font></td>
								<td><font face="Arial" size="2">Create your own 
								configuration file.</font></td>
							</tr>
							<tr>
								<td align="center"><font face="Arial" size="2">
								<img border="0" src="images/check.png" width="32" height="32"></font></td>
								<td><font face="Arial" size="2">Populate your 
								blank database with the required user tables</font></td>
							</tr>
							<tr>
								<td align="center"><font face="Arial" size="2">
								<img border="0" src="images/check.png" width="32" height="32"></font></td>
								<td><font face="Arial" size="2">Link CLEF login 
								to your users database</font></td>
							</tr>
						</table>
						<h2 align="center"><font face="Arial" size="2">Please 
						Login!<br>
						<br>
												When you 
						use CLEF to login or register you will see what's inside 
						the members area.<br>
						<br>
						<img border="0" src="images/clef-blue-16x16.png" width="16" height="16">
						<a target="_blank" href="https://getclef.com/">Check out 
						the Clef Website </a></font>
						<% end if %>
						</h2>
						</td>
					</tr>
				</table>
				</td>
			</tr>
</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>

</html>