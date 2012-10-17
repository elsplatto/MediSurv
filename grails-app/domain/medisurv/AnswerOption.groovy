package medisurv

class AnswerOption {
	Boolean isOther
	String inputLabel
	String questionType
	Question question
	int associatedScore
	int sequence
	
	static belongsTo = Question
	
    static constraints = {
		isOther(nullable:true)
		inputLabel(blank:true)
		questionType(blank:true)
		associatedScore(min:0)
		sequence(min:0)
    }

}
