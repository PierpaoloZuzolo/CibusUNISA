<%@page import="model.ProdottoBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ordine</title>
<link rel="stylesheet" href="styles/home.css">

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
            <% if (session.getAttribute("utente") != null) { 
				model.UtenteBean u = (model.UtenteBean) session.getAttribute("utente"); 
				out.print ("Ciao " + u.getNome() + "! (Logout)");
			} %>
		</a></li>
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
                <button class="btn-add">+</button>
            </div>
        <%		
            }
        } else {
        %>
            <p>Nessun prodotto disponibile nel catalogo.</p>
        <% } %>
    </div> <div class="carrello-sezione">
        <div class="carrello-card">
            <h3>Il tuo ordine</h3>
            <div class="carrello-vuoto">
                <div class="carrello-icon">📥</div> 
                <p>Carrello vuoto.</p>
            </div>
            <button class="btn-checkout" disabled>Checkout</button>
        </div>
    </div> </div>

</body>
</html>