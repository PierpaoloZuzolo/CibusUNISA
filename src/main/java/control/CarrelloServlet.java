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
import dao.ProdottoDaoImpl;

/**
 * Servlet implementation class CarrelloServlet
 */
@WebServlet("/CarrelloServlet")
public class CarrelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        List<ProdottoBean> carrello = (List<ProdottoBean>) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }

        if ("add".equals(action)) {
            int codiceProdotto = Integer.parseInt(request.getParameter("codice"));
            
            try {
                ProdottoDaoImpl dao = new ProdottoDaoImpl();
                ProdottoBean prodotto = dao.doRetrieveByCodice(codiceProdotto);
                
                if (prodotto != null) {
                    carrello.add(prodotto);
                }
                
                StringBuilder jsonStr = new StringBuilder("[");
                for (int i = 0; i < carrello.size(); i++) {
                    ProdottoBean p = carrello.get(i);
                   
                    jsonStr.append("{\"nome\":\"").append(p.getNome())
                           .append("\", \"prezzo\":").append(p.getPrezzo()).append("}");
                    
                    if (i < carrello.size() - 1) {
                        jsonStr.append(","); 
                    }
                }
                jsonStr.append("]");
                

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonStr.toString());
                
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }

}
