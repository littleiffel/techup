// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.app.context = "/"

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']


// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// enable query caching by default
grails.hibernate.cache.queries = true

// set per-environment serverURL stem for creating absolute links
environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        grails.serverURL = "http://www.techup.lu"
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    appenders {
        console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    }
    debug 'lu.techup'

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'lu.techup.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'lu.techup.UserRole'
grails.plugins.springsecurity.authority.className = 'lu.techup.Role'


//grails.plugins.springsecurity.twitter.app.key='hll6kEsME91Y5YqOUSrlpCEbbSJzB8BySP65rwZc'
//grails.plugins.springsecurity.twitter.app.consumerKey='rh4ZbiMTj49Kwo5EnLr9A'
//grails.plugins.springsecurity.twitter.app.consumerSecret='eRww0xd0R15Pgy1Q6B5TWegixbg66OSqGBZLuCFhk'


grails.plugins.springsecurity.twitter.app.key='555466485-e81lMBZUBBrDvCgv2mtnMayzv4gzs28t6nLhPj2m'
grails.plugins.springsecurity.twitter.app.consumerKey='iQEIyFvmeRui8eXNlnaOnA'
grails.plugins.springsecurity.twitter.app.consumerSecret='6nIwuEeHZgxn0YlfjcI5EnPrGYf2Vt812uuw6kaoKQ'
grails.plugins.springsecurity.twitter.popup = true


// Memchached 5MB Free
//grails.plugin.memcached.hosts = 'mc7.ec2.northscale.net'
//grails.plugin.memcached.username = 'app3443943%40heroku.com'
//grails.plugin.memcached.password = 'PQaE9rclco4XQVTG'

//MemCachier 25MB Free :)
grails.plugin.memcached.hosts = 'mc1.ec2.memcachier.com'
grails.plugin.memcached.username = 'IYJt'
grails.plugin.memcached.password = '7tFCJ5WPJ1AvXg=='
