<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestione</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/gestione.css">
</head>
<body>
<header>
<a href="<%=request.getContextPath()%>/home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>
	
	<nav>
		<ul> 
			<li><a href="<%=request.getContextPath()%>/home">Home</a></li>
			<li><a href="<%=request.getContextPath()%>/ordina">Ordina</a></li>
			<li><a href="<%=request.getContextPath()%>/adminOrdini">Gestione ordini</a></li>
			
		</ul>
	</nav>
</header>


<div class="hero-section">
		<img src="images/GestioneCibus.jpeg" id="fotoDesktop">
		<img src="images/GestioneCibusMobile.jpeg" id="fotoMobile">
	
	
	<div class="hero-testo">
	
            <h1>Benvenuto nel menù admin di CibusUNISA</h1>
            <p>Il menù di oggi lo decidi tu. Benvenuto in cucina. Ciao admin 
            <%if (session.getAttribute("utente") != null ) {
            	model.UtenteBean u = (model.UtenteBean) session.getAttribute("utente"); 
            	%> 
            	<%=u.getNome() %>
            	<%}%> 
            	mettiti nei panni del conduttore Gerry Scotti! 
            	
            	</p>
        </div>
    </div>


<footer>
&copy; 2026, CibusUNISA
</footer>


</body>
</html>