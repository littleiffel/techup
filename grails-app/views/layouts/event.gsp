<%@ page import="lu.techup.Event" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
    <% if(eventInstance){ %>
      <title>${eventInstance?.name} on Techup.lu</title>
    <% } %>
    <meta name="description" content="${eventInstance?.name}">
    <meta name="author" content="littleiffel">
    <meta name="keywords" content="${ eventInstance?.tags?.collect{ it }?.join(',')}">
    <meta property="og:title" content="" />
    <meta property="og:type" content="" />
    <meta property="og:url" content="" />
    <meta property="og:image" content="http://www.techup.lu/images/logo-114.png" />
    <meta property="og:site_name" content="Techup.lu" />
    <meta property="fb:admins" content="603436077" />
	</head>
	<body>
    <g:layoutBody/>
	</body>
</html>
