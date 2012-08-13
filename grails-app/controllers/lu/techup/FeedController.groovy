package lu.techup

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException

class FeedController {
    def latest = {
        render(feedType:params.format?:'rss', feedVersion:params.version?:'2.0',contentType: 'text/xml') {
            title = "Latest Events on techup.lu"
            link = "http://www.techup.lu/feed/latest"
            description = "techup.lu is collects Meetups for Hacjers/Geeks/Nerds/IT in Luxembourg. This feed gives the events in order of submittance."
            Event.list().sort{ it.submittedOn }.each() { event ->
                entry(event.name) {
                    link = "http://www.techup.lu/${event.id}"
                    publishedDate = event.submittedOn
                    author = event.initiator.toString()
                    def c = "Starting at: " + event.fromDate + " at " + event.venue?.toString() + "<br> Description: "+event.description
                    c // return the content
                }
            }
        }
    }
}