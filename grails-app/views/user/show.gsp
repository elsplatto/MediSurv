
<%@ page import="medisurv.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
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
                            <td  ="top" class="name"><g:message code="user.id.label" default="Id" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: userInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="user.firstName.label" default="First Name" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: userInstance, field: "firstName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="user.lastName.label" default="Last Name" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: userInstance, field: "lastName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="user.userName.label" default="User Name" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: userInstance, field: "userName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="user.password.label" default="Password" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: userInstance, field: "password")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="user.userCode.label" default="User Code" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: userInstance, field: "userCode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="user.role.label" default="Role" /></td>
                            
                            <td  ="top" class="value"><g:link controller="null" action="show" id="${userInstance?.role?.id}">${userInstance?.role?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  ="top" class="name"><g:message code="user.status.label" default="Status" /></td>
                            
                            <td  ="top" class="value">${fieldValue(bean: userInstance, field: "status")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${userInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
