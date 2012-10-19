BEGIN:VCALENDAR
VERSION:2.0
METHOD:PUBLISH
PRODID:-//techup.lu//iCal Feed//EN
CALSCALE:GREGORIAN
X-WR-CALNAME:techup.lu
X-WR-CALDESC:Luxembourg Tech Meetups
X-WR-TIMEZONE:Europe/Luxembourg
BEGIN:VTIMEZONE
TZID:Europe/Amsterdam
X-LIC-LOCATION:Europe/Amsterdam
BEGIN:DAYLIGHT
TZOFFSETFROM:+0100
TZOFFSETTO:+0200
TZNAME:CEST
DTSTART:19700329T020000
RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:+0200
TZOFFSETTO:+0100
TZNAME:CET
DTSTART:19701025T030000
RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VTIMEZONE
TZID:Europe/Luxembourg
X-LIC-LOCATION:Europe/Luxembourg
BEGIN:DAYLIGHT
TZOFFSETFROM:+0100
TZOFFSETTO:+0200
TZNAME:CEST
DTSTART:19700329T020000
RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU
END:DAYLIGHT
BEGIN:STANDARD
TZOFFSETFROM:+0200
TZOFFSETTO:+0100
TZNAME:CET
DTSTART:19701025T030000
RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU
END:STANDARD
END:VTIMEZONE
X-PUBLISHED-TTL:PT10M
<% def now = new Date()
events.each(){ event -> %>
BEGIN:VEVENT
UID:http://techup.lu/${event.id}
CLASS:PUBLIC
TRANSP:TRANSPARENT
STATUS:${event.cancelled?"CANCELLED":"CONFIRMED"}
DTSTAMP:<g:formatDate date="${now}" format="yyyyMMdd"/>T<g:formatDate date="${now}" format="HHmmSS"/>
CREATED:<g:formatDate date="${event.submittedOn}" format="yyyyMMdd"/>T<g:formatDate date="${event.submittedOn}" format="HHmmSS"/>
LAST-MODIFIED:<g:formatDate date="${event.lastUpdate?:event.submittedOn}" format="yyyyMMdd"/>T<g:formatDate date="${event.lastUpdate?:event.submittedOn}" format="HHmmSS"/>
DTSTART:<g:formatDate date="${event.fromDate}" format="yyyyMMdd"/>T<g:formatDate date="${event.fromDate}" format="HHmmSS"/>
DTEND:<g:formatDate date="${event.toDate}" format="yyyyMMdd"/>T<g:formatDate date="${event.toDate}" format="HHmmSS"/>
SUMMARY:${event.name}
DESCRIPTION:${event.description}
CATEGORIES:Conference
ORGANIZER;CN=${event.twitterHandler}:http://twitter.com/${event.twitterHandler}
LOCATION:${event.getVenue()}
SEQUENCE:${event.version}
END:VEVENT
<% } %>
END:VCALENDAR

