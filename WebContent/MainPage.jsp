<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<link rel="stylesheet" href="MainPage.css">
</head>
<body>
	<div style="display:none" id="mySidebar">
	  <button class="close navbar" onclick="closeSidebar()">Close &times;</button>
	  <a href="#" class="links navbar">Profile</a>
	  <a href="landingPage.jsp" class="links navbar">Sign Out</a>
	  <a href="#" class="links navbar">Link 3</a>
	</div>
	<div id = "main">
		<div id = "header">
			<button id = "menu" class = "content" onclick="openSidebar()">&#9776;</button>
			<form class = "content">
				<div id = "filter">
					<div id = "col1">
						<input id = "textbox" type = "text" name = "searchText" placeholder = "Search course or CP!"><br>
					</div>
					<div id = "col2">
						<input id = "search" src = "search.jpg" type = "image">
					</div>
				</div>
			</form>
			<img id = "icon" class = "content" src = "angryFace.png">
		</div>
		<div id = "results">
		</div>
	</div>
</body>
<script>

var data = <%= session.getAttribute("sessions") %>;
var sessions = data.list;

function renderData() {
	for(i = 0; i < sessions.length; i++) {
		$("#results").append('<div id = "' + i + '"'+ '><div class = "container"><a href="\DetailsServ?id='+
			sessions[i].course.id+'"><img class = "img" src="profile.png"/></a>'
			+'<div class = "text"><h2>'+sessions[i].course.title+'</h2>'
			+'<h3>'+sessions[i].CP.preferredName+'</h3>'
			+'<p>Session started: '+sessions[i].createdAt+'</p>'
			+'<p>Location: SAL Open Lab - '+sessions[i].location.name+'</p>'
			+'</div><p class = "status">Status: '+sessions[i].status.name+'<p></div>'
			+"<hr style='border-top: dotted 1px;' /></div>");
	}
}
	
	$( "#search" ).click(function() {
		var searchQuery = document.getElementById("textbox").value.toLowerCase();
		console.log(searchQuery);
		for(i = 0; i < data.length; i++) {
			// if searchQuery comes up dry
			if (((data[i].course).toLowerCase() != searchQuery)
				&& (data[i].name).toLowerCase() != searchQuery) {
				$("#"+i).hide();
			}
			else {
				$("#"+i).show();
			}
		}
		return false;
	});
	
	window.onload = renderData();
	
</script>
<script type="text/javascript" src="main.js"></script>
</html>