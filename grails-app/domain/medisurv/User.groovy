package medisurv

class User {
	String firstName
	String lastName
	String userName
	String password
	String userCode
	String role
	String status
	
	String toString() {
		"$firstName $lastName"
	}
	
    static constraints = {
		firstName(blank:false)
		lastName(blank:false)
		userName(blank:false)
		password(blank:false)
		userCode(blank:true)
		role(blank:false,inList:(["Admin","Doctor","Patient"]))
		status(inList:["Active", "Inactive", "Pending"])
    }
}
