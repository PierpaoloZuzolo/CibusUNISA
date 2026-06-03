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
<title>Gestione Ordini Admin</title>
</head>
<body>
<div class="main-container">
        <h2>Filtra Ordini (Area Amministratore)</h2>
        
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/adminOrdini" method="GET">
                <label for="dataDal">Dalla data:</label>
                <input type="date" id="dataDal" name="dataDal" required>
                
                <label for="dataAl">Alla data:</label>
                <input type="date" id="dataAl" name="dataAl" required>
                
                <label for="clienteId">ID Cliente (opzionale):</label>
                <input type="number" id="clienteId" name="clienteId" placeholder="Es. 5">
                
                <button type="submit">Cerca Ordini</button>
            </form>
        </div>

  
        <%
        List<OrdineBean> ordiniFiltrati = (List<OrdineBean>) request.getAttribute("ordini");
        if (ordiniFiltrati != null) {
            if (ordiniFiltrati.isEmpty()) {
        %>
                <p style="text-align:center;">Nessun ordine trovato per i criteri selezionati.</p>
        <%
            } else {
                for (OrdineBean ordine : ordiniFiltrati) {
                    BigDecimal totaleOrdine = BigDecimal.ZERO;
        %>
                <div class="form-container">
                    <h3>Ordine #<%= ordine.getCodice() %> del <%= ordine.getDataOrdine() %> (Cliente ID: <%= ordine.getUtenteCodice() %>)</h3>
                    <hr>
                    <ul>
                    <%
                    for (DettaglioOrdineBean dettaglio : ordine.getDettagli()) {
                      
                        BigDecimal subTotale = dettaglio.getPrezzoUnitario().multiply(new BigDecimal(dettaglio.getQuantita()));
                        totaleOrdine = totaleOrdine.add(subTotale);
                    %>
                        <li><%= dettaglio.getQuantita() %>x <%= dettaglio.getProdotto().getNome() %> - Subtotale: €<%= subTotale %></li>
                    <% } %>
                    </ul>
                    <h3 style="text-align: right; color: #28a745;">Totale: €<%= totaleOrdine %></h3>
                </div>
        <%
                }
            }
        }
        %>
    </div>

</body>
</html>