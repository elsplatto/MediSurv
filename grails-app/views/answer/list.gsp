
<%@ page import="medisurv.Answer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'answer.label', default: 'Answer')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'answer.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="answer" title="${message(code: 'answer.answer.label', default: 'Answer')}" />
                        
                            <th><g:message code="answer.patient.label" default="Patient" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${answerInstanceList}" status="i" var="answerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${answerInstance.id}">${fieldValue(bean: answerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: answerInstance, field: "answer")}</td>
                        
                            <td>${fieldValue(bean: answerInstance, field: "patient")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${answerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
