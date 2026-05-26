<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info</title>
<link rel="stylesheet" href="styles/home.css">
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


<img alt="foto di cucina" src="images/Ragazzachefapanini.jpeg" id="fotoRagazza">
<h1> Informazioni su CibusUNISA</h1><br>
<h2>Progetto</h2>
<p> CibusUNISA non è solo un locale: è il rifugio perfetto per ogni studente 
affamato e il punto di ritrovo ideale tra un corso e l'altro. Sappiamo bene che la vita 
universitaria è fatta di lezioni infinite, sessioni di studio disperate in biblioteca 
e pause troppo brevi. Ecco perché siamo nati: per darti la giusta carica, unendo gusto, 
qualità e velocità.</p>

<h2>La nostra missione</h2>
<p> Vogliamo essere il tuo porto sicuro per la pausa pranzo, 
per uno spuntino al volo o per una cena post-esame. Il nostro obiettivo è semplice: 
offrire cibo delizioso, preparato al momento con ingredienti freschi, mantenendo prezzi 
a misura di studente.

<br>
<h2>Cosa trovi da noi</h2>
<p>Da CibusUNISA c'è un'opzione per ogni tipo di fame. Che tu sia in modalità "spuntino leggero" o "fame da lupi", il nostro menù non ti deluderà:
<ul>
<li>🍕 La Pizza: Calda, filante e cotta a puntino. Un classico intramontabile, perfetta da dividere con i colleghi o da divorare in solitaria.</li>
<li>🍔 I Panini: Piastrati alla perfezione e farciti fino all'orlo con ingredienti di prima scelta. Il pasto tattico da addentare al volo prima di correre in aula.</li>
<li>🌯 Il Kebab: Saporito, ricco e inconfondibile. L'energia allo stato puro per chi cerca un pasto sostanzioso che dia la spinta giusta per affrontare i tomi più pesanti.</li>
<li>🥤 Le Bevande: Dalle bibite ghiacciate all'acqua fresca, tutto ciò che serve per dissetarti e accompagnare ogni tuo morso</li>.
</ul>
"Che tu debba festeggiare un 30 e lode o consolarti dopo un appello andato male, un buon pasto da CibusUNISA è sempre la risposta giusta!"


<footer>
&copy; 2026, CibusUNISA
</footer>

</body>
</html>