<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registrazione</title>
<link rel="stylesheet" href="styles/stile.css">
<script src="scripts/validate.js"></script>

</head>
<body>
<img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra">

	<form id="regForm" action="Registration" method="POST">
		<fieldset>
			<h3>Creare account</h3>
			<p>Tutti i campi sono obbligatori
			<div>
				<label for="firstname">Nome</label><br>
				<input type="text"
					name="firstname" id="firstname" placeholder="Mario" required pattern="^[A-z]+$"
					onchange="validateFormElem(this, document.getElementById('errorName'), nameOrLastnameErrorMessage)">
				<span id="errorName"></span>
			</div>
			<div>
				<label for="lastname">Cognome</label><br>
				<input type="text"
					name="lastname" id="lastname" placeholder="Rossi" required pattern="^[A-z]+$"
					onchange="validateFormElem(this, document.getElementById('errorLastname'), nameOrLastnameErrorMessage)">
				<span id="errorLastname"></span>
			</div>
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
			<hr>
			<div id="phone">
				<label for="phones">Telefono</label><br>
				<input type="tel" name="phone" id="phone" placeholder="##########" required
					pattern="^([0-9]{10})$"
					onchange="validateFormElem(this, document.getElementById('errorPhone'), phoneErrorMessage)">
				<span id="errorPhone"></span>
			</div>
			<div>
				<input type="submit" value="Continua" onclick="return validate()">
			</div>
		</fieldset>
	</form>

</body>
</html>