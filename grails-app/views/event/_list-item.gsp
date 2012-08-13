<section class="event">
   <div class="title">
		<g:link controller="event" action="show" id="${eventInstance.id}">${fieldValue(bean: eventInstance, field: "name")}</g:link>
   </div>   
	<div class="time">
		<% if(eventInstance.cancelled){ %>
			<span class="cancelled">Event Cancelled</span>
		<%	} else { 
			   if(g.formatDate(type:"date", date:eventInstance?.fromDate) == g.formatDate(type:"date", date:eventInstance?.toDate)){ %>
					<span class="format-time">
						${eventInstance?.fromDate.format('HH:mm a')}
					</span> - 
					<span class="format-time">
						${eventInstance?.toDate.format('HH:mm a')}
					</span>
			<% }else{ %>
					<span class="format-day">
						${eventInstance?.fromDate.format('MM/dd/yy')}
					</span> - 
					<span class="format-day">
						${eventInstance?.toDate.format('MM/dd/yy')}
					</span>
			<% } 
			} %>
	</div>	
	<g:if test="${eventInstance?.attendees}">	
		<ul class="event-attendees" style="margin:0;">
			<g:each in="${eventInstance.attendees?.sort{ it.getUsername() }}" var="u">
	        <li style="display:block;margin: 0 4px 4px 0;float:left;">
	      		<g:link controller="user" action="show" id="${u?.id}" alt="${u?.encodeAsHTML()}" class="hovercard" style="display:block;width:24px;height:24px;background:url(http://twitter.com/api/users/profile_image/${u?.encodeAsHTML()}?size=mini)">
						<span style="position:absolute; left:-3000px;">${u?.encodeAsHTML()}</span>
					</g:link>
				</li>
	   	</g:each> 
	   </ul>
	</g:if>
	<ul class="tags">
		<g:if test="${eventInstance?.venue}">
      	<li>
      		<g:link controller="venue" action="show" id="${eventInstance.venue.id}" class="venue">
		   		<g:fieldValue bean="${eventInstance}" field="venue"/>
	   		</g:link>
	   	</li>
	   </g:if>
		<g:if test="${eventInstance?.price}">
			<li>
				<span class="price"><g:fieldValue bean="${eventInstance}" field="price"/>&thinsp;&euro;</span>
			</li>
	   </g:if>
		<g:each in="${eventInstance.tags.sort(){it.name}}" var="t">
		   <li>
		   	<g:link controller="tag" action="show" id="${t.getName()}" class="tag">
            	${t?.name?.encodeAsHTML()}
         	</g:link>
      	</li>
		</g:each>
	   <g:each in="${eventInstance.languages.sort(){it.name}}" var="t">
	      <li>
	      	<g:link controller="language" action="show" id="${t.getName()}" class="language">
	        		${t?.name?.encodeAsHTML()}
	        	</g:link>
         </li>
	   </g:each>
   </ul>
</section>