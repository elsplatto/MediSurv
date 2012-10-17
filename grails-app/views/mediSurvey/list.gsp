
<%@ page import="medisurv.MediSurvey" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'mediSurvey.label', default: 'MediSurvey')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
			<div class="contentArea">
            	<h1><g:message code="default.list.label" args="[entityName]" /></h1>
	            <g:if test="${flash.message}">
	            <div class="message">${flash.message}</div>
	            </g:if>
	            <div class="list">
	                <table>
	                    <thead>
	                        <tr>
                        
	                            <!--g:sortableColumn property="id" title="${message(code: 'mediSurvey.id.label', default: 'Id')}" /-->
                        
	                            <g:sortableColumn property="title" title="${message(code: 'mediSurvey.title.label', default: 'Title')}" />
                        
	                            <g:sortableColumn property="dateCreated" title="${message(code: 'mediSurvey.dateCreated.label', default: 'Date Created')}" />
                        
	                            <g:sortableColumn property="status" title="${message(code: 'mediSurvey.status.label', default: 'Status')}" />
                        
	                            <th><g:message code="mediSurvey.author.label" default="Author" /></th>
                        
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <g:each in="${mediSurveyInstanceList}" status="i" var="mediSurveyInstance">
	                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
	                            <!--td><g:link action="edit" id="${mediSurveyInstance.id}">${fieldValue(bean: mediSurveyInstance, field: "id")}</g:link></td-->
                        
	                            <td><g:link action="edit" id="${mediSurveyInstance.id}">${fieldValue(bean: mediSurveyInstance, field: "title")}</g:link></td>
                        
	                            <td><g:formatDate date="${mediSurveyInstance.dateCreated}" /></td>
                        
	                            <td>${fieldValue(bean: mediSurveyInstance, field: "status")}</td>
                        
	                            <td>${fieldValue(bean: mediSurveyInstance, field: "author")}</td>
                        
	                        </tr>
	                    </g:each>
	                    </tbody>
	                </table>
	            </div>
	            <div class="paginateButtons">
	                <g:paginate total="${mediSurveyInstanceTotal}" />
	            </div>
			</div>
        </div>
    </body>
</html>
