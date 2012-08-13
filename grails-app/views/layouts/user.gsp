
<%@ page import="lu.techup.Event" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
    <header class="jumbotron subhead" id="overview">
      <h1>User: ${userInstance?.getUsername()}</h1>
      <a href="#" class="twitter-anywhere-user" style="display:block;width:48px;height:48px;background:url(http://twitter.com/api/users/profile_image/${userInstance?.encodeAsHTML()})">
        <span style="position:absolute; left:-3000px;">${userInstance?.encodeAsHTML()}</span>
      </a>
    </header>
		<div id="list-event" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
  			<div class="alert ${flash?.class}" role="status">
          <a class="close" data-dismiss="alert">×</a>
          ${flash.message}
        </div>
			</g:if>
      <g:layoutBody/>
		</div>
	</body>
</html>
