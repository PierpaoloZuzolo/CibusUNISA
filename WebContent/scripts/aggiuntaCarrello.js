function aggiungiAlCarrello(codiceProdotto) {
    fetch('CarrelloServlet?action=add&codice=' + codiceProdotto, {
        method: 'POST'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Errore del server durante l'aggiunta");
        }
        return response.json(); 
    })
    .then(carrelloLista => {
        let carrelloCard = document.getElementById("carrello-card");
        let carrelloVuoto = document.getElementById("carrello-vuoto");
        let btnCheckout = document.getElementById("btn-checkout");


        let listaItems = document.getElementById("carrello-lista-dinamica");
        if (!listaItems) {
            listaItems = document.createElement("div");
            listaItems.id = "carrello-lista-dinamica";
            carrelloCard.insertBefore(listaItems, btnCheckout);
        }


        if (carrelloLista.length === 0) {
            carrelloVuoto.style.display = "block";
            listaItems.innerHTML = "";
            btnCheckout.disabled = true;
        } else {
            carrelloVuoto.style.display = "none"; 
            listaItems.innerHTML = ""; 
            
            let totale = 0;
            

            carrelloLista.forEach(prodotto => {
                listaItems.innerHTML += `<p style="margin: 5px 0;"><strong>${prodotto.nome}</strong> - €${prodotto.prezzo.toFixed(2)}</p>`;
                totale += prodotto.prezzo;
            });
            
            listaItems.innerHTML += `<hr><h4 style="margin: 10px 0;">Totale: €${totale.toFixed(2)}</h4>`;
            btnCheckout.disabled = false; 
        }
    })
    .catch(error => {
        console.error("Errore AJAX:", error);
    });
}

function procediCheckout(isLoggato, contextPath) {
    if (!isLoggato) {
        window.location.href = contextPath + '/login';
    } else {
        window.location.href = contextPath + '/CheckoutServlet';
    }
}