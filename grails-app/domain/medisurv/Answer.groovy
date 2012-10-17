package medisurv

class Answer {
	String answer
	User patient
	
	
	String toString() {
		"$answer"
	}
	
	//static belongsTo = [question:Question]

    static constraints = {
		answer(blank:false)
		patient(nullable:false)
    }
}
