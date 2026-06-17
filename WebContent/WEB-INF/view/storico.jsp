<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.OrdineBean" %>
<%@ page import="model.DettaglioOrdineBean" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>I tuoi ordini</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/storico.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


</head>
<body>
<header>
	<a href="<%=request.getContextPath()%>/home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>
	
	<nav>
		<ul> 
			<li><a href="<%=request.getContextPath()%>/home">Home</a></li>
			<li><a href="<%=request.getContextPath()%>/ordina">Ordina</a></li>
			<li><a href="<%=request.getContextPath()%>/logout">Disconnettiti</a></li>
		</ul>
	</nav>
</header>

<div class="main-container">
        <h2>Lo storico dei tuoi ordini</h2>
        
        <%
        List<OrdineBean> ordini = (List<OrdineBean>) request.getAttribute("ordini");
        
        if (ordini == null || ordini.isEmpty()) {
        %>
            <div class="form-container">
                <p>Non hai ancora effettuato nessun ordine.</p>
            </div>
        <%
        } else {
            for (OrdineBean ordine : ordini) {
                BigDecimal totaleOrdine = BigDecimal.ZERO;
        %>
           
            <div class="form-container">
                <h3>Ordine #<%= ordine.getCodice() %> del <%= ordine.getDataOrdine() %></h3>
                <p><strong>Indirizzo di Spedizione:</strong> <%= ordine.getIndirizzoConsegna() %></p>
                <p><strong>Metodo di Pagamento:</strong> <%= ordine.getMetodoPagamento() %></p>
                
                <hr>
                
                <h4>Prodotti Acquistati:</h4>
                <ul>
                <%
                List<DettaglioOrdineBean> dettagli = ordine.getDettagli();
                if (dettagli != null) {
                    for (DettaglioOrdineBean dettaglio : dettagli) {
                        BigDecimal prezzoStorico = dettaglio.getPrezzoUnitario();
                        BigDecimal subTotale = prezzoStorico.multiply(new BigDecimal(dettaglio.getQuantita()));
                        totaleOrdine = totaleOrdine.add(subTotale);
                %>
                    <li>
                        <strong><%= dettaglio.getQuantita() %>x <%= dettaglio.getProdotto().getNome() %></strong> <br>
                        <span>
                            Prezzo d'acquisto: €<%= prezzoStorico %> | Subtotale: €<%= subTotale %>
                        </span>
                    </li>
                <%
                    }
                }
                %>
                </ul>
                
                <h3>Totale Pagato: €<%= totaleOrdine %></h3>
            </div>
        <%
            }
        }
        %>
    </div>
    
<footer>
&copy; 2026, CibusUNISA
</footer>

</body>
</html>