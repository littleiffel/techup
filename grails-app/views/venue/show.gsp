<%@ page import="lu.techup.Venue" %>
<g:applyLayout name="venue">
	<section class="venue">
		<div class="venue-meta">
			<div class="title">
				<g:fieldValue bean="${venueInstance}" field="name"/>
			</div>
			<% if(venueInstance?.verified){ %>
				<i class="icon-ok-circle"></i>&thinsp;verified location
			<% } else { %>
				<i class="icon-time"></i>&thinsp;location not verified yet
			<% } %>
			<br/>
			<g:link url="${venueInstance.getHomepage()}"><g:fieldValue bean="${venueInstance}" field="homepage"/></g:link>
			<br/>
			<g:fieldValue bean="${venueInstance}" field="adress"/>
		</div>
		<a href="http://maps.google.com/maps?q=${venueInstance?.getName()}&ll=${venueInstance?.lat},${venueInstance?.lon}&spn=0.123682,0.338173&ctz=-120&t=h&z=16">
			<img src="http://maps.googleapis.com/maps/api/staticmap?center=${venueInstance?.lat},%20${venueInstance?.lon}&zoom=14&size=400x300&maptype=terrain&sensor=false&markers=color:blue%7C${venueInstance?.lat},%20${venueInstance?.lon}"/>
		</a>
	</section>
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
</g:applyLayout>
