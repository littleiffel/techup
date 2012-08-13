package lu.techup

class Tag {

   String name

   String toString() {
      return name
   }

   static hasMany = [events:Event]

   static belongsTo = Event

   static constraints = {
   }
}
