<%@ page import="lu.techup.Language" %>



<div class="fieldcontain ${hasErrors(bean: languageInstance, field: 'events', 'error')} ">
	<label for="events">
		<g:message code="language.events.label" default="Events" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: languageInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="language.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${languageInstance?.name}"/>
</div>

