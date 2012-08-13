package lu.techup

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException

class EventController {

   static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

   def eventService
   def springSecurityService


   def list() {
      redirect(action: "upcoming", params: params)
   }

   def upcoming() { 
      params.max = Math.min(params.max ? params.int('max') : 10, 100)
      // Default sorting by date
      params.sort = "fromDate"
      params.order = "asc"
 
      def now = new Date()
      def eventInstanceList = Event.findAllByFromDateGreaterThanEqualsAndHidden(now.updated(hourOfDay:0, minute:0, second:0),false)

      def upcomingCount = eventService.countUpcomingEvents()
      def pastCount = eventService.countPastEvents()
      // Group by Date in Map and render each day as List      
      def eventInstanceMap = [:]
      eventInstanceList.each(){ event ->
         def key = event.fromDate?.updated(hourOfDay:0, minute:0, second:0)
         def tmp = eventInstanceMap.get( key )
         if(!tmp)
            tmp = []
         tmp.add(event)
         eventInstanceMap.put(key, tmp)
      }        
      render( view:'list', model:[pastCount: pastCount, upcomingCount: upcomingCount, eventInstanceMap:eventService.organizeEventsByDay( eventInstanceList ), title:message([code:"techup.events.list.upcoming", default:"Events"])] )
   }

   def past() {
      params.max = Math.min(params.max ? params.int('max') : 10, 100)
      // Default sorting by date
      params.sort = "fromDate"
      params.order = "asc"

      def now = new Date()
      def eventInstanceList = Event.findAllByFromDateLessThanAndHidden(now.updated(hourOfDay:0, minute:0, second:0),false)

      def upcomingCount = eventService.countUpcomingEvents()
      def pastCount = eventService.countPastEvents()
      // Group by Date in Map and render each day as List
      def eventInstanceMap = [:]
      eventInstanceList.each(){ event ->
         def key = event.fromDate?.updated(hourOfDay:0, minute:0, second:0)
         def tmp = eventInstanceMap.get( key )
         if(!tmp)
            tmp = []
         tmp.add(event)
         eventInstanceMap.put(key, tmp)
      }

      render(view:'list', model:[title:g.message([code:"techup.events.list.past", default:"Events"]), upcomingCount:upcomingCount, pastCount: pastCount, eventInstanceMap:eventService.organizeEventsByDay( eventInstanceList )]) 
   }

   @Secured(['IS_AUTHENTICATED_REMEMBERED'])
   def create() {
      def tags = Tag.list()

      def upcomingCount = eventService.countUpcomingEvents()
      def pastCount = eventService.countPastEvents()

      [eventInstance: new Event(params), techuptags:tags, upcomingCount:upcomingCount, pastCount:pastCount]
   }

   @Secured(['IS_AUTHENTICATED_REMEMBERED'])
   def save() {
      def eventInstance
      // Check for new Venue
      if(params.newvenue){
         params.newvenue.verified = false
         log.info(params.newvenue)
         def venueInstance = new Venue(params.newvenue)
         if(!venueInstance.save(flush:true)){
             // FIXME:, what to do
             log.error("Could not Save Venue something went wrong, "+venueInstance)     
         } 
         params.venue = venueInstance
      }else{
         params.venue = Venue.findById(params.venue)    
      }

      // Tags
      def filterTags = []
      if(params.tags?.class == java.lang.String){
         def nTag = Tag.findByNameIlike( params.tags )
         if(!nTag)
            nTag = new Tag( [name:params.tags] )
         if(!nTag.save()){
            logger.error("Could not save new Tag"+params.tags)
         }
         params.tags = nTag

      }else{
         params.tags?.each(){

            def nTag = Tag.findByNameIlike( it )
            if(!nTag)
               nTag = new Tag( [name:it] )
            if(!nTag.save()){
               logger.error("Could not save new Tag"+it)
            }
            filterTags.add( nTag )
         }
         params.tags = filterTags
      }
      // Set default Params
      params.initiator = springSecurityService.currentUser
      params.hidden = params.hidden?:'false'
      params.cancelled = params.cancelled?:'false'
      def n = new Date()
      params.submittedOn = n
      params.lastUpdate = n

      if(!springSecurityService.isLoggedIn()){
         flash.message = message(code: 'techup.login.required')   
         eventInstance  = new Event(params) 
         def tags = Tag.list()
         def upcomingCount = eventService.countUpcomingEvents()
         def pastCount = eventService.countPastEvents()
         render(view: "create", model: [eventInstance: eventInstance, techuptags:tags, upcomingCount:upcomingCount, pastCount:pastCount])        
         return
      }
      eventInstance = new Event(params)
      if (!eventInstance.save(flush: true)) {
         def tags = Tag.list()
         def upcomingCount = eventService.countUpcomingEvents()
         def pastCount = eventService.countPastEvents()
         render(view: "create", model: [eventInstance: eventInstance, techuptags:tags, upcomingCount:upcomingCount, pastCount:pastCount])
         return
      }
      eventService.forceCacheRefresh()
		flash.message = message(code: 'techup.created.event.message', default:"Event added")
      flash.class = "alert-success"
      redirect(action: "show", id: eventInstance.id)
   }

   def show() {
      def eventInstance = Event.get(params.id)
      if (!eventInstance) {
		flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "upcoming")
         return
      }
      def editable = false 
      // Is the user the submitter of the event, if yes show editable controls
      if(springSecurityService.currentUser?.id == eventInstance?.initiator.id){
         editable = true
      }

