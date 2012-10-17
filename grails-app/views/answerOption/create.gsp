

<%@ page import="medisurv.AnswerOption" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'answerOption.label', default: 'AnswerOption')}" />
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
            <g:hasErrors bean="${answerOptionInstance}">
            <div class="errors">
                <g:renderErrors bean="${answerOptionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                    <label for="inputType"><g:message code="answerOption.inputType.label" default="Input Type" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: answerOptionInstance, field: 'inputType', 'errors')}">
                                    <g:select name="inputType" from="${answerOptionInstance.constraints.inputType.inList}" value="${answerOptionInstance?.inputType}" valueMessagePrefix="answerOption.inputType"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                    <label for="inputLabel"><g:message code="answerOption.inputLabel.label" default="Input Label" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: answerOptionInstance, field: 'inputLabel', 'errors')}">
                                    <g:textField name="inputLabel" value="${answerOptionInstance?.inputLabel}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                    <label for="sequence"><g:message code="answerOption.sequence.label" default="Sequence" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: answerOptionInstance, field: 'sequence', 'errors')}">
                                    <g:textField name="sequence" value="${fieldValue(bean: answerOptionInstance, field: 'sequence')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                    <label for="question"><g:message code="answerOption.question.label" default="Question" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: answerOptionInstance, field: 'question', 'errors')}">
                                    <g:select name="question.id" from="${medisurv.Question.list()}" optionKey="id" value="${answerOptionInstance?.question?.id}"  />
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
