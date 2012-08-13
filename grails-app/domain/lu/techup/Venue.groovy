package lu.techup

class Venue {

   String name  
   String adress
   String homepage
   Float lat
   Float lon
   Boolean verified

   static belongsTo = Event

   static hasMany = [events:Event]

   static constraints = {
      homepage(url:true, nullable:true)
      verified(nullable:true)
      adress(maxSize:200, nullable:true)
   }

   String toString(){
      return name
   }
}
