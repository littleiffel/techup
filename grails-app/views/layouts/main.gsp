<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title><g:layoutTitle default="techup.lu - Luxembourg Tech/Hacker/Geek Meetups"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Techup.lu - Is a community driven meetup listing site for technical and non-technical events. Whenever you think a Geek or Hacker might be interested submit your events here. Hit the attend button and show the community which events you attend and help the organisators get an overview of the number of people that plan to come.">
    <meta name="keywords" content="agenda, technical, workshops, presentation, meetup, hacker, geek, nerd, event, camp, luxembourg, esch, hack, lu, mobile">
    <meta name="author" content="littleiffel">
    <!-- Le style --> 
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'application.min.css')}" type="text/css">
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${resource(dir: 'images', file: 'logo-114.png')}">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${resource(dir: 'images', file: 'logo-72.png')}">
    <link rel="apple-touch-icon-precomposed" href="${resource(dir: 'images', file: 'logo-57.png')}">
    <feed:meta kind="atom" version="1.0" controller="feed" action="latest" params="['version':'1.0', 'format':'atom']"/>
    <feed:meta kind="rss" version="2.0" controller="feed" action="latest" params="['version':'2.0', 'format':'rss']"/>
    <script src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"
      type="text/javascript"></script>
    <script src="http://platform.twitter.com/anywhere.js?id=iQEIyFvmeRui8eXNlnaOnA&v=1" type="text/javascript"></script>
    <meta name="google-site-verification" content="ZZ5gP8WuKafiw-BQVoJJGwlmv3WpfxxCJcA2lw7p_aE" />
    <script type="text/javascript" src="${resource(dir: 'js', file: 'Markdown.Converter.js')}"></script>
    <jq:resources/>
    <g:layoutHead/>
  </head>
  <body>
    <div id="fb-root"></div>
    <script>
      (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_GB/all.js#xfbml=1&appId=441730402514715";
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));
    </script>
    <header>
      <div class="logo">
        <div class="main-logo">
          <span class="tech">tech</span>
          <span class="up">up</span>
          <span class="lu">.lu</span>
        </div>
        <div class="sub-logo">
          <span class="nerds-tech">nerds/tech/geeks</span>
          <span class="luxembourg">luxembourg</span>
          <span class="meetup">meetups</span>
        </div>
      </div>
    </header>
    <div id="banner">
      <ul class="links">
        <li><g:link controller="Event" action="list">Upcoming&thinsp;${upcomingCount?'('+upcomingCount+')':''}</g:link></li>
        <li><g:link controller="Event" action="past">Past&thinsp;${pastCount?'('+pastCount+')':''}</g:link></li>
        <li><g:link controller="Event" action="create">Submit Event</g:link></li>    
        <sec:ifLoggedIn>
          <li><techup:currentuser /></li>
          <li><g:link controller="Logout">Logout</g:link></li>
        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
          <li><twitterAuth:button/></li>
        </sec:ifNotLoggedIn>
      </ul>
    </div>
    <div id="content" role="main">
      <g:if test="${flash.message}">
        <div class="alert ${flash?.class}" role="status">
          <a class="close" data-dismiss="alert">×</a>
          ${flash.message}
        </div>
      </g:if>
      <g:layoutBody/>
    </div> 
    <footer>
      <g:link url="/about">About techup</g:link>  <a href="https://twitter.com/Techup_lu" class="twitter-follow-button" data-show-count="false">Follow @Techup_lu</a>  
      <span class="right  hidden-phone">
        by <a href="http://www.twitter.com/#!/littleiffel" alt="littleiffel" class="hovercard twitter-anywhere-user">littleiffel</a> | <a href="http://www.techup.lu/feed/latest?version=2.0&format=rss" title="RSS for Latest Events on Techup.lu - by submission date"><img src="${resource( dir:'images', file:'feed.png')}" /></a>
      </span>
    </footer>
    <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
    <!-- Le javascript
    ================================================== -->

    <script src="${resource(dir: 'js', file: 'bootstrap-tab.js')}"></script>
    <script src="${resource(dir: 'js', file: 'bootstrap-alert.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'moment.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.8.18.custom.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'tagit.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'application.js')}"></script>
    <script type="text/javascript">
      twttr.anywhere(function(T) {
        var $;
        $ = jQuery;

        T(".hovercard").hovercards({
            linkify: false,
            username: function(node) {
                console.log($(node).attr('alt'));
                return $(node).attr('alt');
            },
            expanded: true
        });
      });

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-1026612-7']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    </script>
</html>