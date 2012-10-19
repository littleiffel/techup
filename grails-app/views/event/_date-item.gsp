<% 
def now = new Date()
def today = (dateInstance?.clearTime() == now?.clearTime())
%>
<div class="day-list-item ${today?"highlight":""}">
   <div class="day-wrapper span1">
      <% if(today){ %>
            <h3>Today</h3>
      <% }else{ %>
            <span class="format-date">
               ${dateInstance.format('MM/dd/yy')}
            </span>
      <% } %>
   </div>
	<div class="day-events span10">
		<g:each in="${eventInstanceList}" status="i" var="eventInstance">
         <g:render template="/event/list-item" model="[i:i, eventInstance:eventInstance]"/>
		</g:each>
	</div>
</div>