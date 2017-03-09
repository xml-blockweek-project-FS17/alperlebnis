var loggedInUser;

var users = {
	user1 : { username : "admin", password : "admin" },
	user2 : { username : "provider", password : "provider" },
	user3 : { username : "user", password : "user" },
};

function checkLogin(){
	if(checkCookie()){
		location.href='../adminarea.html';
	} else {
		location.href='../admin.html';
	}
}

function login(){
	var user = document.getElementById("username");
	var pw = document.getElementById("password");

	if ((users.user1.username == user.value && users.user1.password == pw.value)
		|| (users.user2.username == user.value && users.user2.password == pw.value)
		|| (users.user3.username == user.value && users.user3.password == pw.value)) {
		setCookie('username', user.value, 365);
		setCookie('password', pw.value, 365);

		//document.cookie = '"username='+user.value+'; password='+pw.value+'"';
		//alert('"username='+user.value+'; password='+pw.value+'"');
		alert('Welcome '+user.value);
		location.href='../adminarea.html';
	} else {
		alert("Wrong credentials");
	}
}

function logout(){
	delete_cookie('username');
	delete_cookie('password');
	location.href='../index.html';
}

function getCookie(cname) {
	var name = cname + "=";
	var decodedCookie = decodeURIComponent(document.cookie);
	var ca = decodedCookie.split(';');
	for(var i = 0; i <ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') {
			c = c.substring(1);
		}
		if (c.indexOf(name) == 0) {
			return c.substring(name.length, c.length);
		}
	}
	return "";
}

function checkCookie() {
	var username = getCookie("username");
	var password = getCookie("password");
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

function setCookie(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays*24*60*60*1000));
	var expires = "expires="+ d.toUTCString();
	document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function delete_cookie( name ) {
	document.cookie = name +'=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}