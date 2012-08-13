<h3>Add a new Venue</h3>
<div class="span3">
  <div class="fieldcontain span3 ${hasErrors(bean: venueInstance, field: 'name', 'error')} ">
     <label for="name">
        <g:message code="venue.name.label" default="Venue Name" />
     </label>
     <g:textField name="newvenue.name" value="${venueInstance?.name}" required="required"/>
  </div>

  <div class="fieldcontain span3 ${hasErrors(bean: venueInstance, field: 'adress', 'error')} ">
     <label for="street">
        <g:message code="venue.adress.label" default="Venue Address" />
        
     </label>
     <g:textField name="newvenue.adress" value="${venueInstance?.adress}" required="required"/>
  </div>

  <div class="fieldcontain span3 ${hasErrors(bean: venueInstance, field: 'homepage', 'error')} ">
     <label for="homepage">
        <g:message code="venue.homepage.label" default="Venue Homepage" />
        
     </label>
     <g:field type="url" name="newvenue.homepage" value="${venueInstance?.homepage}"/>
  </div>
</div>
<div class="span2">
    <div id="map_canvas" class="map-canvas-small"></div>
</div>

  <input type="hidden" id="newvenue.lon" name="newvenue.lon" value="${fieldValue(bean: venueInstance, field: 'lon')?:0}"/>
  <input type="hidden" id="newvenue.lat" name="newvenue.lat" value="${fieldValue(bean: venueInstance, field: 'lat')?:0}"/>