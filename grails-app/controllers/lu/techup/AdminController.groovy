package lu.techup

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException

class AdminController {

   //static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    

   @Secured(['ROLE_ADMIN'])
   def index() {
        
   }

   //Tag Admin Controller

   @Secured(['ROLE_ADMIN'])
   def tags() {
      params.max = Math.min(params.max ? params.int('max') : 10, 100)
      [tagInstanceList: Tag.list(params), tagInstanceTotal: Tag.count()]
   }

   @Secured(['ROLE_ADMIN'])
   def create_tag() {
      [tagInstance: new Tag(params)]
   }

   @Secured(['ROLE_ADMIN'])
   def save_tag() {
      def tagInstance = new Tag(params)
      if (!tagInstance.save(flush: true)) {
         render(view: "create_tag", model: [tagInstance: tagInstance])
         return
      }
	flash.message = message(code: 'default.created.message', args: [message(code: 'tag.label', default: 'Tag'), tagInstance.id])
      redirect(action: "show_tag", id: tagInstance.id)
   }

   @Secured(['ROLE_ADMIN'])
   def show_tag() {
      def tagInstance = Tag.get(params.id)
      if (!tagInstance) {
    		flash.message = message(code: 'default.not.found.message', args: [message(code: 'tag.label', default: 'Tag'), params.id])
         redirect(action: "tags")
         return
      }
      [tagInstance: tagInstance]
   }

