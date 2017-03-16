var users = {
	user1 : { username : "admin", password : "admin" },
	user2 : { username : "provider", password : "provider" },
	user3 : { username : "user", password : "user" },
};

function checkLogin(){
	if(checkCookie()){
		location.href='../pages/admin.xml'
	} else {
		location.href='../pages/login.xml'
	}
}

function login(){
	var user = $('#username').val();
	var pw = $('#password').val();

	if ((users.user1.username == user && users.user1.password == pw)
		|| (users.user2.username == user && users.user2.password == pw)
		|| (users.user3.username == user && users.user3.password == pw)) {

		$.cookie('username', user);
		$.cookie('password', pw);

		alert('Welcome '+user);
		location.href='../pages/admin.xml'
	} else {
		alert("Wrong credentials");
	}
}

function logout(){
	$.removeCookie('username');
	$.removeCookie('password');
	location.href='../index.html';
}

function checkCookie() {
	var username = $.cookie('username');
	var password = $.cookie('password');

	if (username != "" && password != "") {
		if ((users.user1.username == username && users.user1.password == password)
			|| (users.user2.username == username && users.user2.password == password)
			|| (users.user3.username == username && users.user3.password == password)) {
			return true;
		}
		else {
			return false;
		}
	} else {
		return false;
	}
}