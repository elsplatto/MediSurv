class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}
		"/answerOption/newMulti"(view:"/answerOption/newMulti")
		"/answerOption/resetMulti"(view:"/answerOption/resetMulti")
		"/answerOption/ajaxDeleteAnswerOption"(view:"/answerOption/ajaxDeleteAnswerOption")
		"/"(view:"/index")
		"500"(view:'/error')
	}
}
