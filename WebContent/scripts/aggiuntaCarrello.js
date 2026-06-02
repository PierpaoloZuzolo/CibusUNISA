function aggiornaCarrello(url, contextPath) {
    fetch(url, {
        method: 'POST'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Errore del server durante l'aggiornamento del carrello");
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

            carrelloVuoto.classList.remove("nascosto");
            listaItems.innerHTML = "";
            btnCheckout.disabled = true;
        } else {
            carrelloVuoto.classList.add("nascosto"); 
            listaItems.innerHTML = ""; 
            
            let totale = 0;
            
			carrelloLista.forEach(item => {
			    let subTotale = item.prezzo * item.quantita;
			    totale += subTotale;
			    
			    listaItems.innerHTML += `
			    <div class="cart-item-row">
			        <span class="cart-item-nome">${item.nome} - €${item.prezzo.toFixed(2)}</span>
			        <div class="cart-item-actions">
			            <input type="number" value="${item.quantita}" min="1" class="cart-input-qty" onchange="modificaQuantita(${item.codice}, this.value, '${contextPath}')">
			            <button class="cart-btn-remove" onclick="rimuoviDalCarrello(${item.codice}, '${contextPath}')">🗑️</button>
			        </div>
			    </div>`;
			});
            
            listaItems.innerHTML += `<hr><h4>Totale: €${totale.toFixed(2)}</h4>`;
            btnCheckout.disabled = false; 
        }
    })
    .catch(error => {
        console.error("Errore AJAX:", error);
    });
}

function aggiungiAlCarrello(codiceProdotto, contextPath) {
    aggiornaCarrello(contextPath + '/CarrelloServlet?action=add&codice=' + codiceProdotto, contextPath);
}

function modificaQuantita(codiceProdotto, nuovaQuantita, contextPath) {
    aggiornaCarrello(contextPath + '/CarrelloServlet?action=update&codice=' + codiceProdotto + '&quantita=' + nuovaQuantita, contextPath);
}

function rimuoviDalCarrello(codiceProdotto, contextPath) {
    aggiornaCarrello(contextPath + '/CarrelloServlet?action=remove&codice=' + codiceProdotto, contextPath);
}

function procediCheckout(isLoggato, contextPath) {
    if (!isLoggato) {
        window.location.href = contextPath + '/login';
    } else {
        window.location.href = contextPath + '/CheckoutServlet';
    }
}