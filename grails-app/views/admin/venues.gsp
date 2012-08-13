
<%@ page import="lu.techup.Venue" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'venue.label', default: 'Venue')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-venue" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create_venue"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-venue" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="homepage" title="${message(code: 'venue.homepage.label', default: 'Homepage')}" />
					
						<g:sortableColumn property="verified" title="${message(code: 'venue.verified.label', default: 'Verified')}" />
					
						<g:sortableColumn property="adress" title="${message(code: 'venue.adress.label', default: 'Adress')}" />
					
						<g:sortableColumn property="lat" title="${message(code: 'venue.lat.label', default: 'Lat')}" />
					
						<g:sortableColumn property="lon" title="${message(code: 'venue.lon.label', default: 'Lon')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'venue.name.label', default: 'Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${venueInstanceList}" status="i" var="venueInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show_venue" id="${venueInstance.id}">${fieldValue(bean: venueInstance, field: "homepage")}</g:link></td>
					
						<td><g:formatBoolean boolean="${venueInstance.verified}" /></td>
					
						<td>${fieldValue(bean: venueInstance, field: "adress")}</td>
					
						<td>${fieldValue(bean: venueInstance, field: "lat")}</td>
					
						<td>${fieldValue(bean: venueInstance, field: "lon")}</td>
					
						<td>${fieldValue(bean: venueInstance, field: "name")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${venueInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
