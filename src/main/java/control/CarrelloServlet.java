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
import javax.sql.DataSource;

import model.ProdottoBean;
import model.CarrelloBean;
import dao.ProdottoDaoImpl;

@WebServlet("/CarrelloServlet")
public class CarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        

        List<CarrelloBean> carrello = (List<CarrelloBean>) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }
        
        try {
        	int codiceProdotto = Integer.parseInt(request.getParameter("codice"));
        	
        if ("add".equals(action)) {       
            boolean trovato = false;
            for (CarrelloBean item : carrello) {
                if (item.getProdotto().getCodice() == codiceProdotto) {
                    item.setQuantita(item.getQuantita() + 1);
                    trovato = true;
                    break;
                }
            }
            
            if (!trovato) {
                ProdottoDaoImpl dao = new ProdottoDaoImpl();
                ProdottoBean prodotto = dao.doRetrieveByCodice(codiceProdotto);
                
                if (prodotto != null) {
                    carrello.add(new CarrelloBean(prodotto, 1));
                }
            }
        } 
        
        else if ("update".equals(action)) {
            int nuovaQuantita = Integer.parseInt(request.getParameter("quantita"));
            for (CarrelloBean item : carrello) {
                if (item.getProdotto().getCodice() == codiceProdotto) {
                    if (nuovaQuantita > 0) {
                        item.setQuantita(nuovaQuantita);
                    }
                    break;
                }
            }
        } 
        
        else if ("remove".equals(action)) {
            carrello.removeIf(item -> item.getProdotto().getCodice() == codiceProdotto);
        }
                

                StringBuilder jsonStr = new StringBuilder("[");
                for (int i = 0; i < carrello.size(); i++) {
                	CarrelloBean item = carrello.get(i);
                	ProdottoBean p = item.getProdotto();
                	
                	jsonStr.append("{\"codice\":").append(p.getCodice())
                			.append("{\"nome\":\"").append(p.getNome().replace("\"", "\\\""))
                			.append("\", \"prezzo\":").append(p.getPrezzo()).append("}")
                	 		.append(", \"quantita\":").append(item.getQuantita()).append("}");
                    
                    if (i < carrello.size() - 1) {
                        jsonStr.append(","); 
                    }
                }
                jsonStr.append("]");

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonStr.toString());
                
            } catch (Exception e) {
                e.printStackTrace(); 
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
    }
}