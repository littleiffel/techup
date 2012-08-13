<%@ page import="lu.techup.Venue" %>



<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'homepage', 'error')} ">
	<label for="homepage">
		<g:message code="venue.homepage.label" default="Homepage" />
		
	</label>
	<g:field type="url" name="homepage" value="${venueInstance?.homepage}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'verified', 'error')} ">
	<label for="verified">
		<g:message code="venue.verified.label" default="Verified" />
		
	</label>
	<g:checkBox name="verified" value="${venueInstance?.verified}" />
</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'adress', 'error')} ">
	<label for="adress">
		<g:message code="venue.adress.label" default="Adress" />
		
	</label>
	<g:textField name="adress" maxlength="200" value="${venueInstance?.adress}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'events', 'error')} ">
	<label for="events">
		<g:message code="venue.events.label" default="Events" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${venueInstance?.events?}" var="e">
    <li><g:link controller="admin" action="show_venue" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="admin" action="create_venue" params="['venue.id': venueInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'event.label', default: 'Event')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'lat', 'error')} required">
	<label for="lat">
		<g:message code="venue.lat.label" default="Lat" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="lat" required="" value="${fieldValue(bean: venueInstance, field: 'lat')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'lon', 'error')} required">
	<label for="lon">
		<g:message code="venue.lon.label" default="Lon" />
		<span class="required-indicator">*</span>
	</label>
	<g:field  name="lon" required="" value="${fieldValue(bean: venueInstance, field: 'lon')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: venueInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="venue.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${venueInstance?.name}"/>
</div>

