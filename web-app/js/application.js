!function ($) {

   $(function(){

      function formatDate( date ){
         return moment.utc(date, "MM/DD/YY").format("MMM Do 'YY");
      }

      function formatDay( date ){
         return moment.utc(date, "MM/DD/YY").format("dddd");
      }

      function formatTime( time ){
         return moment.utc(time, "hh:mm a").format("HH:mm");
      }

      function formatDayTime( time ){
         return moment.utc(time, "MM/DD/YY HH:mm").format("dddd MMM Do, HH:mm");
      }

      $('.format-date').each(function(index){
         $(this).html( "<div class='day_of_week'>"+formatDay( $(this).html())+"</div>"+formatDate( $(this).html() ) ) ;
      });

      $('.format-time').each(function(index){
         $(this).html( formatTime( $(this).html() ) ) ;
      });

      $('.format-day').each(function(index){
         $(this).html( formatDay( $(this).html() ) ) ;
      });

      $('.format-day-time').each(function(index){
         $(this).html( formatDayTime( $(this).html() ) ) ;
      });


      $('.format-markdown').each(function(index){
         var converter = new Markdown.Converter();
         $(this).html( converter.makeHtml($(this).html() ));
      });
   });

}(window.jQuery);

function initialize( lat, lon, title) {
   var myLatlng = new google.maps.LatLng(lat,lon);
   var myOptions = {
       zoom: 13,
       center: myLatlng,
       mapTypeId: google.maps.MapTypeId.ROADMAP
   };
   var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  
   var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title:title
   });
}

function initializeForm() {
   console.log("hello init");
   var mapOptions = {
     center: new google.maps.LatLng(49.78543, 6.13528),
     zoom: 8,
     mapTypeId: google.maps.MapTypeId.ROADMAP
   };
   var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

   var input = document.getElementById('newvenue.adress');
   var autocomplete = new google.maps.places.Autocomplete(input);

   autocomplete.bindTo('bounds', map);

   var infowindow = new google.maps.InfoWindow();
   var marker = new google.maps.Marker({
     map: map
   });

   google.maps.event.addListener(autocomplete, 'place_changed', function() {
     infowindow.close();
     var place = autocomplete.getPlace();
     if (place.geometry.viewport) {
       map.fitBounds(place.geometry.viewport);
     } else {
       map.setCenter(place.geometry.location);
       //map.setZoom(17);  // Why 17? Because it looks good.
     }
     console.log(place);
     $("#newvenue\\.lat").val(place.geometry.location.lat());
     $("#newvenue\\.lon").val(place.geometry.location.lng());
     var image = new google.maps.MarkerImage(
         place.icon,
         new google.maps.Size(71, 71),
         new google.maps.Point(0, 0),
         new google.maps.Point(17, 34),
         new google.maps.Size(35, 35));
     marker.setIcon(image);
     marker.setPosition(place.geometry.location);

     var address = '';
     if (place.address_components) {
       address = [(place.address_components[0] && place.address_components[0].short_name || ''),
                  (place.address_components[1] && place.address_components[1].short_name || ''),
                  (place.address_components[2] && place.address_components[2].short_name || '')].join(' ');
     }

     infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
     infowindow.open(map, marker);
   });
}