<%@ page import="lu.techup.Tag" %>



<div class="fieldcontain ${hasErrors(bean: tagInstance, field: 'events', 'error')} ">
	<label for="events">
		<g:message code="tag.events.label" default="Events" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: tagInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="tag.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${tagInstance?.name}"/>
</div>

