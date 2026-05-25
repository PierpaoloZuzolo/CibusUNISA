const emailErrorMessage = "Email non valida";
const passwordErrorMessage = "Password non valida"
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
	
	let spanEmail = document.getElementById("errorEmail");
	if (!validateFormElem(form.email, spanEmail, emailErrorMessage)){
		valid = false;
	}
	
	let spanPassword = document.getElementById("errorPassword");
	if(!validateFormElem(form.password, spanPassword, passwordErrorMessage)){
		valid = false;
	}
		
	return valid;
}