<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione</title>
    <link rel="stylesheet" href="styles/registrazione.css">
    <script src="scripts/validazione.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
</head>
<body>
    <a href="http://localhost:8080/CibusUNISA/home"><img src="images/LogoCibusUNISA.png" alt="Logo" id="logoSopra"></a>

    <form id="regForm" action="Registration" method="POST" onsubmit="return validate()" novalidate>
        <fieldset>
            <h3>Registrati</h3>
            <p>Tutti i campi sono obbligatori</p>

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
                <label for="phone">Telefono</label><br>
                <input type="tel" name="phone" id="phone" placeholder="##########" required pattern="^[0-9]{10}$"
                    onchange="validateFormElem(this, document.getElementById('errorPhone'), phoneErrorMessage)">
                <span id="errorPhone"></span>
            </div>

            <hr>

            <div>
                <label for="email">Email</label><br>
                <input type="email" name="email" id="email" required
                    onchange="validateFormElem(this, document.getElementById('errorEmail'), emailErrorMessage)">
                <span id="errorEmail"></span>
            </div>

            <div>
                <label for="password">Password</label><br>
                <input type="password" name="password" id="password" required 
                pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$"
                    onchange="validateFormElem(this, document.getElementById('errorPassword'), passwordErrorMessage)">
                <span id="errorPassword"></span>
            </div>

            <div>
                <input type="submit" value="Continua">
            </div>
            <br>
			<br>
			<p> Hai già un account? <a href="http://localhost:8080/CibusUNISA/login">Accedi</a>
        </fieldset>
    </form>
</body>
</html>