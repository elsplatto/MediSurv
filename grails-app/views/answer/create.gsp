

<%@ page import="medisurv.Answer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'answer.label', default: 'Answer')}" />
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
            <g:hasErrors bean="${answerInstance}">
            <div class="errors">
                <g:renderErrors bean="${answerInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                    <label for="answer"><g:message code="answer.answer.label" default="Answer" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: answerInstance, field: 'answer', 'errors')}">
                                    <g:textField name="answer" value="${answerInstance?.answer}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                    <label for="patient"><g:message code="answer.patient.label" default="Patient" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: answerInstance, field: 'patient', 'errors')}">
                                    <g:select name="patient.id" from="${medisurv.User.list()}" optionKey="id" value="${answerInstance?.patient?.id}"  />
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
