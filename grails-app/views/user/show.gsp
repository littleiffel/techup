<%@ page import="lu.techup.Language" %>
<head>
    <meta name="layout" content="main">
</head>
<body>
   <section class="user">
      <div class="user-icon">
         <a href="#" class="twitter-anywhere-user hovercard" alt="${userInstance?.encodeAsHTML()}" style="display:block;width:48px;height:48px;background:url(http://twitter.com/api/users/profile_image/${userInstance?.encodeAsHTML()})">
            <span style="position:absolute; left:-3000px;">${userInstance?.encodeAsHTML()}</span>
         </a>
         <% if(privateUser){ %>
            <g:link controller="user" action="show" id="${userInstance.id}" params="[format:'ical']" title="iCal for Events attended by ${userInstance.encodeAsHTML()}"><img src="${resource( dir:'images', file:'ical_64.png')}" /></g:link>
         <% } %>
      </div>
      <div class="title">@${userInstance?.getUsername()}</div>
      <ul class="tags">
         <g:each in="${tags.sort(){it.name}}" var="t">
            <li>
               <g:link controller="tag" action="show" id="${t.getName()}" class="tag">
                  ${t?.name?.encodeAsHTML()}
               </g:link>
            </li>
         </g:each>
      </ul>
   </section>

   <div class="tabbable">
      <ul class="nav nav-tabs">
         <li class="active"><a href="#1" data-toggle="tab">Attending (${instanceUpcomingCount?:0})</a></li>
         <li><a href="#2" data-toggle="tab">Attended (${instancePastCount?:0})</a></li>
         <li><a href="#3" data-toggle="tab">Submitted (${submittedCount?:0})</a></li>
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
         <div class="tab-pane" id="3">
            <g:each in="${submittedEvents?.keySet().sort()}" status="i" var="dateInstance">
               <g:render template="/event/date-item" model="[i:i, dateInstance:dateInstance, eventInstanceList:submittedEvents.get(dateInstance).sort{!it.countAttendees()}]"/>
            </g:each>
         </div>
      </div>
   </div>
</body>