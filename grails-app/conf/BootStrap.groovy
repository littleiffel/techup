class BootStrap {
   // All this is mainly for Development Convinience to start will a non-empty db
   def init = { servletContext ->
    	def l1, l2
         if (!lu.techup.Language.count()) {
            l1 = new lu.techup.Language(name:"French", tid:"french").save(failOnError: true)
            l2 = new lu.techup.Language(name:"German", tid:"german").save(failOnError: true)
            new lu.techup.Language(name:"Luxembourgish", tid:"luxembourgish").save(failOnError: true)
            new lu.techup.Language(name:"English", tid:"english").save(failOnError: true)
         }
         // Create or Find these Tags -
         def tag1,  tag2
         if (!lu.techup.Tag.count()) {
            tag1 = new lu.techup.Tag(name:"JavaScript", tid:"javascript").save(failOnError: true)
            tag2 = new lu.techup.Tag(name:"CoffeeScript", tid:"coffeescript").save(failOnError: true)
            new lu.techup.Tag(name:"Java", tid:"java").save(failOnError: true)
            new lu.techup.Tag(name:"Paas", tid:"paas").save(failOnError: true)
         }
         // Create or Find ADMIN Role for Admin Tagged Actions
         def role = lu.techup.Role.findByAuthority('ROLE_ADMIN')
         if(!role)
            role = new lu.techup.Role(authority: 'ROLE_ADMIN', description: 'Admin role').save()

         //FIXME: Please remove before deploying 
         def admin = lu.techup.User.findByUsername("admin")
         if (!admin) 
            admin = new lu.techup.User(username:"admin", password:"pazzword", enabled:"true").save(failOnError: true)
        
         if (!admin?.authorities?.contains(role)) { lu.techup.UserRole.create admin, role }

         if (!lu.techup.Venue.count()){
            def v = new lu.techup.Venue(homepage:"http://www.ccrml.lu", lat:49.61004253720457, lon:6.136239767074585, name:"Abbaye de Neumunster", adress:"21 rue de Munster, luxembourg", verified:true, tid:"abbayedeneumunster").save(failOnError:true)
      }
   }
   def destroy = {
   }
}
