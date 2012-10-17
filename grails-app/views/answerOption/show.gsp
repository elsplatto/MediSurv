
<%@ page import="medisurv.AnswerOption" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'answerOption.label', default: 'AnswerOption')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="answerOption.id.label" default="Id" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: answerOptionInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="answerOption.inputType.label" default="Input Type" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: answerOptionInstance, field: "inputType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="answerOption.inputLabel.label" default="Input Label" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: answerOptionInstance, field: "inputLabel")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="answerOption.sequence.label" default="Sequence" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: answerOptionInstance, field: "sequence")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="answerOption.question.label" default="Question" /></td>
                            
                            <td  ="top" class="value"><g:link controller="question" action="show" id="${answerOptionInstance?.question?.id}">${answerOptionInstance?.question?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${answerOptionInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
