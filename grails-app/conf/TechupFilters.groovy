class TechupFilters{
   def filters = {
      /*wwwPrependerCheck(controller:'*', action:'*'){
         before = {
            if (request.serverName?.toLowerCase() != "www.techup.lu") {
               response.setStatus(301);
               response.setHeader("Location", "http://www.techup.lu" + request.forwardURI)
               response.flushBuffer()
               return false; // return false, otherwise request is handled from controller
            }
         }
      }*/
   }
}