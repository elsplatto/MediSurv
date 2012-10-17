

<%@ page import="medisurv.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
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
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${userInstance?.id}" />
                <g:hiddenField name="version" value="${userInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                  <label for="firstName"><g:message code="user.firstName.label" default="First Name" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: userInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${userInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                  <label for="lastName"><g:message code="user.lastName.label" default="Last Name" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: userInstance, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${userInstance?.lastName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                  <label for="userName"><g:message code="user.userName.label" default="User Name" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: userInstance, field: 'userName', 'errors')}">
                                    <g:textField name="userName" value="${userInstance?.userName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                  <label for="password"><g:message code="user.password.label" default="Password" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">
                                    <g:textField name="password" value="${userInstance?.password}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                  <label for="userCode"><g:message code="user.userCode.label" default="User Code" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: userInstance, field: 'userCode', 'errors')}">
                                    <g:textField name="userCode" value="${userInstance?.userCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                  <label for="role"><g:message code="user.role.label" default="Role" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: userInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${medisurv.Role.list()}" optionKey="id" value="${userInstance?.role?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  ="top" class="name">
                                  <label for="status"><g:message code="user.status.label" default="Status" /></label>
                                </td>
                                <td  ="top" class="value ${hasErrors(bean: userInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${userInstance.constraints.status.inList}" value="${userInstance?.status}" valueMessagePrefix="user.status"  />
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
