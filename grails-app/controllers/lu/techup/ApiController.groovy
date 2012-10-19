package lu.techup

import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import org.apache.commons.logging.LogFactory
import org.springframework.dao.DataIntegrityViolationException

class ApiController {

   private static final log = LogFactory.getLog(this)
   static allowedMethods = [events: "GET"]

   def eventService
   def springSecurityService

   def user(){
      def result = [:]
      log.debug(params)
      def userInstance = User.findByUsernameIlike(params.id)
      log.debug(userInstance)
      if(!userInstance && params.id?.isNumber() )
         userInstance = User.get(params.id) // Try to get by id

      if (!userInstance) {
         // FIXME: Set response to bad request 404 resource not found
         response.status = 404
         return
      }
      
      def past = new Boolean(params.past?:'true')
      def future = new Boolean(params.future?:'true')
      def pastEvents
      def upcomingEvents

      def submitted  = userInstance?.created?.findAll{!it.hidden}?.toList()   // Get only the public events
      def events = []
      submitted.each{ event ->
         def tmp = [
            'id':    event.id,
            'title': event.name,
            'description': event.description,
            'startdate': g.formatDate([date:event.fromDate, format:'yyyyMMdd'])+"T"+g.formatDate([date:event.fromDate, format:'HHmmSS']),
            'enddate': g.formatDate([date:event.toDate, format:'yyyyMMdd'])+"T"+g.formatDate([date:event.toDate, format:'HHmmSS']),
            'price': event.price,
            'url': event.url,
            'hashtag': event.hashtag,
            'twitterhandler': event.twitterHandler,
            'languages': event.languages*.name?.sort(),
            'tags': event.tags*.name?.sort(),
            'attendees': event.attendees*.username?.sort(),
            'venue' : event.venue?.forJSON()
         ]
         events.add( tmp )
      }

      result.user = ['id':userInstance.id, 'username':userInstance.username, 'submitted':events]

      response.contentType = "application/json"
      response.setStatus(200)
      render result as JSON
   }

   def venue(){
      def result = [:]
      log.debug(params)
      def venueInstance = Venue.findByNameIlike(params.id)
      if(!venueInstance && params.id?.isNumber() )
         venueInstance = Venue.get(params.id) // Try to get by id

      if (!venueInstance) {
         // FIXME: Set response to bad request 404 resource not found
         response.status = 404
         return
      }

      def past = new Boolean(params.past?:'true')
      def future = new Boolean(params.future?:'true')
      def pastEvents
      def upcomingEvents
      def now = new Date()
      if(past){
         def e = Event.createCriteria()
         pastEvents = e {
            lt 'fromDate', now
            venue {
               eq('id', venueInstance?.id)
            }
         }
      }

      if(future){
         def u = Event.createCriteria()
         upcomingEvents = u {
            ge 'fromDate', now
            venue {
               eq('id', venueInstance?.id)
            }
         }
      }

      upcomingEvents = upcomingEvents?.findAll{!it.hidden}
      pastEvents = pastEvents?.findAll{ !it.hidden }

      def events = []
      if(past){
         pastEvents.each{ event ->
            def tmp = [
               'id':    event.id,
               'title': event.name,
               'description': event.description,
               'startdate': g.formatDate([date:event.fromDate, format:'yyyyMMdd'])+"T"+g.formatDate([date:event.fromDate, format:'HHmmSS']),
               'enddate': g.formatDate([date:event.toDate, format:'yyyyMMdd'])+"T"+g.formatDate([date:event.toDate, format:'HHmmSS']),
               'price': event.price,
               'url': event.url,
               'hashtag': event.hashtag,
               'twitterhandler': event.twitterHandler,
               'languages': event.languages*.name?.sort(),
               'tags': event.tags*.name?.sort(),
               'attendees': event.attendees*.username?.sort(),
               'submitter': event.initiator?.username
            ]
            events.add( tmp )
         }
      }
      if(future){
         upcomingEvents.each{ event ->
            def tmp = [
               'id':    event.id,
               'title': event.name,
               'description': event.description,
               'startdate': g.formatDate([date:event.fromDate, format:'yyyyMMdd'])+"T"+g.formatDate([date:event.fromDate, format:'HHmmSS']),
               'enddate': g.formatDate([date:event.toDate, format:'yyyyMMdd'])+"T"+g.formatDate([date:event.toDate, format:'HHmmSS']),
               'price': event.price,
               'url': event.url,
               'hashtag': event.hashtag,
               'twitterhandler': event.twitterHandler,
               'languages': event.languages*.name?.sort(),
               'tags': event.tags*.name?.sort(),
               'attendees': event.attendees*.username?.sort(),
               'submitter': event.initiator?.username
            ]
            events.add( tmp )
         }
      }

      result.venue = ['id':venueInstance.id, 'name':venueInstance.name, 'adress':venueInstance?.adress, 'verified':venueInstance?.verified, 'events':events]

      response.contentType = "application/json"
      response.setStatus(200)
      render result as JSON
   }
}
