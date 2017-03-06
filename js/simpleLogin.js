var loggedInUser;

var users = {
	"admin": "admin",
	"provider": "provider",
	"user": "user",
};

function login(){
	var user = document.getElementById("username");
	var pw = document.getElementById("password");
	
	if(users[user.value] == pw.value){
		this.loggedInUser = user.value;
	} else {
		alert("Wrong credentials");
	}
	if(this.loggedInUser){
		location.href='admin.html';
	}
}