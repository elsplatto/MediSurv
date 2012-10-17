
<%@ page import="medisurv.AnswerOption" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'answerOption.label', default: 'AnswerOption')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'answerOption.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="questionType" title="${message(code: 'answerOption.questionType.label', default: 'Input Type')}" />
                        
                            <g:sortableColumn property="inputLabel" title="${message(code: 'answerOption.inputLabel.label', default: 'Input Label')}" />
                        
                            <g:sortableColumn property="sequence" title="${message(code: 'answerOption.sequence.label', default: 'Sequence')}" />
                        
                            <th><g:message code="answerOption.question.label" default="Question" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${answerOptionInstanceList}" status="i" var="answerOptionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${answerOptionInstance.id}">${fieldValue(bean: answerOptionInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: answerOptionInstance, field: "questionType")}</td>
                        
                            <td>${fieldValue(bean: answerOptionInstance, field: "inputLabel")}</td>
                        
                            <td>${fieldValue(bean: answerOptionInstance, field: "sequence")}</td>
                        
                            <td>${fieldValue(bean: answerOptionInstance, field: "question")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${answerOptionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
