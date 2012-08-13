dataSource {
   pooled = true
   driverClassName = "org.h2.Driver"
   username = "sa"
   password = ""
}
hibernate {
   cache.use_second_level_cache = true
   cache.use_query_cache = true
   cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
   development {
      dataSource {
         dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
         url = "jdbc:h2:mem:devDb;MVCC=TRUE"
      }
   }
   test {
      dataSource {
         dbCreate = "update"
         url = "jdbc:h2:mem:testDb;MVCC=TRUE"
      }
   }
   production {
      dataSource {
         dbCreate = "update"
         driverClassName = "org.postgresql.Driver"
         dialect = org.hibernate.dialect.PostgreSQLDialect
         // Conf for Heroku postgres using System.ENV 
         uri = new URI(System.env.DATABASE_URL?:"postgres://test:test@localhost/test")
         url = "jdbc:postgresql://"+uri.host+uri.path
         //Connection conn = DriverManager.getConnection(url);
         username = uri.userInfo.split(":")[0]
         password = uri.userInfo.split(":")[1]
      }
   }
}
