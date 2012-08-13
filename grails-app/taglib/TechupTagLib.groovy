class TechupTagLib{

	def springSecurityService

   static namespace = 'techup'
   
   /*
   * Get User Twitter Image with Tooltip and Link to Techup User Page
   */   
   def twitteruserimg = {attrs, body ->
      def u = lu.techup.User.findByUsername(attrs.user)
      out << g.link( controller:"user", action:"show", id:"${u?.id}", class:"twitter-anywhere-user", style:"display:block;width:48px;height:48px;background:url(http://twitter.com/api/users/profile_image/${u?.username})"){"<span style='position:absolute; left:-3000px;'>${u?.username}</span>"}
   }

   /*
   * Get User Link to Techup User Page
   */   
   def twitteruser = {attrs, body ->
      def u = lu.techup.User.findByUsername(attrs.user)
      out << g.link( controller:"user", action:"show", id:"${u?.id}", class:"twitter-anywhere-user"){"@"+u?.username}
   }

   /*
   * Get Session/Current Link to Techup User Page
   */   
   def currentuser = {attrs, body ->
      def u = springSecurityService.currentUser
      out << g.link( controller:"user", action:"show", id:"${u?.id}", class:"twitter-anywhere-user"){"@"+u?.username}
   }

}
