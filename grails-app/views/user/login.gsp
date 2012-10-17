
<%@ page import="medisurv.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title>Login</title>
    </head>
    <body>
        <!--div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div-->
        <div class="body">
			<div class="contentArea">
	            <g:if test="${flash.message}">
	            <div class="message">${flash.message}</div>
	            </g:if>
	            <div class="dialog">
	                <g:form id="frmLogin" action="validate">
					<fieldset id="fsetLogin">
						<input type="hidden" name="cName" value="${cName}" >
						<input type="hidden" name="aName" value="${aName}" >
					<label for="username">Username:</label>
					<input type="text" id="username" name="username" value="" />
				
				
					<label for="password">Password:</label>
					<input type="password" id="password" name="password" value="" />
				
					<input type="submit" value="Login" />
					</fieldset>
					</g:form>
	            </div>
            </div>
        </div>
    </body>
</html>
