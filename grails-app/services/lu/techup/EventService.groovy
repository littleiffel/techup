package lu.techup

import org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib
import org.springframework.context.ApplicationContext
import org.springframework.context.ApplicationContextAware

class EventService implements ApplicationContextAware{

   private ApplicationTagLib g

   private countPastEventsCached
   private countUpcomingEventsCached
   private cacheTimeStamp

   void setApplicationContext(ApplicationContext applicationContext) {
      g = applicationContext.getBean(ApplicationTagLib)
      // now you have a reference to g
   }

   /*
   * Organize a list of events into a map where the date is key
   * 
   */
   Map organizeEventsByDay( List eventInstanceList ) {
      def eventInstanceMap = [:]
      eventInstanceList.each(){ event ->
         def key = event.fromDate?.updated(hourOfDay:0, minute:0, second:0)//g.formatDate([date:event.fromDate, type:'date'])
         def tmp = eventInstanceMap.get( key )
         if(!tmp)
            tmp = []
         tmp.add(event)
         eventInstanceMap.put(key, tmp)
      }
      return eventInstanceMap
   }

   /*
   * Recount the upcoming Events on Techup
   *
   */ 
   private int refreshUpcomingEvents(){
      def now = new Date()
      now = now.updated(hourOfDay:0, minute:0, second:0)
      def upcomingCount = Event.countByFromDateGreaterThanEqualsAndHidden(now,false)
      cacheTimeStamp = now
      return upcomingCount?:0
   }

   /*
   * Recount the past Events on Techup
   *
   */ 
   private int refreshPastEvents(){
      def now = new Date()
      now = now.updated(hourOfDay:0, minute:0, second:0)
      def pastCount = Event.countByFromDateLessThanAndHidden(now,false)
      cacheTimeStamp = now
      return pastCount?:0
   }

   /*
   * Force a refresh of the cached Counts
   *
   */ 
   def forceCacheRefresh(){
      countUpcomingEventsCached = refreshUpcomingEvents()
      countPastEventsCached = refreshPastEvents()
   }

   /*
   * Get Count of Upcoming Events
   * if cache is empty count first
   */ 
   Integer countUpcomingEvents(){
      if(!countUpcomingEventsCached)
         forceCacheRefresh()

      return countUpcomingEventsCached
   }

   /*
   * Recount the past Events on Techup
   *
   */ 
   Integer countPastEvents(){
      if(!countPastEventsCached)
         forceCacheRefresh()

      return countPastEventsCached
   }
}
