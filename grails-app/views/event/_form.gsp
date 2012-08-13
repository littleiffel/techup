<%@ page import="lu.techup.Event" %>

<div class="control-group fieldcontain span8 ${hasErrors(bean: eventInstance, field: 'name', 'error')} required">
	<label class="control-label" for="name"><g:message code="event.name.label" default="Event Name" /></label>
	<div class="controls">
		<g:textField name="name" value="${eventInstance?.name}" class="span8" required=""/>
	</div>
</div>

<div class="span10">
	<div class="row">
		<div class="control-group fieldcontain span4 ${hasErrors(bean: eventInstance, field: 'fromdate', 'error')} required">
			<label class="control-label" for="fromDate"><g:message code="event.fromDate.label" default="From" /></label>
			<div class="controls">
				<g:datePicker name="fromDate" precision="minute"  value="${eventInstance?.fromDate}" relativeYears="[0..2]"/>
			</div>
		</div>

		<div class="control-group fieldcontain span4 ${hasErrors(bean: eventInstance, field: 'toDate', 'error')} required">
			<label class="control-label" for="toDate"><g:message code="event.toDate.label" default="to" /></label>
			<div class="controls">
				<g:datePicker name="toDate" precision="minute"  value="${eventInstance?.toDate}" relativeYears="[0..2]"/>
			</div>
		</div>
	</div>
</div>


<div id="venue-form" class="span7">
	<div class="control-group fieldcontain ${hasErrors(bean: eventInstance, field: 'venue', 'error')}">
		<label class="control-label" for="venue"><g:message code="event.venue.label" default="Venue" /></label>
		<div class="controls">
			<g:select name="venue" from="${lu.techup.Venue.list()}" optionKey="id" value="${eventInstance?.venue?.id}" noSelection="['':'-Choose the Event venue-']" class="one-to-many" required="required"/>
		   <span class="help-inline">Venue does not exist? <a href="#" onclick="$('#venue-form').html($('#add-venue').html());$('#add-venue').remove();initializeForm()"><i class="icon-plus-sign"></i>Add new Venue</a>.</span>
		</div>
	</div>
</div>	

<div class="control-group fieldcontain span8 ${hasErrors(bean: eventInstance, field: 'description', 'error')} required">
	<label class="control-label" for="textarea"><g:message code="event.description.label" default="Description" /></label>
	<div class="controls wmd-panel">
		<div id="wmd-button-bar"></div>
		<g:textArea name="description" value="${eventInstance?.description}" rows="10"  id="wmd-input" class="span8 wmd-input" required=""/>
		<span class="help-inline">You can use <a href="http://daringfireball.net/projects/markdown/syntax">Markdown</a> for the description. <a href="#" onclick="$('#wmd-preview').toggle();return false;">Show/hide Preview</a></span>
		<div id="wmd-preview" class="wmd-panel wmd-preview" style="display:none;"> </div>
	</div>
</div>

<div class="control-group fieldcontain span8 ${hasErrors(bean: eventInstance, field: 'tags', 'error')} ">
	<label class="control-label" for="tags"><g:message code="event.tags.label" default="Tags" />	</label>
	<div class="controls">
		<ul id="tags" name="tags"></ul>
	</div>
</div>

<div class="span8">
	<div class="row">
		<div class="control-group fieldcontain span1 ${hasErrors(bean: eventInstance, field: 'price', 'error')}">
			<label class="control-label" for="price"><g:message code="event.price.label" default="Price" /></label>
			<div class="controls">
				<g:field type="number" name="price" step="0.01" value="${fieldValue(bean: eventInstance, field: 'price')}" placeholder="0 Euro" class="span1"/>
			</div>
		</div>
		<div class="control-group fieldcontain span3 ${hasErrors(bean: eventInstance, field: 'url', 'error')}">
			<label class="control-label" for="url"><g:message code="event.url.label" default="Event Url" /></label>
			<div class="controls">
				<g:field type="url" name="url" value="${eventInstance?.url}" class="span3"/>
			</div>
		</div>
		<div class="control-group fieldcontain span3 ${hasErrors(bean: eventInstance, field: 'hashtag', 'error')}">
			<label class="control-label" for="hashtag"><g:message code="event.hashtag.label" default="Hashtag" /></label>
			<div class="controls">
				<div class="input-prepend">
					<span class="add-on">#</span><g:textField name="hashtag" value="${eventInstance?.hashtag}" class="span2"/>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="span8">
	<div class="row">
		<div class="control-group fieldcontain span3 ${hasErrors(bean: eventInstance, field: 'twitterHandler', 'error')}">
			<label class="control-label" for="twitterHandler"><g:message code="event.hashtag.label" default="Event TwitterHandler" /></label>
			<div class="controls">
				<div class="input-prepend">
					<span class="add-on">@</span><g:textField name="twitterHandler" value="${eventInstance?.twitterHandler}" class="span2"/>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="control-group fieldcontain span10 ${hasErrors(bean: eventInstance, field: 'languages', 'error')} ">
	<label class="control-label" for="languages"><g:message code="event.languages.label" default="Languages" />	</label>
	<div class="controls">
	  <g:select name="languages" from="${lu.techup.Language.list()}" multiple="multiple" optionKey="id" size="4" value="${eventInstance?.languages*.id}" class="many-to-many"/>
	  <span class="help-inline">Use Ctrl to select more than one language.</span>
	</div>
</div>
