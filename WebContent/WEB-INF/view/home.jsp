<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CibusUNISA</title>
<link rel="stylesheet" href="styles/home.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<header>
	<a href="<%=request.getContextPath()%>/home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>

	<nav>
		<ul> 
			<li><a href="<%=request.getContextPath()%>/info">Chi siamo</a></li>
			<li><a href="<%=request.getContextPath()%>/ordina">Ordina</a></li>
			<% if (session.getAttribute("utente") == null) { %>
			<li><a href="<%=request.getContextPath()%>/login">Accedi</a></li>
            
        	<% } else { %>
            <li><a href="<%=request.getContextPath()%>/storico">I miei ordini</a></li>
            <li><a href="<%=request.getContextPath()%>/logout">Disconnettiti</a></li>
        <% } %>
		</ul>
	</nav>
</header>

<img src="images/CibusUNISAHomePage.png" alt="foto HomePage" id="fotoHomeDesktop">
<img src="images/CibusUNISAHomePageVerticale.png" alt="foto HomePage" id="fotoHomeTelefono">


<footer>
&copy; 2026, CibusUNISA
</footer>

</body>
</html>