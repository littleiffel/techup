
<%@ page import="lu.techup.Event" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-event" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="events"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create_event"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-event" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list event">
			
				<g:if test="${eventInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="event.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${eventInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="event.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${eventInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.url}">
				<li class="fieldcontain">
					<span id="url-label" class="property-label"><g:message code="event.url.label" default="Url" /></span>
					
						<span class="property-value" aria-labelledby="url-label"><g:fieldValue bean="${eventInstance}" field="url"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.twitterHandler}">
				<li class="fieldcontain">
					<span id="twitterHandler-label" class="property-label"><g:message code="event.twitterHandler.label" default="Twitter Handler" /></span>
					
						<span class="property-value" aria-labelledby="twitterHandler-label"><g:fieldValue bean="${eventInstance}" field="twitterHandler"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="event.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${eventInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.attendees}">
				<li class="fieldcontain">
					<span id="attendees-label" class="property-label"><g:message code="event.attendees.label" default="Attendees" /></span>
					
						<g:each in="${eventInstance.attendees}" var="a">
						<span class="property-value" aria-labelledby="attendees-label"><g:link controller="user" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.venue}">
				<li class="fieldcontain">
					<span id="venue-label" class="property-label"><g:message code="event.venue.label" default="Venue" /></span>
					
						<span class="property-value" aria-labelledby="venue-label"><g:link controller="venue" action="show" id="${eventInstance?.venue?.id}">${eventInstance?.venue?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.hidden}">
				<li class="fieldcontain">
					<span id="hidden-label" class="property-label"><g:message code="event.hidden.label" default="Hidden" /></span>
					
						<span class="property-value" aria-labelledby="hidden-label"><g:formatBoolean boolean="${eventInstance?.hidden}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.fromDate}">
				<li class="fieldcontain">
					<span id="fromDate-label" class="property-label"><g:message code="event.fromDate.label" default="From Date" /></span>
					
						<span class="property-value" aria-labelledby="fromDate-label"><g:formatDate date="${eventInstance?.fromDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.hashtag}">
				<li class="fieldcontain">
					<span id="hashtag-label" class="property-label"><g:message code="event.hashtag.label" default="Hashtag" /></span>
					
						<span class="property-value" aria-labelledby="hashtag-label"><g:fieldValue bean="${eventInstance}" field="hashtag"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.initiator}">
				<li class="fieldcontain">
					<span id="initiator-label" class="property-label"><g:message code="event.initiator.label" default="Initiator" /></span>
					
						<span class="property-value" aria-labelledby="initiator-label"><g:link controller="user" action="show" id="${eventInstance?.initiator?.id}">${eventInstance?.initiator?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.languages}">
				<li class="fieldcontain">
					<span id="languages-label" class="property-label"><g:message code="event.languages.label" default="Languages" /></span>
					
						<g:each in="${eventInstance.languages}" var="l">
						<span class="property-value" aria-labelledby="languages-label"><g:link controller="language" action="show" id="${l.getName()}">${l?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.tags}">
				<li class="fieldcontain">
					<span id="tags-label" class="property-label"><g:message code="event.tags.label" default="Tags" /></span>
					
						<g:each in="${eventInstance.tags}" var="t">
						<span class="property-value" aria-labelledby="tags-label"><g:link controller="tag" action="show" id="${t.getName()}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.toDate}">
				<li class="fieldcontain">
					<span id="toDate-label" class="property-label"><g:message code="event.toDate.label" default="To Date" /></span>
					
						<span class="property-value" aria-labelledby="toDate-label"><g:formatDate date="${eventInstance?.toDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${eventInstance?.id}" />
					<g:link class="edit" action="edit_event" id="${eventInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete_event" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
