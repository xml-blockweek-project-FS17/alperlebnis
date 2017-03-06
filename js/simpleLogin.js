var loggedInUser;

var users = {
	"admin": "admin",
	"provider": "provider",
	"user": "user",
};

function needLogin(){
	if(document.cookie != ""){
		location.href='admin.html';
	} else {
		doXSLT('pages/logIn.xml', 'pages/logIn.xsl', 'content');
	}
}

function login(){
	var user = document.getElementById("username");
	var pw = document.getElementById("password");
	
	if(users[user.value] == pw.value){
		document.cookie = user.value;
		location.href='admin.html';
	} else {
		alert("Wrong credentials");
	}
}

function logout(){
	document.cookie = "";
	location.href='index.html';
}