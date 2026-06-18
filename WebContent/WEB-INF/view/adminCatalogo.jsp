<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*, model.ProdottoBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestione Catalago Admin</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/adminCatalogo.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
<header>
	<a href="<%=request.getContextPath()%>/home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>
	
		<nav>
			<ul> 
				<li><a href="<%=request.getContextPath()%>/home">Home</a></li>
				<li><a href="<%=request.getContextPath()%>/ordina">Ordina</a></li>
				<li><a href="<%=request.getContextPath()%>/gestione">Gestione</a></li>
				<li><a href="<%=request.getContextPath()%>/adminOrdini">Gestione ordini</a></li>
				<li><a href="<%=request.getContextPath()%>/logout">
            <%
				model.UtenteBean u = (model.UtenteBean) session.getAttribute("utente"); 
				out.print ("Ciao " + u.getNome() + "! (Logout)");
			%></a></li>
			</ul>
		</nav>
</header>

<!-- Form per inserimento --> 

<main class="container">
    <h1>Gestione Catalogo Prodotti</h1>

    <section class="form-sezione">
        <h2>Aggiungi Nuovo Prodotto</h2>
        <form action="adminCatalogo" method="post" enctype="multipart/form-data" onsubmit="return validateProdotto(this)">
            <input type="hidden" name="action" value="insert">
            
            <div class="form-group">
                <label>Nome:</label>
                <input type="text" name="nome" required>
                <span class="error-message" id="error-nome"></span>
            </div>

            <div class="form-group">
                <label>Descrizione:</label>
                <textarea name="descrizione" required></textarea>
            </div>

            <div class="form-group">
                <label>Prezzo (€):</label>
                <input type="number" name="prezzo" step="0.01" required>
            </div>

            <div class="form-group">
    <label for="categoria">Categoria:</label>
    <input type="text" name="categoria" id="categoria" list="categorieSuggerite" required placeholder="Scegli o scrivi nuova...">
    
    <datalist id="categorieSuggerite">
        <% 
        List<String> categorie = (List<String>) request.getAttribute("categorie");
        if (categorie != null) {
            for (String cat : categorie) {
        %>
            <option value="<%=cat%>">
        <% 
            }
        } 
        %>
    </datalist>
			</div>
			<div class="form-group">
                <label>Immagine (Opzionale):</label>
                <input type="file" name="immagine" accept="image/*">
            </div>

            <button type="submit" class="btn-save">Salva Prodotto</button>
        </form>
    </section>

    <!-- Tabella -->
    <section class="tabella-sezione">
        <h2>Elenco Prodotti</h2>
        <table class="responsive-table">
            <thead>
                <tr>
                    <th>Immagine</th>
                    <th>Nome</th>
                    <th>Categoria</th> 
                    <th>Prezzo</th>
                    <th>Stato</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <% 
                List<ProdottoBean> prodotti = (List<ProdottoBean>) request.getAttribute("prodotti");
                if (prodotti != null && !prodotti.isEmpty()) {
                    for (ProdottoBean p : prodotti) {
                %>
                <tr>
                    <td>
                        <!-- Richiamo alla Servlet tecnica per i BLOB -->
                        <img src="MostraImmagine?codice=<%=p.getCodice()%>" alt="<%=p.getNome()%>" 
                         onerror="this.src='<%=request.getContextPath()%>/images/LogoCibusUNISA.png'" class="thumb">
                    </td>
                    <td><%=p.getNome()%></td>
                    <td><%=p.getCategoriaNome()%></td> 
                    <td><%=String.format("%.2f", p.getPrezzo())%> €</td>
                    <td>
                        <span class="status <%=p.isAttivo() ? "active" : "inactive"%>">
                            <%=p.isAttivo() ? "Attivo" : "Disattivato"%>
                        </span>
                    </td>
                    <td>
                       <form action="adminCatalogo" method="post">
   				   		 <input type="hidden" name="codice" value="<%=p.getCodice()%>">
    
  							  <% if (p.isAttivo()) { %>
   						     <input type="hidden" name="action" value="delete">
   						     <button type="submit" class="btn-delete">Disattiva</button>
   							 <% } else { %>
   						     <input type="hidden" name="action" value="activate">
    					    <button type="submit" class="btn-activate">Attiva</button>
						    <% } %>
						    <a href="adminCatalogo?action=edit&codice=<%=p.getCodice()%>" class="btn-edit">Modifica</a>
						</form>
                    </td>
                </tr>
                <% 
                    }
                } else {
                %>
                <tr><td>Nessun prodotto in catalogo.</td></tr>
                <% } %>
            </tbody>
        </table>
    </section>
    
     <% 
        // Recupero del prodotto passato dalla Servlet 
        model.ProdottoBean pMod = (model.ProdottoBean) request.getAttribute("prodottoDaModificare");
        if (pMod != null) { 
    %>
    <section class="form-sezione edit-highlight">
        <h2>Modifica Prodotto: <%= pMod.getNome() %></h2>
        <form action="adminCatalogo" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="codice" value="<%= pMod.getCodice() %>">

            <div class="form-group">
                <label>Nome:</label>
                <input type="text" name="nome" value="<%= pMod.getNome() %>" required>
            </div>

            <div class="form-group">
                <label>Descrizione:</label>
                <textarea name="descrizione" required><%= pMod.getDescrizione() %></textarea>
            </div>

            <div class="form-group">
                <label>Prezzo (€):</label>
                <input type="number" name="prezzo" value="<%= pMod.getPrezzo() %>" step="0.01" required>
            </div>

            <div class="form-group">
                <label>Categoria:</label>
                <select name="categoria">
                    <% 
                    List<String> tutteCat = (List<String>) request.getAttribute("categorie");
                    if (tutteCat != null) {
                        for (String c : tutteCat) {
                            String sel = c.equals(pMod.getCategoriaNome()) ? "selected" : "";
                    %>
                        <option value="<%=c%>" <%=sel%>><%=c%></option>
                    <% } } %>
                </select>
            </div>

            <div class="form-group">
                <label>Cambia Immagine (Opzionale):</label>
                <input type="file" name="immagine" accept="image/*">
            </div>

            <button type="submit" class="btn-save">Salva Modifiche</button>
            <a href="adminCatalogo" class="btn-cancel">Annulla</a>
        </form>
    </section>
    <% } %>
</main>


</body>
</html>