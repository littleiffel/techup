
<%@ page import="lu.techup.Venue" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'venue.label', default: 'Venue')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-venue" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="venues"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create_venue"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-venue" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list venue">
			
				<g:if test="${venueInstance?.homepage}">
				<li class="fieldcontain">
					<span id="homepage-label" class="property-label"><g:message code="venue.homepage.label" default="Homepage" /></span>
					
						<span class="property-value" aria-labelledby="homepage-label"><g:fieldValue bean="${venueInstance}" field="homepage"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.verified}">
				<li class="fieldcontain">
					<span id="verified-label" class="property-label"><g:message code="venue.verified.label" default="Verified" /></span>
					
						<span class="property-value" aria-labelledby="verified-label"><g:formatBoolean boolean="${venueInstance?.verified}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.adress}">
				<li class="fieldcontain">
					<span id="adress-label" class="property-label"><g:message code="venue.adress.label" default="Adress" /></span>
					
						<span class="property-value" aria-labelledby="adress-label"><g:fieldValue bean="${venueInstance}" field="adress"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.events}">
				<li class="fieldcontain">
					<span id="events-label" class="property-label"><g:message code="venue.events.label" default="Events" /></span>
					
						<g:each in="${venueInstance.events}" var="e">
						<span class="property-value" aria-labelledby="events-label"><g:link controller="event" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.lat}">
				<li class="fieldcontain">
					<span id="lat-label" class="property-label"><g:message code="venue.lat.label" default="Lat" /></span>
					
						<span class="property-value" aria-labelledby="lat-label"><g:fieldValue bean="${venueInstance}" field="lat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.lon}">
				<li class="fieldcontain">
					<span id="lon-label" class="property-label"><g:message code="venue.lon.label" default="Lon" /></span>
					
						<span class="property-value" aria-labelledby="lon-label"><g:fieldValue bean="${venueInstance}" field="lon"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${venueInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="venue.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${venueInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${venueInstance?.id}" />
					<g:link class="edit" action="edit_venue" id="${venueInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete_venue" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
