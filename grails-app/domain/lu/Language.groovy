package lu.techup

class Language {

	String name

   String toString() {
      return name
   }

	static hasMany = [events:Event]

   static belongsTo = Event

   static constraints = {
   }
}
