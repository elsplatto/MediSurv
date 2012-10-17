package medisurv

class MediSurveyController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [mediSurveyInstanceList: MediSurvey.list(params), mediSurveyInstanceTotal: MediSurvey.count()]
    }

    def create = {
        def mediSurveyInstance = new MediSurvey()
        mediSurveyInstance.properties = params
		def questionInstance = new Question()
	    questionInstance.properties = params
        return [mediSurveyInstance: mediSurveyInstance,questionInstance:questionInstance]
    }

    def save = {
        def mediSurveyInstance = new MediSurvey(params)
        if (mediSurveyInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'mediSurvey.label', default: 'MediSurvey'), mediSurveyInstance.id])}"
            redirect(action: "show", id: mediSurveyInstance.id)
        }
        else {
            render(view: "create", model: [mediSurveyInstance: mediSurveyInstance])
        }
    }

	def ajaxSurveySave = {
		def mediSurveyInstance = new MediSurvey(params)
		def saveDetails = mediSurveyInstance.save(flush: true)
		if (saveDetails) {			
            render(contentType: "text/json") {
				result(
					success: true,
		        	message: "Survey successfully saved",
					newID: saveDetails.id,
					version: saveDetails.version)
		    }
        }
        else {
             render(contentType: "text/json") {
				result(
					success: false,
			       	message: "There was an error saving the survey")
			 }
        }
	}
	
	def ajaxSurveyUpdate = {
		def mediSurveyUpdateInstance = MediSurvey.get(params.id)
        if (mediSurveyUpdateInstance) {
			println "==================================="
			println "All params: " + params
			println "Upate survey title"
			println "title: ["+mediSurveyUpdateInstance.title+"]"
			println "id: ["+mediSurveyUpdateInstance.id+"]"
            if (params.version) {
                def version = params.version.toLong()
                if (mediSurveyUpdateInstance.version > version) {
					println "collision issue"
                    render(contentType: "text/json") 
					{
						result(
						success: false,
				       	message: "Another user has updated this Survey while you were editing")
				 	}
                }
            }
            mediSurveyUpdateInstance.properties = params
            if (!mediSurveyUpdateInstance.hasErrors() && mediSurveyUpdateInstance.save(flush: true)) {
				println "good update"
				println "version["+mediSurveyUpdateInstance.version+"]"
                render(contentType: "text/json") {
					result(
						success: true,
			        	message: "Survey successfully updated",
						version: mediSurveyUpdateInstance.version)
			    }
            }
            else {
				println "unknown error"
                render(contentType: "text/json") {
					result(
						success: false,
				       	message: "There was an error updating the survey")
				 }
            }
        }
        else {
			println "retrieve record issue"
            render(contentType: "text/json") {
				result(
					success: false,
			       	message: "There was an error updating the survey - unable to get the record")
			 }
        }

		println "==================================="
	}

    def show = {
        def mediSurveyInstance = MediSurvey.get(params.id)
        if (!mediSurveyInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mediSurvey.label', default: 'MediSurvey'), params.id])}"
            redirect(action: "list")
        }
        else {
            [mediSurveyInstance: mediSurveyInstance]
        }
    }

    def edit = {
		println 'Survey Edit Called'
        def mediSurveyInstance = MediSurvey.get(params.id)
        if (!mediSurveyInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mediSurvey.label', default: 'MediSurvey'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [mediSurveyInstance: mediSurveyInstance]
        }
    }

    def update = {
        def mediSurveyInstance = MediSurvey.get(params.id)
        if (mediSurveyInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (mediSurveyInstance.version > version) {
                    
                    mediSurveyInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'mediSurvey.label', default: 'MediSurvey')] as Object[], "Another user has updated this MediSurvey while you were editing")
                    render(view: "edit", model: [mediSurveyInstance: mediSurveyInstance])
                    return
                }
            }
            mediSurveyInstance.properties = params
            if (!mediSurveyInstance.hasErrors() && mediSurveyInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'mediSurvey.label', default: 'MediSurvey'), mediSurveyInstance.id])}"
                redirect(action: "show", id: mediSurveyInstance.id)
            }
            else {
                render(view: "edit", model: [mediSurveyInstance: mediSurveyInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mediSurvey.label', default: 'MediSurvey'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def mediSurveyInstance = MediSurvey.get(params.id)
        if (mediSurveyInstance) {
            try {
                mediSurveyInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'mediSurvey.label', default: 'MediSurvey'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'mediSurvey.label', default: 'MediSurvey'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mediSurvey.label', default: 'MediSurvey'), params.id])}"
            redirect(action: "list")
        }
    }
}
