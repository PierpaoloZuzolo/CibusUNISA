<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/checkout.css">
<script src="${pageContext.request.contextPath}/scripts/checkout.js"></script>
</head>
<body>
<header>
 <a href="<%=request.getContextPath()%>/home"><img src="images/LogoCibusUNISA.png" alt="Logo del sito" id="logoSopra"></a>
	
	<nav>
		<ul> 
			<li><a href="<%=request.getContextPath()%>/home">Home</a></li>
		</ul>
	</nav>
</header>

    <div class="main-container">
        <h2>Conferma il tuo Ordine</h2>
        
        <div id="checkout-container" class="form-container">
            <form id="checkout-form">
                <div class="form-group">
                    <label for="indirizzo">Indirizzo di Spedizione:</label>
                    <input type="text" id="indirizzo" name="indirizzo" placeholder="Es. Biblioteca scientifica, Fisciano">
                </div>
                
                <div class="form-group">
                    <label for="metodoPagamento">Metodo di Pagamento:</label>
                    <select id="metodoPagamento" name="metodoPagamento">
                        <option value="">Seleziona un metodo...</option>
                        <option value="Carta di Credito">Carta di Credito</option>
                        <option value="PayPal">PayPal</option>
                        <option value="Contanti">Contanti</option>
                    </select>
                </div>
                
               
                <div id="errore-checkout"></div>
                
                
                <button type="button" class="btn-conferma" onclick="inviaOrdine('${pageContext.request.contextPath}')">
                    Paga e Conferma Ordine
                </button>
            </form>
        </div>
    </div>

<footer>
&copy; 2026, CibusUNISA
</footer>

</body>
</html>