const nameOrLastnameErrorMessage = "Usa solo lettere.";
const emailErrorMessage = "Formato richiesto: nome@dominio.it";
const phoneErrorMessage = "Inserire esattamente 10 cifre.";
const passwordErrorMessage = "La password deve contenere almeno 6 caratteri e un carattere speciale.";
const emptyFieldErrorMessage = "Campo obbligatorio.";

function validateFormElem(formElem, span, errorMessage) {
    if (formElem.checkValidity()) {
        formElem.classList.remove("error");
        span.style.color = "black";
        span.innerHTML = "";
        return true;
    }
    formElem.classList.add("error");
    span.style.color = "red";
    if (formElem.validity.valueMissing) {
        span.innerHTML = emptyFieldErrorMessage;
    } else {
        span.innerHTML = errorMessage;
    }
    return false;
}

function validate() {
	let valid = true;	
	let form = document.getElementById("regForm");
	
	let spanName = document.getElementById("errorName");
	if(!validateFormElem(form.firstname, spanName, nameOrLastnameErrorMessage)){
		valid = false;
	} 
	
	let spanLastname = document.getElementById("errorLastname");
	if (!validateFormElem(form.lastname, spanLastname, nameOrLastnameErrorMessage)){
		valid = false;
	}
	
	let spanEmail = document.getElementById("errorEmail");
	if (!validateFormElem(form.email, spanEmail, emailErrorMessage)){
		valid = false;
	}
	
	
	let spanPhone = document.getElementById("errorPhone");
	if (!validateFormElem(form.phone, spanPhone, phoneErrorMessage)){
		valid = false;
	}
	
	let spanPassword = document.getElementById("errorPassword");
	if(!validateFormElem(form.password, spanPassword, passwordErrorMessage)){
		valid = false;
	}
		
	return valid;
}