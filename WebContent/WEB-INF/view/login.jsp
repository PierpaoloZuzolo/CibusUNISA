<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Accesso</title>
<link rel="stylesheet" href="styles/accesso.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
<a href="home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>
<script src="scripts/validazioneLogin.js"></script>

	<form id="logForm" action="login" method="POST" onsubmit="return validate()" novalidate>
		<fieldset>
			<h3>Accedi</h3>
			<div>
				<label for="email">Email</label><br>
				<input type="email" name="email" placeholder="mariorossi@gmail.com" required
					onchange="validateFormElem(this, document.getElementById('errorEmail'), emailErrorMessage)"
					id="email">
				<span id="errorEmail"></span>
			</div>
			<div>
				<label for="password">Password</label><br>
				<input type="password" name="password" required
					onchange="validateFormElem(this, document.getElementById('errorPassword'), passwordErrorMessage)"
					id="password">
				<span id="errorPassword"></span>
			</div>
			<div>
			<% if (request.getAttribute("errore") != null) { %>
   				 <div class="error">
      	    <%= request.getAttribute("errore") %>
    			</div>
			<% } %>
				<input type="submit" value="Continua" onclick="return validate()">
			</div>
			<hr>
			<p> Non hai un account? <a href="Registration">Registrati</a>
		</fieldset>
	</form>

</body>
</html>