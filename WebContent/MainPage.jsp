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
	  <a href="#" class="links navbar">Sign Out</a>
	  <a href="#" class="links navbar">Link 3</a>
	</div>
	
	<div id = "main">
		<div id = "header">
			<button id = "menu" class = "content" onclick="openSidebar()">&#9776;</button>
			<form class = "content" onsubmit>
				<div id = "filter">
					<div id = "col1">
						<input id = "textbox" type = "text" name = "searchText" placeholder = "Search course or CP!"><br>
					</div>
					<div id = "col2">
						<input id = "search" src = "search.jpg" type = "image" onclick = "showResults()">
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
		var data = <%= session.getAttribute("data") %>;
		for(i = 0; i < data.length; i++) {
			$("#results").append('<div class = "container"><a href="\DetailsServ?id='+
				data[i].courseID+'"><img class = "img" src="profile.png"/></a>'
				+'<div class = "text"><h2>'+data[i].course+'</h2>'
				+'<h3>'+data[i].name+'</h3>'
				+'<p>Currently sitting in: '+data[i].location+'</p>'
				+'</div><p class = "status">Status: '+data[i].status+'<p></div>'
				+"<hr style='border-top: dotted 1px;' />");
		}
</script>
<script type="text/javascript" src="main.js"></script>
</html>