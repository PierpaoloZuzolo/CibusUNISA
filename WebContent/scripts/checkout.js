function inviaOrdine(contextPath) {
    let indirizzo = document.getElementById("indirizzo").value.trim();
    let metodoPagamento = document.getElementById("metodoPagamento").value;
    let divErrore = document.getElementById("errore-checkout");
    let container = document.getElementById("checkout-container");
    

    let regexIndirizzo = /^[a-zA-Z0-9\s,.-]{5,}$/; 
    
    if (indirizzo === "") {
        divErrore.innerText = "Errore: L'indirizzo di spedizione è obbligatorio.";
        return;
    }
    
    if (!regexIndirizzo.test(indirizzo)) {
        divErrore.innerText = "Errore: Inserisci un indirizzo valido (es. Via Roma 1, Milano).";
        return;
    }
    
    if (metodoPagamento === "") {
        divErrore.innerText = "Errore: Seleziona un metodo di pagamento.";
        return;
    }
    

    divErrore.innerText = ""; 


    let params = new URLSearchParams();
    params.append('indirizzo', indirizzo);
    params.append('metodoPagamento', metodoPagamento);

    fetch(contextPath + '/checkout', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Errore del server durante l'invio dell'ordine");
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            container.innerHTML = `
                <h3>Pagamento riuscito! Ordine Confermato.</h3>
                <p>Grazie per il tuo acquisto. Il tuo ordine è stato registrato nei nostri sistemi.</p>
                <br>
                <a href="${contextPath}/home" class="btn-conferma">Torna alla Home</a>
            `;
        } else {
            divErrore.innerText = "Si è verificato un errore durante l'ordine. Riprova.";
        }
    })
    .catch(error => {
        divErrore.innerText = "Errore di connessione. Riprova più tardi.";
        console.error('Errore AJAX:', error);
    });
}