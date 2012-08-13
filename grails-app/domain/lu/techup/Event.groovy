package lu.techup

class Event {

	String name
	String description
	Date fromDate
	Date toDate
	BigDecimal price
	String twitterHandler
   String url
   String hashtag
   User initiator
   Venue venue
   Boolean hidden
   Date submittedOn
   Boolean cancelled
   Date lastUpdate

   String toString(){
      return name
   }

   BigDecimal countAttendees(){
      return attendees?.size()?:0
   }

   static belongsTo = User

   static hasMany = [tags:Tag, languages:Language, attendees:User]

   static constraints = {
      name maxSize: 140
      description maxSize: 2000
      url(url:true, nullable:true)
      twitterHandler(nullable:true)
      price(scale:2, nullable:true)
      attendees(nullable:true)
      venue(nullable:true)
      hidden(nullable:true)
      cancelled(nullable:true)
      lastUpdate(nullable:true)
   }
}
