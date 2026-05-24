<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registrazione</title>
<script src="scripts/validate.js"></script>

</head>
<body>

<h3>Registration</h3>
	<form id="regForm" action="Registration" method="POST">
		<fieldset>
			<legend>Informazioni</legend>
			<div>
				<label for="firstname">Nome:</label>
				<input type="text"
					name="firstname" id="firstname" required pattern="^[A-z]+$"
					onchange="validateFormElem(this, document.getElementById('errorName'), nameOrLastnameErrorMessage)">
				<span id="errorName"></span>
			</div>
			<div>
				<label for="lastname">Cognome:</label>
				<input type="text"
					name="lastname" id="lastname" required pattern="^[A-z]+$"
					onchange="validateFormElem(this, document.getElementById('errorLastname'), nameOrLastnameErrorMessage)">
				<span id="errorLastname"></span>
			</div>
			<div>
				<label for="email">Email:</label>
				<input type="email" name="email" required
					onchange="validateFormElem(this, document.getElementById('errorEmail'), emailErrorMessage)"
					id="email">
				<span id="errorEmail"></span>
			</div>
			<div>
				<label for="password">Password:</label>
				<input type="password" name="password" required
					onchange="validateFormElem(this, document.getElementById('errorPassword'), passwordErrorMessage)"
					id="password">
				<span id="errorPassword"></span>
			</div>
			<hr>
			<div id="phone">
				<label for="phone0">Telefono:</label>
				<input type="tel" name="phone" id="phone" placeholder="###-#######" required
					pattern="^([0-9]{3}-[0-9]{7})$"
					onchange="validateFormElem(this, document.getElementById('errorPhone'), phoneErrorMessage)">
				<span id="errorPhone"></span>
			</div>
			<div>
				<input type="submit" value="Register" onclick="return validate()">
				<input type="reset" value="Reset">
			</div>
		</fieldset>

</body>
</html>