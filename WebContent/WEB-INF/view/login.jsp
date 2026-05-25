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
<a href="http://localhost:8080/CibusUNISA/home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>

	<form id="logForm" action="Accesso" method="POST">
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
				<input type="submit" value="Continua" onclick="return validate()">
			</div>
			<br>
			<br>
			<p> Non hai un account? <a href="http://localhost:8080/CibusUNISA/Registration">Registrati</a>
		</fieldset>
	</form>

</body>
</html>