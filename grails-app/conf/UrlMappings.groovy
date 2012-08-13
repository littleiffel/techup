class UrlMappings {

	static mappings = {

      "/"(controller:"event", action:"upcoming")

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
