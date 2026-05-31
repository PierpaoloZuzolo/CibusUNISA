<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestione</title>
<link rel="stylesheet" href="styles/gestione.css">
</head>
<body>
<header>
<a href="<%=request.getContextPath()%>/home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>
	
	<nav>
		<ul> 
			<li><a href="<%=request.getContextPath()%>/home">Home</a></li>
			<li><a href="<%=request.getContextPath()%>/home">Ordini</a></li>
			<li><a href="<%=request.getContextPath()%>/home">Menu</a></li>
		</ul>
	</nav>
</header>

<p>Questa finestra è visualizzabile solo dagli admin. Bentornato <% 
	model.UtenteBean u = (model.UtenteBean) request.getAttribute("utente");
	out.print(u.getRuolo()+" "+u.getNome()+" "+u.getCognome());
%> 

<img src="images/GestioneCibus.jpeg">


</body>
</html>