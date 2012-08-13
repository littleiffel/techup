<%@ page import="lu.techup.Event" %>
<head>
    <meta name="layout" content="main">
    <script type="text/javascript" src="${resource(dir: 'js', file: 'Markdown.Sanitizer.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'Markdown.Editor.js')}"></script>
</head>
<body>
  <style type="text/css">
    #map_canvas {
      height: 250px;
      width: 400px;
      margin-top: 0.6em;
    }
  </style>
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
          ${eventInstance?.tags.collect{"'"+it+"'}"}.join(',')}
        ]
      });
    });
  </script>

  <div id="event-form" class="">
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

		<g:form action="save" class="form-vertical" >
			<fieldset class="form">
				<g:render template="form"/>
        <div class="span8">
				  <g:submitButton name="create" class="save btn btn-primary" value="${message(code: 'default.button.event.submit.label', default: 'Submit Event')}" />
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

