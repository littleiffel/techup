<%@ page import="lu.techup.Event" %>
<head>
    <meta name="layout" content="main">
</head>
<body>
	<script>
		$(document).ready(function(){
			$("#tags").tagit({
				select:true,
				highlightOnExistColor: '#ef3',
				tagSource: [
					//${techuptags.collect{"{value:"+it.id+", label:'"+it+"'}"}.join(',')} 
					${techuptags.collect{"'"+it+"'"}.join(',')} 
					//{value:1, label:'monster'}, {value:2, label:'java'}
				],
				initialTags: [
					//${eventInstance?.tags.collect{"{value:"+it.id+", label:'"+it+"'}"}.join(',')}
					${eventInstance?.tags.collect{"'"+it+"'"}.join(',')}
				]
			});
		});
	</script>

	<div id="event-form" class="row">
		<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${eventInstance}">
		   <div class="alert alert-error" role="status">
        <a class="close" data-dismiss="alert">×</a>
				<ul class="errors" role="alert">
					<g:eachError bean="${eventInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
		   </div>
		</g:hasErrors>
		<g:form method="post" class="form-vertical">
			<g:hiddenField name="id" value="${eventInstance?.id}" />
			<g:hiddenField name="version" value="${eventInstance?.version}" />
			<fieldset class="form">
				<g:render template="form"/>
				<div class="span8">
					<g:actionSubmit class="save btn-large btn-primary" action="update" value="${message(code: 'default.button.update.labe', default: 'Update')}" />
					<g:actionSubmit class="delete btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete Event')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</div>
			</fieldset>
		</g:form>
	</div>

	<div class="template row" id="add-venue" style="display:none;">
		<g:render template="addVenue" model="[venueInstance:venueInstance]"/>
	</div>
   <script>
      (function () {
         var converter1 = Markdown.getSanitizingConverter();
         var editor1 = new Markdown.Editor(converter1);
         editor1.run();
      })();
   </script>
</body>
