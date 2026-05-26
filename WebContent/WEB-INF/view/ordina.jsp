<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ordine</title>
<link rel="stylesheet" href="styles/home.css">

</head>
<body>
<header>

	<a href="home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>

	<nav>
		<ul> 
			<li><a href="home">Home</a>
			<li><a href="info">Chi siamo</a></li>
			<% if (session.getAttribute("utente") == null) { %>
			<li><a href="login">Accedi</a></li>
            
        	<% } else { %>
            <li><a href="storico">I miei ordini</a></li>
            <li><a href="logout">Disconnettiti</a></li>
        <% } %>
		</ul>
	</nav>
</header>


</body>
</html>