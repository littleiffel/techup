
<%@ page import="lu.techup.Event" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
		<title><g:message code="default.about.label" default="About techup.lu" /></title>
	</head>
	<body>
		<h1>About techup.ch</h1>
		<p>Have you missed any IT meetings recently because you didn't know they were happening? Because I have! I missed so many of them that i decided to create a clone of techup.ch for Luxembourg. Techup is a agenda tool, open to everyone to use and submit their events easily.</p>

		<h3>What kind of Events do you accept?</h3>
		<p>You can submit any event on techup.lu that you think might interest any hacker, geek or nerd. This can be anything from technical presentation, cooking workshop, art exhibition or a yoga class. The event itself does not need to be free - you can specify a price on any event you submit.</p>

		<p>Can I post an event that happens in Paris, France? Well, if you think luxembourgish hackers might be interested in your event, just take 2 minutes to submit your event on techup.lu</p>

		<h3>How can I participate?</h3>
		<p>Just login with your Twitter account (more access possibilities might be added soon), submit an event or just hit the "attend" button to show your friends that you are going to an event.</p>

		<h3>Bugs, Feedback, Feature Request</h3>
		<p>Please ping the Techup on Twitter @techup_lu for bugs, feature requests and just any feedback. Any feedback is warmly appreciated. You can follow techup on twitter. All updates or status changes are twittered.</p>

		<h3>Why Techup.lu?</h3>
		<p>I am commuting every day to work. This 30 minute train ride being quite boring, i decided to create a simple project. As an exercice I cloned the excellent techup.ch, that covers a broad range of meetups and events. I thought we could have the same in Luxembourg! </p>

		<h3>Who are you?</h3>
		<p>My Name is Thierry Nicola (Twitter: @littleiffel) running the blog <a href="http://www.williambrownstreet.net/blog">williambrownstreet.net</a>. You can find me on the Internet or currently in Luxembourg, working at <a href="http://www.oashi.com">OAshi</a> as a software developer. Besides my job, I am also working every day to be a good husband and father.</p>

		<h3>Techup International</h3>
		<div class="logo">
        <div class="main-logo">
        	<div class="techup" style="
    float: left;
">
         	<span class="tech">tech</span>
         	<span class="up">up</span>
         </div>
         <div class="countries" style="
    float: left;
    font-size: 20px;
    width: 20px;
">
          	<span class="ch" style="
    margin: 5px;
    background-color: #CC2A41;
    padding-bottom: 2px;
"><a href="http://www.techup.ch">.ch</a></span>
          	<span class="lu" style="
    margin: 8px;
    line-height: 37px;
    padding-top: 4px;
"><a href="http://www.techup.lu">.lu</a></span>
         </div>
        </div>
        <div class="sub-logo" style="
    margin-left: 264px;
">
        	<span class="luxembourg">international</span>
         <span class="nerds-tech">nerds/tech/geeks</span> 
         <span class="meetup">meetups</span>
        </div>
      </div>
      <br/>
      <h3>Credits</h3>
      <ul>
      	<li>Background Pattern by <a href="http://www.dinpattern.com/">http://www.dinpattern.com/</a></li>
      	<li>Markdown editor by <a href="http://code.google.com/p/pagedown/">http://code.google.com/p/pagedown/</a></li>
      	<li>Powered by <a href="http://www.grails.org/">Grails</a></li>
      	<li>Running on <a href="http://www.heroku.com/">Heroku</a></li>
      	<li>Feeds plugin <a href="http://grails.org/plugin/feeds">http://grails.org/plugin/feeds</a></li>
      	<li>Spring Security Plugin <a href="http://grails.org/plugin/spring-security-core">http://grails.org/plugin/spring-security-core</a></li>
      	<li>Spring Security Twitter <a href="http://grails.org/plugin/spring-social-twitter">http://grails.org/plugin/spring-social-twitter</a></li>
      </ul>
	</body>
</html>
