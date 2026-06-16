<%@page import="model.UtenteBean"%>
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
		</ul>
	</nav>
</header>


<main>
    <div class="hero-section">
		<img src="images/CibusUNISAHomePage.png" alt="foto HomePage" id="fotoHomeDesktop">
		<img src="images/CibusUNISAHomePageVerticale.png" alt="foto HomePage" id="fotoHomeTelefono">
	
	<div class="hero-testo">
            <h1>Benvenuto su CibusUNISA</h1>
            <p>Il cibo migliore, direttamente a casa tua o in ateneo.</p>
        </div>
    </div>
    
    <div class="main-container info-section">
        <div class="info-card">
            <h3>🍔 Scegli</h3>
            <p>Sfoglia il nostro menù e trova i tuoi piatti preferiti in pochi click.</p>
        </div>
        <div class="info-card">
            <h3>🛒 Ordina</h3>
            <p>Aggiungi i prodotti al carrello e completa il pagamento in modo sicuro.</p>
        </div>
        <div class="info-card">
            <h3>🚀 Gusta</h3>
            <p>Ricevi il tuo ordine caldo e pronto da mangiare dove vuoi tu!</p>
        </div>
    </div>
</main>


<footer>
&copy; 2026, CibusUNISA
</footer>

</body>
</html>