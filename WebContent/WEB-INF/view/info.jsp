<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/info.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<header>
	<a href="<%=request.getContextPath()%>/home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>

	<nav>
		<ul> 
			<li><a href="<%=request.getContextPath()%>/home">Home</a></li>
			<li><a href="<%=request.getContextPath()%>/ordina">Ordina</a></li>
		</ul>
	</nav>
</header>

<div class="hero-section">
		<img src="images/Ragazzachefapanini.jpeg" alt="foto di cucina" id="fotoHomeDesktop">
		<img src="images/RagazzachefapaniniTelefono.png" alt="foto di cucina" id="fotoHomeTelefono">
	
	<div class="hero-testo">
            <h1>Informazioni su CibusUNISA</h1>
            <p>Il gusto da vera star di Hollywood, ma con prezzi a misura di studente. Il delivery realizzato da Margot Robbie.</p>
        </div>
    </div>
    

<div class="card-info">
	<div class="card-p">
		<h2 class="infoTitolo">Progetto</h2>
		<p class="info"> CibusUNISA non è solo un locale: è il rifugio perfetto per ogni studente 
		affamato e il punto di ritrovo ideale tra un corso e l'altro. Sappiamo bene che la vita 
		universitaria è fatta di lezioni infinite, sessioni di studio disperate in biblioteca 
		e pause troppo brevi. Ecco perché siamo nati: per darti la giusta carica, unendo gusto, 
		qualità e velocità.</p>
	</div>
	
	<div class="card-p">
		<h2 class="infoTitolo">La nostra missione</h2>
		<p class="info"> Vogliamo essere il tuo porto sicuro per la pausa pranzo, 
		per uno spuntino al volo o per una cena post-esame. Il nostro obiettivo è semplice: 
		offrire cibo delizioso, preparato al momento con ingredienti freschi, mantenendo prezzi 
		a misura di studente.
	</div>

</div>

<br>
<h2 class="infoTitolo">Cosa trovi da noi</h2>
<div class="menu-grid">
  <div class="menu-card">
    <div class="menu-icon">🍕</div>
    <div class="menu-title">La Pizza</div>
    <p class="p-card">Calda, filante e cotta a puntino. Un classico intramontabile, perfetta da dividere o divorare in solitaria.</p>
  </div>
  
  <div class="menu-card">
    <div class="menu-icon">🍔</div>
    <div class="menu-title">I Panini</div>
    <p class="p-card">Piastrati alla perfezione e farciti fino all'orlo. Il pasto tattico da addentare al volo prima dell'aula.</p>
  </div>
  
  <div class="menu-card">
    <div class="menu-icon">🌯</div>
    <div class="menu-title">Il Kebab</div>
    <p class="p-card">Saporito, ricco e inconfondibile. Energia pura per chi cerca un pasto sostanzioso.</p>
  </div>

  <div class="menu-card">
    <div class="menu-icon">🥤</div>
    <div class="menu-title">Le Bevande</div>
    <p class="p-card">Dalle bibite ghiacciate all'acqua fresca, tutto ciò che serve per dissetarti e accompagnare ogni morso.</p>
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