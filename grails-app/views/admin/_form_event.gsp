<%@ page import="lu.techup.Event" %>



<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="event.name.label" default="Name" />
		
	</label>
	<g:textField name="name" maxlength="140" value="${eventInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="event.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="2000" value="${eventInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'url', 'error')} ">
	<label for="url">
		<g:message code="event.url.label" default="Url" />
		
	</label>
	<g:field type="url" name="url" value="${eventInstance?.url}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'twitterHandler', 'error')} ">
	<label for="twitterHandler">
		<g:message code="event.twitterHandler.label" default="Twitter Handler" />
		
	</label>
	<g:textField name="twitterHandler" value="${eventInstance?.twitterHandler}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'price', 'error')} ">
	<label for="price">
		<g:message code="event.price.label" default="Price" />
		
	</label>
	<g:field type="number" name="price" step="0.01" value="${fieldValue(bean: eventInstance, field: 'price')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'attendees', 'error')} ">
	<label for="attendees">
		<g:message code="event.attendees.label" default="Attendees" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'venue', 'error')} ">
	<label for="venue">
		<g:message code="event.venue.label" default="Venue" />
		
	</label>
	<g:select id="venue" name="venue.id" from="${lu.techup.Venue.list()}" optionKey="id" value="${eventInstance?.venue?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'hidden', 'error')} ">
	<label for="hidden">
		<g:message code="event.hidden.label" default="Hidden" />
		
	</label>
	<g:checkBox name="hidden" value="${eventInstance?.hidden}" />
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'fromDate', 'error')} required">
	<label for="fromDate">
		<g:message code="event.fromDate.label" default="From Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fromDate" precision="minute"  value="${eventInstance?.fromDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'hashtag', 'error')} ">
	<label for="hashtag">
		<g:message code="event.hashtag.label" default="Hashtag" />
		
	</label>
	<g:textField name="hashtag" value="${eventInstance?.hashtag}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'initiator', 'error')} required">
	<label for="initiator">
		<g:message code="event.initiator.label" default="Initiator" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="initiator" name="initiator.id" from="${lu.techup.User.list()}" optionKey="id" required="" value="${eventInstance?.initiator?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'languages', 'error')} ">
	<label for="languages">
		<g:message code="event.languages.label" default="Languages" />
		
	</label>
	<g:select name="languages" from="${lu.techup.Language.list()}" multiple="multiple" optionKey="id" size="5" value="${eventInstance?.languages*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'tags', 'error')} ">
	<label for="tags">
		<g:message code="event.tags.label" default="Tags" />
		
	</label>
	<g:select name="tags" from="${lu.techup.Tag.list()}" multiple="multiple" optionKey="id" size="5" value="${eventInstance?.tags*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'toDate', 'error')} required">
	<label for="toDate">
		<g:message code="event.toDate.label" default="To Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="toDate" precision="minute"  value="${eventInstance?.toDate}"  />
</div>