   @Secured(['ROLE_ADMIN'])
   def edit_tag() {
      def tagInstance = Tag.get(params.id)
      if (!tagInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'tag.label', default: 'Tag'), params.id])
         redirect(action: "tags")
         return
      }

      [tagInstance: tagInstance]
   }

   @Secured(['ROLE_ADMIN'])
   def update_tag() {
      def tagInstance = Tag.get(params.id)
      if (!tagInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'tag.label', default: 'Tag'), params.id])
         redirect(action: "tags")
         return
      }

      if (params.version) {
         def version = params.version.toLong()
         if (tagInstance.version > version) {
            tagInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
               [message(code: 'tag.label', default: 'Tag')] as Object[],
               "Another user has updated this Tag while you were editing")
            render(view: "edit_tag", model: [tagInstance: tagInstance])
            return
         }
      }

      tagInstance.properties = params

      if (!tagInstance.save(flush: true)) {
         render(view: "edit_tag", model: [tagInstance: tagInstance])
         return
      }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'tag.label', default: 'Tag'), tagInstance.id])
      redirect(action: "show_tag", id: tagInstance.id)
   }

   @Secured(['ROLE_ADMIN'])
   def delete_tag() {
      def tagInstance = Tag.get(params.id)
      if (!tagInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'tag.label', default: 'Tag'), params.id])
         redirect(action: "tags")
         return
      }

      try {
         tagInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'tag.label', default: 'Tag'), params.id])
         redirect(action: "tags")
      }
      catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tag.label', default: 'Tag'), params.id])
         redirect(action: "show_tag", id: params.id)
      }
   }

    // Admin Events Controller
   @Secured(['ROLE_ADMIN'])
   def events() {
      params.max = Math.min(params.max ? params.int('max') : 10, 100)
      [eventInstanceList: Event.list(params), eventInstanceTotal: Event.count()]
   }

   @Secured(['ROLE_ADMIN'])
   def create_event() {
      [eventInstance: new Event(params)]
   }

   @Secured(['ROLE_ADMIN'])
   def save_event() {
      def eventInstance = new Event(params)
      if (!eventInstance.save(flush: true)) {
         render(view: "create_event", model: [eventInstance: eventInstance])
         return
      }

      flash.message = message(code: 'default.created.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])
      redirect(action: "show_event", id: eventInstance.id)
   }

   @Secured(['ROLE_ADMIN'])
   def show_event() {
      def eventInstance = Event.get(params.id)
      if (!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "events")
         return
      }

      [eventInstance: eventInstance]
   }

   @Secured(['ROLE_ADMIN'])
   def edit_event() {
      def eventInstance = Event.get(params.id)
      if (!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "events")
         return
      }

      [eventInstance: eventInstance]
   }

   @Secured(['ROLE_ADMIN'])
   def update_event() {
      def eventInstance = Event.get(params.id)
      if (!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "events")
         return
      }

      if (params.version) {
         def version = params.version.toLong()
         if (eventInstance.version > version) {
            eventInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
               [message(code: 'event.label', default: 'Event')] as Object[],
               "Another user has updated this Event while you were editing")
            render(view: "edit_event", model: [eventInstance: eventInstance])
            return
         }
      }

      eventInstance.properties = params

      if (!eventInstance.save(flush: true)) {
         render(view: "edit_event", model: [eventInstance: eventInstance])
         return
      }

      flash.message = message(code: 'default.updated.message', args: [message(code: 'event.label', default: 'Event'), eventInstance.id])
      redirect(action: "show_event", id: eventInstance.id)
   }

   @Secured(['ROLE_ADMIN'])
   def delete_event() {
      def eventInstance = Event.get(params.id)
      if (!eventInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
            redirect(action: "events")
            return
      }

     try {
         eventInstance.delete(flush: true)
         flash.message = message(code: 'default.deleted.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "events")
      }
      catch (DataIntegrityViolationException e) {
         flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'event.label', default: 'Event'), params.id])
         redirect(action: "show_event", id: params.id)
      }
   }

   // Admin Venues
   @Secured(['ROLE_ADMIN'])
   def venues() {
      params.max = Math.min(params.max ? params.int('max') : 10, 100)
      [venueInstanceList: Venue.list(params), venueInstanceTotal: Venue.count()]
   }

   @Secured(['ROLE_ADMIN'])
   def create_venue() {
      [venueInstance: new Venue(params)]
   }

   @Secured(['ROLE_ADMIN'])
   def save_venue() {
      def venueInstance = new Venue(params)
      if (!venueInstance.save(flush: true)) {
         render(view: "create_venue", model: [venueInstance: venueInstance])
         return
      }

      flash.message = message(code: 'default.created.message', args: [message(code: 'venue.label', default: 'Venue'), venueInstance.id])
      redirect(action: "show_venue", id: venueInstance.id)
   }

   @Secured(['ROLE_ADMIN'])
   def show_venue() {
      def venueInstance = Venue.get(params.id)
      if (!venueInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'venue.label', default: 'Venue'), params.id])
         redirect(action: "venues")
         return
      }

      [venueInstance: venueInstance]
   }

   @Secured(['ROLE_ADMIN'])
   def edit_venue() {
      def venueInstance = Venue.get(params.id)
      if (!venueInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'venue.label', default: 'Venue'), params.id])
         redirect(action: "venues")
         return
      }

      [venueInstance: venueInstance]
   }

   @Secured(['ROLE_ADMIN'])
   def update_venue() {
      def venueInstance = Venue.get(params.id)
      if (!venueInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'venue.label', default: 'Venue'), params.id])
         redirect(action: "venues")
         return
      }

      if (params.version) {
         def version = params.version.toLong()
         if (venueInstance.version > version) {
            venueInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
               [message(code: 'venue.label', default: 'Venue')] as Object[],
               "Another user has updated this Venue while you were editing")
            render(view: "edit_venue", model: [venueInstance: venueInstance])
            return
         }
      }

      venueInstance.properties = params

      if (!venueInstance.save(flush: true)) {
         render(view: "edit_venue", model: [venueInstance: venueInstance])
         return
      }

      flash.message = message(code: 'default.updated.message', args: [message(code: 'venue.label', default: 'Venue'), venueInstance.id])
      redirect(action: "show_venue", id: venueInstance.id)
   }

   @Secured(['ROLE_ADMIN'])
   def delete_venue() {
      def venueInstance = Venue.get(params.id)
      if (!venueInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'venue.label', default: 'Venue'), params.id])
         redirect(action: "venues")
         return
      }

      try {
         venueInstance.delete(flush: true)
         flash.message = message(code: 'default.deleted.message', args: [message(code: 'venue.label', default: 'Venue'), params.id])
         redirect(action: "venues")
      }
      catch (DataIntegrityViolationException e) {
         flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'venue.label', default: 'Venue'), params.id])
         redirect(action: "show_venue", id: params.id)
      }
   }

   // Languages Admin

   @Secured(['ROLE_ADMIN'])
   def languages() {
      params.max = Math.min(params.max ? params.int('max') : 10, 100)
      [languageInstanceList: Language.list(params), languageInstanceTotal: Language.count()]
   }

   @Secured(['ROLE_ADMIN'])
   def create_language() {
      [languageInstance: new Language(params)]
   }

   @Secured(['ROLE_ADMIN'])
   def save_language() {
      def languageInstance = new Language(params)
      if (!languageInstance.save(flush: true)) {
         render(view: "create_language", model: [languageInstance: languageInstance])
         return
      }

      flash.message = message(code: 'default.created.message', args: [message(code: 'language.label', default: 'Language'), languageInstance.id])
      redirect(action: "show_language", id: languageInstance.id)
   }

   @Secured(['ROLE_ADMIN'])
   def show_language() {
      def languageInstance = Language.get(params.id)
      if (!languageInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'language.label', default: 'Language'), params.id])
         redirect(action: "languages")
         return
      }
      [languageInstance: languageInstance]
   }

   @Secured(['ROLE_ADMIN'])
   def edit_language() {
      def languageInstance = Language.get(params.id)
      if (!languageInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'language.label', default: 'Language'), params.id])
         redirect(action: "languages")
         return
      }

      [languageInstance: languageInstance]
   }

   @Secured(['ROLE_ADMIN'])
   def update_language() {
      def languageInstance = Language.get(params.id)
      if (!languageInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'language.label', default: 'Language'), params.id])
         redirect(action: "languages")
         return
      }

      if (params.version) {
         def version = params.version.toLong()
         if (languageInstance.version > version) {
            languageInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
               [message(code: 'language.label', default: 'Language')] as Object[],
               "Another user has updated this Language while you were editing")
            render(view: "edit_language", model: [languageInstance: languageInstance])
            return
         }
      }

      languageInstance.properties = params

      if (!languageInstance.save(flush: true)) {
         render(view: "edit_language", model: [languageInstance: languageInstance])
         return
      }

      flash.message = message(code: 'default.updated.message', args: [message(code: 'language.label', default: 'Language'), languageInstance.id])
      redirect(action: "show_language", id: languageInstance.id)
   }

   @Secured(['ROLE_ADMIN'])
   def delete_language() {
      def languageInstance = Language.get(params.id)
      if (!languageInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'language.label', default: 'Language'), params.id])
         redirect(action: "languages")
         return
      }

      try {
         languageInstance.delete(flush: true)
         flash.message = message(code: 'default.deleted.message', args: [message(code: 'language.label', default: 'Language'), params.id])
         redirect(action: "languages")
      }
      catch (DataIntegrityViolationException e) {
         flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'language.label', default: 'Language'), params.id])
         redirect(action: "show_language", id: params.id)
      }
   }

   // Admin User

   @Secured(['ROLE_ADMIN'])
   def users() {
      params.max = Math.min(params.max ? params.int('max') : 10, 100)
      [userInstanceList: User.list(params), userInstanceTotal: User.count()]
   }

   @Secured(['ROLE_ADMIN'])
   def show_user() {
      def userInstance = User.get(params.id)
      if (!userInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
         redirect(action: "users")
         return
      }

      [userInstance: userInstance]
   }

   @Secured(['ROLE_ADMIN'])
   def create_user() {
      [userInstance: new User(params)]
   }

   @Secured(['ROLE_ADMIN'])
   def save_user() {
      def userInstance = new User(params)
      if (!userInstance.save(flush: true)) {
         render(view: "create_user", model: [userInstance: userInstance])
         return
      }
      flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
      redirect(action: "show_user", id: userInstance.id)
   }

   @Secured(['ROLE_ADMIN'])
   def edit_user() {
      def userInstance = User.get(params.id)
      if (!userInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
         redirect(action: "users")
         return
      }

      [userInstance: userInstance]
   }

   @Secured(['ROLE_ADMIN'])
   def update_user() {
      def userInstance = User.get(params.id)
      if (!userInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
         redirect(action: "users")
         return
      }

      if (params.version) {
         def version = params.version.toLong()
         if (userInstance.version > version) {
            userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
               [message(code: 'user.label', default: 'User')] as Object[],
               "Another user has updated this User while you were editing")
            render(view: "edit_user", model: [userInstance: userInstance])
            return
         }
      }

      userInstance.properties = params

      if (!userInstance.save(flush: true)) {
         render(view: "edit_user", model: [userInstance: userInstance])
         return
      }

      flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
      redirect(action: "show_user", id: userInstance.id)
   }

   @Secured(['ROLE_ADMIN'])
   def delete_user() {
      def userInstance = User.get(params.id)
      if (!userInstance) {
         flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
         redirect(action: "users")
         return
      }

      try {
         userInstance.delete(flush: true)
         flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
         redirect(action: "users")
      }
      catch (DataIntegrityViolationException e) {
         flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
         redirect(action: "show_user", id: params.id)
      }
   }
}