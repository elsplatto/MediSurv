

<%@ page import="medisurv.Question" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${questionInstance}">
            <div class="errors">
                <g:renderErrors bean="${questionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                    <label for="question"><g:message code="question.question.label" default="Question" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: questionInstance, field: 'question', 'errors')}">
                                    <g:textField name="question" value="${questionInstance?.question}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                    <label for="sequence"><g:message code="question.sequence.label" default="Sequence" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: questionInstance, field: 'sequence', 'errors')}">
                                    <g:textField name="sequence" value="${fieldValue(bean: questionInstance, field: 'sequence')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                    <label for="survey"><g:message code="question.survey.label" default="Survey" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: questionInstance, field: 'survey', 'errors')}">
                                    <g:select name="survey.id" from="${medisurv.MediSurvey.list()}" optionKey="id" value="${questionInstance?.survey?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
