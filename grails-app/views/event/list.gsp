<%@ page import="lu.techup.Event" %>
<g:applyLayout name="event">
   <div id="list-event" class="content scaffold-list" role="main">
      <g:each in="${eventInstanceMap?.keySet().sort()}" status="i" var="dateInstance">
         <g:render template="/event/date-item" model="[i:i, dateInstance:dateInstance, eventInstanceList:eventInstanceMap.get(dateInstance).sort{!it.countAttendees()}]"/>
      </g:each>
   </div>
</g:applyLayout>

