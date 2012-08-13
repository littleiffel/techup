<%@ page import="lu.techup.Event" %>
<g:applyLayout name="event">
	<div id="show-event" class="">
		<div class="informations span8">
			<div class="title">
				${fieldValue(bean: eventInstance, field: "name")}
				<% if(eventInstance.cancelled){ %>
				<span class="cancelled">Event Cancelled</span>
				<%	} %>
		   </div>
		   <g:if test="${eventInstance?.twitterHandler}">
			   <div class="event-twitterHandler">
					<li style="display:block;margin: 13px 5px 5px 0;">
		      		<a href="https://www.twitter.com/#!/${eventInstance.twitterHandler}" alt="${eventInstance?.twitterHandler?.encodeAsHTML()}" class="hovercard twitter-anywhere-user" style="display:block;width:48px;height:48px;background:url(http://twitter.com/api/users/profile_image/${eventInstance?.twitterHandler?.encodeAsHTML()})">
							<span style="position:absolute; left:-3000px;">${eventInstance?.twitterHandler?.encodeAsHTML()}</span>
						</a>
					</li>
				</div>
			</g:if>
		   <div class="subtitle">
		   	<div class="submitter">
					submitted by <techup:twitteruser user="${eventInstance?.initiator?.username}"/>
				</div>
			   <span class="datetime">
			   	<span class="format-day-time">${eventInstance?.fromDate.format('MM/dd/yy')} ${eventInstance?.fromDate.format('HH:mm')}</span> to 
					<% if (g.formatDate(date:eventInstance.fromDate, type:'date') == g.formatDate(date:eventInstance.toDate, type:'date')) { %>
						<span class="format-time">${eventInstance?.toDate.format('HH:mm a')}</span>
					<% }else{ %>
						<span class="format-day-time">${eventInstance?.toDate.format('MM/dd/yy')} ${eventInstance?.toDate.format('HH:mm')}</span>
					<% } %>
				</span>	
				
				<g:if test="${eventInstance?.url}">
					<br>
					<span class="homepage">
						<a href="${eventInstance.url}" title="${eventInstance.url}"><g:fieldValue bean="${eventInstance}" field="url"/></a>
					</span>
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
			</div>
			<div class="format-markdown description"><g:fieldValue bean="${eventInstance}" field="description"/></div>
		</div>

		<div class="sidebar span3">
			<div class="location">
				<a href="http://maps.google.com/maps?q=${eventInstance?.getVenue().getName()}&ll=${eventInstance?.getVenue()?.lat},${eventInstance?.getVenue()?.lon}&spn=0.123682,0.338173&ctz=-120&t=h&z=16"><img src="http://maps.googleapis.com/maps/api/staticmap?center=${eventInstance?.getVenue()?.lat},%20${eventInstance?.getVenue()?.lon}&zoom=14&size=250x150&maptype=terrain&sensor=false&markers=color:blue%7C${eventInstance?.getVenue()?.lat},%20${eventInstance?.getVenue()?.lon}"/></a>
			</div>
			<ul class="social interactions">
				<li><a href="//twitter.com/share" class="twitter-share-button" data-url="http://www.techup.lu/${eventInstance?.id}" data-via="techup_lu" data-related="techup_lu" data-count="vertical" data-hashtags="${eventInstance?.hashtag?:''}" data-dnt="true">Tweet</a></li>
				<li><div class="fb-like" data-send="false" data-layout="box_count" data-width="50" data-show-faces="true" data-font="arial"></div></li>
			</ul>
			<ul class="interactions">
				<g:if test="${eventInstance?.attendees*.id.contains( user?.id )}">
					<li><g:link controller="user" action="unattend" id="${eventInstance?.id}" class="btn btn-danger"><i class="icon-user icon-white"></i>&thinsp;<g:message code="techup.button.unattend" default="Unattend"/></g:link></li>
				</g:if>
				<g:else>
					<li><g:link controller="user" action="attend" id="${eventInstance?.id}" class="btn btn-success"><i class="icon-user icon-white"></i>&thinsp;<g:message code="techup.button.attend" default="Attend"/></g:link></li>
				</g:else>
			</ul>
			<g:if test="${editable}">
				<ul class="admin-actions">
					<li><g:link class="btn edit" action="edit" id="${eventInstance?.id}"><i class="icon-edit"></i>&thinsp;<g:message code="default.button.edit.label" default="Edit" /></g:link></li>
					<li><g:link class="btn toggle" action="toggle" id="${eventInstance?.id}">
						<% if(!eventInstance?.hidden){ %>
							<i class="icon-eye-open"></i>&thinsp;<g:message code="default.button.hide.label" default="Hide Event" />
						<% }else{ %>
							<i class="icon-eye-open"></i>&thinsp;<g:message code="default.button.publish.label" default="Publish Event" />
						<% } %>
					</g:link></li>
					<li>
						<% if(!eventInstance?.cancelled){ %>
							<g:link class="btn btn-inverse" action="cancel" id="${eventInstance?.id}"><i class="icon-flag icon-white"></i>&thinsp;<g:message code="default.button.hide.label" default="Cancel" /></g:link>
						<% }else{ %>
							<g:link class="btn btn-inverse" action="uncancel" id="${eventInstance?.id}"><i class="icon-flag icon-white"></i>&thinsp;<g:message code="default.button.publish.label" default="Uncancel" /></g:link>
						<% } %>
					</li>
				</ul>	
			</g:if>
		   <div class="event-attendees-wrapper">
				<% if(eventInstance?.attendees?.size() > 0){ 
					if(eventInstance?.toDate < new Date()){ %>
						${eventInstance?.attendees.size()==1?"1 person attended":eventInstance?.attendees.size()+" persons attended"}
					<% }else{ %>
						${eventInstance?.attendees.size()==1?"1 person is attending":eventInstance?.attendees.size()+" persons are attending"} 		
					<% } %>
						<ul id="event-attendees" style="margin:0;">
							<g:each in="${eventInstance.attendees?.sort{ it.getUsername()}}" var="u">
					        <li style="display:block;">
					      		<g:link controller="user" action="show" id="${u?.id}" alt="${u?.encodeAsHTML()}" class="hovercard twitter-anywhere-user" style="display:block;width:48px;height:48px;background:url(http://twitter.com/api/users/profile_image/${u?.encodeAsHTML()})">
										<span style="position:absolute; left:-3000px;">${u?.encodeAsHTML()}</span>
									</g:link>
								</li>
					   	</g:each> 
					   </ul>
				<% } else { %>
					No attendee
				<% } %>
			</div>
			<% if(eventInstance?.hashtag){ %>
				<div id="twitter-conversation">
					<script charset="utf-8" src="http://widgets.twimg.com/j/2/widget.js"></script>
					<script>
						new TWTR.Widget({
						  version: 2,
						  type: 'search',
						  search: '#${eventInstance?.hashtag}',
						  interval: 30000,
						  title: '${eventInstance?.name}',
						  subject: '#${eventInstance?.hashtag} Twitter Conversation ',
						  width: 250,
						  height: 300,
						  theme: {
						    shell: {
						      background: '#542437',
						      color: '#ffcc00'
						    },
						    tweets: {
						      background: '#FBFBFB',
						      color: '#444444',
						      links: '#53777A'
						    }
						  },
						  features: {
						    scrollbar: true,
						    loop: false,
						    live: true,
						    behavior: 'all'
						  }
						}).render().start();
					</script>
				</div>	
			<% } %>
		</div>
	</div>
</g:applyLayout>