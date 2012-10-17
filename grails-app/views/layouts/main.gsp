<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
		<div id="headerHolder">
        	<div id="header">
				<div id="govLogo"><img src="${resource(dir:'images',file:'nswGovSm.gif')}" width="82" height="55" alt="NSW Government Logo" border="0" />
					<span class="state">New South Wales Government</span><br />
					<span class="department">NSW Ministry of Health</span><br />
					<span class="region">Northern Sydney Central Coast Health</span>
				</div>
				<g:loginToggle />
			</div>
		</div>
		<g:mainNav />
	
		
        <g:layoutBody />
    </body>	
	<g:javascript library="jquery" plugin="jquery" />
	<g:javascript library="jquery/jquery-calls" />
	<g:javascript library="jquery-tools/jquery.tools.min" />
</html>