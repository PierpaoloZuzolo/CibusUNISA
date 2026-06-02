package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

import model.UtenteBean;
import model.OrdineBean;
import dao.OrdineDaoImpl;

/**
 * Servlet implementation class StoricoServlet
 */
@WebServlet("/storico")
public class StoricoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        HttpSession session = request.getSession();
	        
	        UtenteBean utente = (UtenteBean) session.getAttribute("utente");

	       
	        if (utente == null) {
	            response.sendRedirect(request.getContextPath() + "/home");
	            return; 
	        }

	        try {
	            
	            OrdineDaoImpl dao = new OrdineDaoImpl();
	            
	            
	            List<OrdineBean> mieiOrdini = dao.getOrdiniByUtente(utente.getCodice());
	            
	            request.setAttribute("ordini", mieiOrdini);
	            
	            
	            request.getRequestDispatcher("/WEB-INF/view/storico.jsp").forward(request, response);
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore durante il recupero dello storico ordini.");
	        }
	    }

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        doGet(request, response);
	    }
	}

