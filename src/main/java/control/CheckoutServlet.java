package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import model.UtenteBean;
import model.CarrelloBean;
import model.OrdineBean;
import model.DettaglioOrdineBean;
import dao.OrdineDaoImpl;

/**
 * Servlet per implementazione del bottone di Checkout che manda a questa Servlet
 * implementazione anche del salvataggio dati...
 */
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UtenteBean utente = (UtenteBean) session.getAttribute("utente");

        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        
        request.getRequestDispatcher("/WEB-INF/view/checkout.jsp").forward(request, response);
    }

   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UtenteBean utente = (UtenteBean) session.getAttribute("utente");

        if (utente == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }


        List<CarrelloBean> carrello = (List<CarrelloBean>) session.getAttribute("carrello");
        if (carrello == null || carrello.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String indirizzo = request.getParameter("indirizzo");
        String metodoPagamento = request.getParameter("metodoPagamento");
        
        if (metodoPagamento == null || metodoPagamento.isEmpty()) {
            metodoPagamento = "Carta di Credito";
        }

        try {
            OrdineBean nuovoOrdine = new OrdineBean();
            nuovoOrdine.setUtenteCodice(utente.getCodice());
            nuovoOrdine.setIndirizzoConsegna(indirizzo);
            nuovoOrdine.setMetodoPagamento(metodoPagamento);

            List<DettaglioOrdineBean> dettagli = new ArrayList<>();
            
            for (CarrelloBean item : carrello) {
                DettaglioOrdineBean dettaglio = new DettaglioOrdineBean();
                dettaglio.setProdotto(item.getProdotto());
                dettaglio.setQuantita(item.getQuantita());
                
               /*salvo il prezzo così se viene cambiato rimane invariato*/
                dettaglio.setPrezzoUnitario(item.getProdotto().getPrezzo()); 
                
                dettagli.add(dettaglio);
            }
            
            nuovoOrdine.setDettagli(dettagli);

            OrdineDaoImpl dao = new OrdineDaoImpl();
            dao.salvaOrdine(nuovoOrdine);

            session.removeAttribute("carrello");

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": true}");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"error\": \"Errore interno del server\"}");
        }
    }

}