      def upcomingCount = eventService.countUpcomingEvents()
      def pastCount = eventService.countPastEvents()

     [eventInstance: eventInstance, editable:editable, user:springSecurityService.currentUser, pastCount:pastCount, upcomingCount:upcomingCount]
   }

   @Secured(['IS_AUTHENTICATED_REMEMBERED'])
   def edit() {
      def eventInstance = Event.get(params.id)
      if (!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "upcoming")
         return
      }

      if(eventInstance.initiator?.id != springSecurityService.currentUser?.id){
         flash.message = message(code: 'default.not.allowed.message', default:'You are not allowed to do this! Go Away!')
         redirect(action: "upcoming")
         return
      }

      def upcomingCount = eventService.countUpcomingEvents()
      def pastCount = eventService.countPastEvents()

      [eventInstance: eventInstance, techuptags:Tag.list(), upcomingCount:upcomingCount, pastCount:pastCount]
   }

   @Secured(['IS_AUTHENTICATED_REMEMBERED'])
   def update() {
      def eventInstance = Event.get(params.id)
      
      if (!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "upcoming")
         return
      }

      if(eventInstance.initiator?.id != springSecurityService.currentUser?.id){
         flash.message = message(code: 'default.not.allowed.message', default:'You are not allowed to do this! Go Away!')
         redirect(action: "upcoming")
         return
      }

      if (params.version) {
         def version = params.version.toLong()
         if (eventInstance.version > version) {
            eventInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
               [message(code: 'event.label', default: 'Event')] as Object[],
               "Another user has updated this Event while you were editing")
            render(view: "edit", model: [eventInstance: eventInstance, techuptags:Tag.list()])
            return
         }
      }

      if(params.newvenue){
         params.newvenue.verified = false
         def venueInstance = new Venue(params.newvenue)
         if(!venueInstance.save(flush:true)){
            log.error("Could Not save venue instance, "+ venueInstance)     
         } 
         params.venue = venueInstance
      }else{
         params.venue = Venue.findById(params.venue)    
      }

      // Tags
      def filterTags = []
      if(params.tags?.class == java.lang.String){
         def nTag = Tag.findByNameIlike( params.tags )
         if(!nTag){
            nTag = new Tag( [name:params.tags] )
         }
         if(!nTag.save()){
            logger.error("Could not save new Tag"+params.tags)
         }
         params.tags = nTag
      }else{
         params.tags?.each(){
            def nTag = Tag.findByNameIlike( it )
            if(!nTag)
               nTag = new Tag( [name:it] )
            if(!nTag.save()){
               logger.error("Could not save new Tag"+it)
            }
            filterTags.add( nTag )
         }
         params.tags = filterTags
      }

      params.initiator = springSecurityService.currentUser
      params.submittedOn = eventInstance.submittedOn // Keep the old date
      params.cancelled = eventInstance.cancelled
      params.lastUpdate = new Date()
      eventInstance.properties = params

      if (!eventInstance.save(flush: true)) {
         render(view: "edit", model: [eventInstance: eventInstance, techuptags:Tag.list()])
         return
      }
      eventService.forceCacheRefresh()
      flash.message = message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])
      redirect(action: "show", id: eventInstance.id)
   }

   @Secured(['IS_AUTHENTICATED_REMEMBERED'])
   def toggle() {
      def eventInstance = Event.get(params.id)
      
      if (!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "upcoming")
         return
      }

      if(eventInstance.initiator?.id != springSecurityService.currentUser?.id){
         flash.message = message(code: 'default.not.allowed.message', default:'You are not allowed to do this! Go Away!')
         redirect(action: "upcoming")
         return
      }

      eventInstance.hidden = !eventInstance.hidden

      if (!eventInstance.save(flush: true)) {
         render(view: "edit", model: [eventInstance: eventInstance, techuptags:Tag.list()])
         return
      }
      eventService.forceCacheRefresh()
		flash.message = message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])
      redirect(action: "show", id: eventInstance.id)
   }

   @Secured(['IS_AUTHENTICATED_REMEMBERED'])
   def cancel(){
      def eventInstance = Event.get(params.id)
      
      if (!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "upcoming")
         return
      }

      if(eventInstance.initiator?.id != springSecurityService.currentUser?.id){
         flash.message = message(code: 'default.not.allowed.message', default:'You are not allowed to do this! Go Away!')
         redirect(action: "upcoming")
         return
      }

      eventInstance.cancelled = true
      if (!eventInstance.save(flush: true)) {
         render(view: "edit", model: [eventInstance: eventInstance, techuptags:Tag.list()])
         return
      }
      
      flash.message = message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])
      redirect(action: "show", id: eventInstance.id)
   }

   @Secured(['IS_AUTHENTICATED_REMEMBERED'])
   def uncancel(){
      def eventInstance = Event.get(params.id)
      
      if (!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "upcoming")
         return
      }

      if(eventInstance.initiator?.id != springSecurityService.currentUser?.id){
         flash.message = message(code: 'default.not.allowed.message', default:'You are not allowed to do this! Go Away!')
         redirect(action: "upcoming")
         return
      }

      eventInstance.cancelled = false
      if (!eventInstance.save(flush: true)) {
         render(view: "edit", model: [eventInstance: eventInstance, techuptags:Tag.list()])
         return
      }
      
      flash.message = message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])
      redirect(action: "show", id: eventInstance.id)
   }
}
