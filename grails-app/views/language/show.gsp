<%@ page import="lu.techup.Language" %>
<head>
    <meta name="layout" content="main">
</head>
<body>
	<h1>Browse Events By Language: <span class="language-title">${languageInstance?.getName()}</span>&thinsp;<g:link controller="language" action="feed" id="${languageInstance?.getName()}"><img src="${resource( dir:'images', file:'feed.png')}" /></g:link></h1>
	<div class="tabbable">
	   <ul class="nav nav-tabs">
	  	   <li class="active"><a href="#1" data-toggle="tab">Upcoming (${instanceUpcomingCount?:0})</a></li>
	      <li><a href="#2" data-toggle="tab">Past (${instancePastCount?:0})</a></li>
	   </ul>
	   <div class="tab-content">
	      <div class="tab-pane active" id="1">
			   <g:each in="${upcomingEvents?.keySet().sort()}" status="i" var="dateInstance">
		    	   <g:render template="/event/date-item" model="[i:i, dateInstance:dateInstance, eventInstanceList:upcomingEvents.get(dateInstance).sort{!it.countAttendees()}]"/>
		  	   </g:each>
	      </div>
	      <div class="tab-pane" id="2">
	         <g:each in="${pastEvents?.keySet().sort()}" status="i" var="dateInstance">
	    	      <g:render template="/event/date-item" model="[i:i, dateInstance:dateInstance, eventInstanceList:pastEvents.get(dateInstance).sort{!it.countAttendees()}]"/>
	  	      </g:each>
	      </div>
	   </div>
	</div>
</body>