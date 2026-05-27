<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info</title>
<link rel="stylesheet" href="styles/home.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<header>
	<a href="home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>

	<nav>
		<ul> 
			<li><a href="home">Home</a>
			<li><a href="ordina">Ordina</a></li>
			<% if (session.getAttribute("utente") == null) { %>
			<li><a href="login">Accedi</a></li>
            
        	<% } else { %>
            <li><a href="storico">I miei ordini</a></li>
            <li><a href="logout">Disconnettiti</a></li>
        <% } %>
		</ul>
	</nav>
</header>


<img alt="foto di cucina" src="images/Ragazzachefapanini.jpeg" id="fotoHomeDesktop">
<img alt="foto di cucina" src="images/RagazzachefapaniniTelefono.png" id="fotoHomeTelefono">

<h1 class="info"> Informazioni su CibusUNISA</h1><br>
<h2 class="info">Progetto</h2>
<p class="info"> CibusUNISA non è solo un locale: è il rifugio perfetto per ogni studente 
affamato e il punto di ritrovo ideale tra un corso e l'altro. Sappiamo bene che la vita 
universitaria è fatta di lezioni infinite, sessioni di studio disperate in biblioteca 
e pause troppo brevi. Ecco perché siamo nati: per darti la giusta carica, unendo gusto, 
qualità e velocità.</p>

<h2 class="info">La nostra missione</h2>
<p class="info"> Vogliamo essere il tuo porto sicuro per la pausa pranzo, 
per uno spuntino al volo o per una cena post-esame. Il nostro obiettivo è semplice: 
offrire cibo delizioso, preparato al momento con ingredienti freschi, mantenendo prezzi 
a misura di studente.

<br>
<h2 class="info">Cosa trovi da noi</h2>
<div class="menu-grid">
  <div class="menu-card">
    <div class="menu-icon">🍕</div>
    <div class="menu-title">La Pizza</div>
    <p>Calda, filante e cotta a puntino. Un classico intramontabile, perfetta da dividere o divorare in solitaria.</p>
  </div>
  
  <div class="menu-card">
    <div class="menu-icon">🍔</div>
    <div class="menu-title">I Panini</div>
    <p>Piastrati alla perfezione e farciti fino all'orlo. Il pasto tattico da addentare al volo prima dell'aula.</p>
  </div>
  
  <div class="menu-card">
    <div class="menu-icon">🌯</div>
    <div class="menu-title">Il Kebab</div>
    <p>Saporito, ricco e inconfondibile. Energia pura per chi cerca un pasto sostanzioso.</p>
  </div>

  <div class="menu-card">
    <div class="menu-icon">🥤</div>
    <div class="menu-title">Le Bevande</div>
    <p>Dalle bibite ghiacciate all'acqua fresca, tutto ciò che serve per dissetarti e accompagnare ogni morso.</p>
  </div>
</div>

<div id=frase>
"Che tu debba festeggiare un 30 e lode o consolarti dopo un appello andato male, un buon pasto da CibusUNISA è sempre la risposta giusta!"
</div>

<footer>
&copy; 2026, CibusUNISA
</footer>

</body>
</html>