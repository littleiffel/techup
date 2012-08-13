<div class="day-list-item">
   <div class="day-wrapper span1">
      <span class="format-date">
	      ${dateInstance.format('MM/dd/yy')}
      </span>   
   </div>
	<div class="day-events span10">
		<g:each in="${eventInstanceList}" status="i" var="eventInstance">
         <g:render template="/event/list-item" model="[i:i, eventInstance:eventInstance]"/>
		</g:each>
	</div>
</div>