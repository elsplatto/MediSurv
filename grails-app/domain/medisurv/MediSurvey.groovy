package medisurv

class MediSurvey {
	String title
	Date dateCreated
	String status
	User author

	def beforeInsert = {
		dateCreated = new Date()
		status = "Inactive"
	}
	
	String toString() {
		"$title"
	}
	
	static mapping = {
	    questions sort: 'sequence', order: 'asc'
	}
	
	static hasMany = [questions:Question]
	
    static constraints = {
		title(blank:false)
		dateCreated(nullable:true)
		status(nullable:true,inList:["Inactive","Active"])
		author(nullable:false)
    }

	
}
