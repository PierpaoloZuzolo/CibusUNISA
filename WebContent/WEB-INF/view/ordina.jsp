<%@page import="model.ProdottoBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ordine</title>
<link rel="stylesheet" href="styles/home.css">
<script src="scripts/aggiuntaCarrello.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
<header>
	<a href="home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>

	<nav>
		<ul> 
			<li><a href="<%=request.getContextPath()%>/home">Home</a>
			<li><a href="<%=request.getContextPath()%>/info">Chi siamo</a></li>
			<% if (session.getAttribute("utente") == null) { %>
			<li><a href="<%=request.getContextPath()%>/login">Accedi</a></li>
			<li><a href="<%=request.getContextPath()%>/Registration">Registrati</a></li>
            
        	<% } else {	%>
            <li><a href="<%=request.getContextPath()%>/storico">I miei ordini</a></li>
            <li><a href="<%=request.getContextPath()%>/logout">
            <%
				model.UtenteBean u = (model.UtenteBean) session.getAttribute("utente"); 
				out.print ("Ciao " + u.getNome() + "! (Logout)");
			%></a></li>
			<li><a href="<%=request.getContextPath()%>/gestione">
			<%
				if(u.getRuolo().equals("admin")){%>
				Gestione</a></li>
			<%	
				}
			%>

			<% } %>
			
		</ul>
	</nav>
</header>

<div class="main-container">
   	<div class="menu-sezione">
      
        <%
        java.util.List<model.ProdottoBean> catalogo = (java.util.List<ProdottoBean>) request.getAttribute("catalogo");
        
        if(catalogo != null) { 
        	String categoriaUltima = null;
        	
            for(model.ProdottoBean prodotto: catalogo) {
            	String codiceObj = prodotto.getCategoriaNome();
            	String categoriaCorrente = codiceObj;
            	
            	if(categoriaCorrente != null && !categoriaCorrente.equals(categoriaUltima)){
                    categoriaUltima = categoriaCorrente; 
        %>
            		<h2 class="sezione"><%=categoriaCorrente%></h2>
        <%
                }
        %>
            <div class="prodotto-card">
                <div class="prodotto-info">
                    <div class="prodotto-nome"><%= prodotto.getNome()%></div>
                    <div class="prodotto-descrizione"><%= prodotto.getDescrizione() %></div>
                    <div class="prodotto-prezzo">€ <%= prodotto.getPrezzo() %></div>
                </div>
                <button class="btn-add" onclick="aggiungiAlCarrello(<%= prodotto.getCodice() %>, '<%=request.getContextPath()%>')">+</button>
            </div>
        <%		
            }
        } else {
        %>
            <p>Nessun prodotto disponibile nel catalogo.</p>
        <% } %>
    </div>  <div id="carrello-sezione">
        <div id="carrello-card">
            <h3>Il tuo ordine</h3>
            
            <% 
            java.util.List<model.CarrelloBean> carrelloSessione = (java.util.List<model.CarrelloBean>) session.getAttribute("carrello");
            boolean cartPieno = (carrelloSessione != null && !carrelloSessione.isEmpty());
            %>
            
            <div id="carrello-vuoto" class="<%= cartPieno ? "nascosto" : "" %>">
                <div id="carrello-icon">📥</div> 
                <p>Carrello vuoto.</p>
            </div>
            
            <div id="carrello-lista-dinamica">
            <% 
            if (cartPieno) { 
                java.math.BigDecimal totaleCart = java.math.BigDecimal.ZERO;
                for(model.CarrelloBean item : carrelloSessione) {
                    java.math.BigDecimal prezzoTotaleItem = item.getProdotto().getPrezzo().multiply(new java.math.BigDecimal(item.getQuantita()));
                    totaleCart = totaleCart.add(prezzoTotaleItem);
            %>
                    <div class="cart-item-row">
                        <span class="cart-item-nome"><%= item.getProdotto().getNome() %> - €<%= item.getProdotto().getPrezzo() %></span>
                        <div class="cart-item-actions">
                            <input type="number" value="<%= item.getQuantita() %>" min="1" class="cart-input-qty" 
                            onchange="modificaQuantita(<%= item.getProdotto().getCodice() %>, this.value, 
                            '<%=request.getContextPath()%>')">
                            
                            <button class="cart-btn-remove" onclick="rimuoviDalCarrello(<%= item.getProdotto().getCodice() %>, 
                            '<%=request.getContextPath()%>')">🗑️</button>
                        </div>
                    </div>
            <% 
                } 
            %>
                <hr><h4>Totale: €<%= totaleCart %></h4>
            <% 
            } 
            %>
            </div>

            <% 
            boolean isLoggato = (session.getAttribute("utente") != null); 
            %>
            
            <button id="btn-checkout" <%= cartPieno ? "" : "disabled" %> onclick="procediCheckout(<%= isLoggato %>, '<%=request.getContextPath()%>')">Checkout</button>
            
        </div>
    </div> 
</div> 

</body>
</html>