class MediSurvTagLib {

	def loginToggle = {
		out << "<div id=\"welcomePanel\">"
		if (session.user)
		{
			out << "<span class=\"welcome\">"
			out << "Welcome ${session.user}"
			out << "</span><span class=\"logout\">"
			out << "<a href=\"${createLink(controller:'user', action:'logout')}\">"
			out << "Logout </a></span>"
		} 
		else 
		{
			out << "<span style='float:right;margin-right:10px'>"
			out << "<a href='${createLink(controller:'user', action:'login')}'>"
			out << "Login </a></span>"
		}
		out << "</div>"
	}
	
	def mainNav = {
		out << "<div id=\"navHolder\">"
		out << "<div id=\"nav\">"
		out << "<ul>"
        out << "<li><a href=\"/MediSurv/mediSurvey/list\" class=\"list\">Questionairres</a></li>"
        out << "<li><a href=\"/MediSurv/mediSurvey/create\" class=\"list\">New Questionairre</a></li>"
		out << "</ul>"
        out << "</div>"
        out << "</div>"
	}
	
	
}