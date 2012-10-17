

<%@ page import="medisurv.Question" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${questionInstance}">
            <div class="errors">
                <g:renderErrors bean="${questionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${questionInstance?.id}" />
                <g:hiddenField name="version" value="${questionInstance?.version}" />
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
                                  <label for="answerOptions"><g:message code="question.answerOptions.label" default="Answer Options" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: questionInstance, field: 'answerOptions', 'errors')}">
                                    
<ul class="buttonList sortable">
<g:each in="${questionInstance?.answerOptions?}" var="a">
    <li><g:link controller="answerOption" action="show" id="${a.id}">${a?.inputLabel.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="answerOption" action="create" params="['question.id': questionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'answerOption.label', default: 'AnswerOption')])}</g:link>

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
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
