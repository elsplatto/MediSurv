
<%@ page import="medisurv.MediSurvey" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'mediSurvey.label', default: 'MediSurvey')}" />
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
                            <td  ="top" class="name"><g:message code="mediSurvey.id.label" default="Id" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: mediSurveyInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="mediSurvey.title.label" default="Title" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: mediSurveyInstance, field: "title")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="mediSurvey.dateCreated.label" default="Date Created" /></td>
                            
                            <td  ="top" class="value"><g:formatDate date="${mediSurveyInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="mediSurvey.status.label" default="Status" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: mediSurveyInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="mediSurvey.author.label" default="Author" /></td>
                            
                            <td  ="top" class="value"><g:link controller="user" action="show" id="${mediSurveyInstance?.author?.id}">${mediSurveyInstance?.author?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="mediSurvey.questions.label" default="Questions" /></td>
                            
                            <td  ="top" style="text-align: left;" class="value">
                                <ul class="buttonList sortable" data-controller="question" data-action="setSequence">
                                <g:each in="${mediSurveyInstance.questions}" var="q">
                                    <li data-id="${q?.id}"><g:link controller="question" action="show" id="${q.id}">${q?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${mediSurveyInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
