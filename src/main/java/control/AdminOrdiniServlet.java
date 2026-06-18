package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.OrdineBean;
import model.UtenteBean;

import java.io.IOException;
import java.util.List;

import dao.OrdineDaoImpl;

/**
 * implementazione ordini di tutti per gli admin
 */
@WebServlet("/adminOrdini")
public class AdminOrdiniServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UtenteBean utente = (UtenteBean) session.getAttribute("utente");

        if (utente == null || !((model.UtenteBean) utente).getRuolo().equalsIgnoreCase("admin")) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String dataDal = request.getParameter("dataDal");
        String dataAl = request.getParameter("dataAl");
        String clienteIdParam = request.getParameter("clienteId");

        try {
            if (dataDal != null && dataAl != null) {
                Integer clienteId = null;
                if (clienteIdParam != null && !clienteIdParam.trim().isEmpty()) {
                    clienteId = Integer.parseInt(clienteIdParam);
                }

                OrdineDaoImpl dao = new OrdineDaoImpl();
                List<OrdineBean> ordini = dao.getOrdiniFiltrati(dataDal, dataAl, clienteId);
                
                request.setAttribute("ordini", ordini);
            }
            
            request.getRequestDispatcher("/WEB-INF/view/adminOrdini.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Errore ricerca ordini.");
        }
    }

}
