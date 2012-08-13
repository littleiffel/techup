package lu.techup

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException

class VenueController {

   def eventService

   def show() {
      def venueInstance = Venue.get(params.id)
      if (!venueInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'venue.label', default: 'Venue'), params.id])
         redirect(action: "list")
         return
      }

      def now = new Date()
      now = now.updated(hourOfDay:0, minute:0, second:0)

      def e = Event.createCriteria()
      def past = e {
         lt 'fromDate', now
         venue {
            eq('id', venueInstance?.id)
         }
      }

      def u = Event.createCriteria()
      def upcoming = u {
         ge 'fromDate', now
         venue {
            eq('id', venueInstance?.id)
         }
      }

      upcoming = upcoming?.findAll{!it.hidden}
      past = past?.findAll{ !it.hidden }

      def upcomingCount = eventService.countUpcomingEvents()
      def pastCount = eventService.countPastEvents()

      [venueInstance: venueInstance, pastEvents:eventService.organizeEventsByDay( past ), upcomingEvents:eventService.organizeEventsByDay( upcoming ), instancePastCount:past?.size(), instanceUpcomingCount:upcoming?.size(), upcomingCount:upcomingCount, pastCount:pastCount ]
   }

   def feed() {
      def venueInstance = Venue.findByNameIlike(params.id)
      if(!venueInstance)
         venueInstance = Tag.get(params.id) // Try to get by id

      if(!venueInstance){
         render( "" ) // FIXME: Set Error Code for url does not exists
         return
      }

      def events = venueInstance.getEvents()

      render(feedType:params.format?:'rss', feedVersion:params.version?:'2.0',contentType: 'text/xml') {
         title = "Latest Events on techup.lu for Venue ${venueInstance.getName()}"
         link = "http://www.techup.lu/tag/feed/${venueInstance.getName()}"
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
