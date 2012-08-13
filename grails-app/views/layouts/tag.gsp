
<%@ page import="lu.techup.Event" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>${tagInstance?.name} on Techup.lu</title>
    <meta name="description" content="${tagInstance?.name}">
	</head>
	<body>
    <header class="jumbotron subhead" id="overview">
        <div class="subnav">
          <ul class="nav nav-pills">
            <li class="dropdown ${(['list','past'].contains(params.action))?'active':''}">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Events ${title?"(<i>"+title+"</i>)":""} <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li ${(params.action=='list')?'class="active"':''}><g:link controller="Event" action="list" class="active">Upcoming</g:link></li>
                <li ${(params.action=='past')?"class='active'":''}><g:link controller="Event" action="past">Past</g:link></li>
                <li class="divider"></li>
                <li class="nav-header">Sort</li>
                <li><g:link controller="Event" action="popular">Popularity</g:link></li>
              </ul>
            </li>
            <sec:ifLoggedIn>
              <li ${(params.action=='create')?"class='active'":''}><g:link controller="Event" action="create">Submit Event</g:link></li>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
              <li ${(params.action=='create')?"class='active'":''}><a href="#" title="LogIn to submit an event">Submit Event</a></li>
            </sec:ifNotLoggedIn>   
          </ul>
        </div>
      </header>
		<div id="list-event" class="content scaffold-list" role="main">
      <h1><g:message code="techup.events.tags.selected" args="[tagInstance]"/></h1>
			<g:if test="${flash.message}">
			<div class="alert ${flash?.class}" role="status">
        <a class="close" data-dismiss="alert">×</a>
        ${flash.message}
      </div>
			</g:if>
      <g:layoutBody/>
		</div>
	</body>
</html>
