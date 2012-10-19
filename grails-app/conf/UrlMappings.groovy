class UrlMappings {

	static mappings = {

      "/"(controller:"event", action:"upcoming")
      "/ical.ics"(controller:"event", action:"upcoming"){
      	format = 'ical'
      }

      "/$id"(controller:"event",action:"show"){
			constraints {
				id(matches:/\d{1,6}/)
			}
		}

		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

      "/about"(view:'/about')
		
		"500"(view:'/error')
	}
}
