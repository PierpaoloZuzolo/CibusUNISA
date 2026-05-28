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
            
        	<% } else { %>
            <li><a href="<%=request.getContextPath()%>/storico">I miei ordini</a></li>
            <li><a href="<%=request.getContextPath()%>/logout">Disconnettiti</a></li>
        <% } %>
		</ul>
	</nav>
</header>

<%
/*recupero il catagolo dalla richiesta*/
java.util.List<model.ProdottoBean> catalogo = (java.util.List<model.ProdottoBean>) request.getAttribute("catalogo");

if(catalogo != null){
	for(model.ProdottoBean prodotto: catalogo){
%>
	<div class="prodotti">
		<div class="prodotto-card">
			<div class="prodotto-nome"><%= prodotto.getNome()%></div>
			<div class="prodotto-descrizione"><%= prodotto.getDescrizione() %></div>
			<div class="prodotto-prezzo"><%= prodotto.getPrezzo() %></div>
		</div>
<%		
	}
}
%>
	</div>


</body>
</html>