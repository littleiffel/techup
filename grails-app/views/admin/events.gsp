
<%@ page import="lu.techup.Event" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-event" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create_event"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-event" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'event.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'event.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="url" title="${message(code: 'event.url.label', default: 'Url')}" />
					
						<g:sortableColumn property="twitterHandler" title="${message(code: 'event.twitterHandler.label', default: 'Twitter Handler')}" />
					
						<g:sortableColumn property="price" title="${message(code: 'event.price.label', default: 'Price')}" />
					
						<th><g:message code="event.venue.label" default="Venue" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${eventInstanceList}" status="i" var="eventInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show_event" id="${eventInstance.id}">${fieldValue(bean: eventInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: eventInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: eventInstance, field: "url")}</td>
					
						<td>${fieldValue(bean: eventInstance, field: "twitterHandler")}</td>
					
						<td>${fieldValue(bean: eventInstance, field: "price")}</td>
					
						<td>${fieldValue(bean: eventInstance, field: "venue")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${eventInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
