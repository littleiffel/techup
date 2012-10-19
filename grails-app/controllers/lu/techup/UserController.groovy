package lu.techup

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException

class UserController {

   static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

   def eventService
   def springSecurityService

   def index() {
      redirect(action: "list", params: params)
   }

   def create() {
      [userInstance: new User(params)]
   }

   def save() {
      def userInstance = new User(params)
      if (!userInstance.save(flush: true)) {
         render(view: "create", model: [userInstance: userInstance])
         return
      }

		flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
      redirect(action: "show", id: userInstance.id)
   }

   def show(){
      def userInstance = User.get(params.id)
      if (!userInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
         redirect(action: "list") // FIXME: Dont redirect, let user stay on the page where he was, or give user doe not exist message
         return
      }

      def privateUser = false
      if(springSecurityService.currentUser?.id == userInstance?.id){
         privateUser = true
      }

      //def now = new Date(g.formatDate([date:new Date(), type:'date']))
      def now = new Date()
      now = now.updated(hourOfDay:0, minute:0, second:0)
      def events = userInstance.getAttends()?.toList()
      def past = []
      def upcoming = []
      def tags = new HashSet()
      // Sort by past and upcoming
      events.each{ event ->
         if( !event.hidden ){
            if(event.fromDate < now)
               past.add(event)
            else
               upcoming.add(event)

            tags.addAll( event.getTags() )
         }  
      } 

      // if format request is ical
      if(params.format == 'ical'){
         response.setHeader "Content-disposition", "attachment; filename=techup_lu_upcoming.ics"
         response.contentType = "text/calendar"
         response.setStatus(200)
         response.outputStream << g.render(template:"/event/ical", model:[events:upcoming], contentType:"text/calendar")
         response.outputStream.flush()
         return
      }

      def submitted 
      if(privateUser){
         submitted = userInstance?.created?.toList() // Private show all events
      }else{
         submitted = userInstance?.created?.findAll{!it.hidden}?.toList()
      }

      def upcomingCount = eventService.countUpcomingEvents()
      def pastCount = eventService.countPastEvents()

      [userInstance: userInstance, upcomingEvents:eventService.organizeEventsByDay( upcoming ), instanceUpcomingCount: upcoming?.size(), pastEvents:eventService.organizeEventsByDay( past ), instancePastCount: past?.size(), submittedEvents:eventService.organizeEventsByDay( submitted ), submittedCount:submitted?.size(), privateUser:privateUser, upcomingCount:upcomingCount, pastCount:pastCount, tags:tags ]
   }

   @Secured(['IS_AUTHENTICATED_REMEMBERED'])
   def attend() {
      def userInstance = springSecurityService.currentUser
      
      def eventInstance = Event.get(params.id)
      if(!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect( action:'show')
         return
      }
      userInstance.addToAttends(eventInstance)
      if (!userInstance.save(flush: true)) {
         render(view: "edit", model: [userInstance: userInstance])
         return
      }

      flash.message = message(code: 'techup.user.attending.event', default:"You are attending the Event.")
      flash.class = "alert-success"
      redirect(controller:"event", action: "show", id: eventInstance.id)
   }

   @Secured(['IS_AUTHENTICATED_REMEMBERED'])
   def unattend() {
      def userInstance = springSecurityService.currentUser
      //FIXME:userInstance might be null if noone is logging in
      def eventInstance = Event.get(params.id)
      if(!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action:'list')
         return
      }
      userInstance.attends.remove(eventInstance)

      if (!userInstance.save(flush: true)) {
         render(view: "edit", model: [userInstance: userInstance])
         return
      }

      flash.message = message(code: 'techup.user.unattending.event', default:"You are removed from the attendee list of the Event.")
      flash.class = "alert-success"
      redirect(controller:"event", action: "show", id: eventInstance.id)
   }
}
