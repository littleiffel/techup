package lu.techup

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException

class TagController {

   def eventService

   def show() {
      def tagInstance = Tag.findByNameIlike(params.id)

      if(!tagInstance)
         tagInstance = Tag.get(params.id) // Try to get by id

      if (!tagInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'tag.label', default: 'Tag'), params.id])
         redirect( controller:"event", action: "list")
         return
      }

      def now = new Date()
      now = now.updated(hourOfDay:0, minute:0, second:0)
      def events = tagInstance.getEvents()?.toList()
      def past = []
      def upcoming = []
      // Sort by past and upcoming
      events.each{ event ->
         if( !event.hidden){
            if(event.fromDate < now)
               past.add(event)
            else
               upcoming.add(event)
         }  
      } 

      def upcomingCount = eventService.countUpcomingEvents()
      def pastCount = eventService.countPastEvents()

      [tagInstance: tagInstance, pastEvents:eventService.organizeEventsByDay( past ), upcomingEvents:eventService.organizeEventsByDay( upcoming ), instanceUpcomingCount:upcoming?.size(), instancePastCount:past?.size(), pastCount:pastCount, upcomingCount:upcomingCount] 
   }

   def feed() {
      def tagInstance = Tag.findByNameIlike(params.id)
      if(!tagInstance)
         tagInstance = Tag.get(params.id) // Try to get by id

      if(!tagInstance){
         render( "" ) // FIXME: Set Error Code for url does not exists
         return
      }

      def events = tagInstance.getEvents()

      render(feedType:params.format?:'rss', feedVersion:params.version?:'2.0',contentType: 'text/xml') {
         title = "Latest Events on techup.lu for Tag ${tagInstance.getName()}"
         link = "http://www.techup.lu/tag/feed/${tagInstance.getName()}"
         description = "techup.lu is collects Meetups for Hackers/Geeks/Nerds/IT in Luxembourg. This feed gives the events in order of submittance."
         events.sort{ it.submittedOn }.each() { event ->
            entry(event.name) {
               link = "http://www.techup.lu/${event.id}"
               publishedDate = event.submittedOn
               author = event.initiator.toString()
               def c = "Starting at: " + event.fromDate + " at " + event.venue?.toString() + "<br> Description: "+event.description
               c // return the content
            }
         }
      }
   }
}
