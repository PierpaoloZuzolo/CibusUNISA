package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ProdottoBean;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.ProdottoDaoImpl;

/**
 * implementazione per catalago dell'admin
 */
@WebServlet("/adminCatalogo")
@MultipartConfig //Per il caricamento delle immagini
public class AdminCatalogoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminCatalogoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Object utenteObj = session.getAttribute("utente");
		
		if (utenteObj == null || !((model.UtenteBean) utenteObj).getRuolo().equalsIgnoreCase("admin")) {
	        response.sendRedirect(request.getContextPath() + "/home");
	        return;
	    }
		
			String action = request.getParameter("action");
	    	ProdottoDaoImpl dao = new ProdottoDaoImpl();
	        try {
	        	if ("edit".equalsIgnoreCase(action)) {
	                int codice = Integer.parseInt(request.getParameter("codice"));
	                ProdottoBean p = dao.doRetrieveByCodice(codice);
	                request.setAttribute("prodottoDaModificare", p);
	            }
	            List<ProdottoBean> prodotti = dao.doRetrieveAll();
	            request.setAttribute("prodotti", prodotti);
	            List<String> categorie = dao.doRetrieveAllCategories(); 
	            request.setAttribute("categorie", categorie);
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    	request.getRequestDispatcher("/WEB-INF/view/adminCatalogo.jsp").forward(request, response);
	    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
	    model.UtenteBean utente = (model.UtenteBean) session.getAttribute("utente");
	    if (utente == null || !utente.getRuolo().equalsIgnoreCase("admin")) {
	        response.sendError(HttpServletResponse.SC_FORBIDDEN);
	        return;
	    }

	    String action = request.getParameter("action");
	    ProdottoDaoImpl dao = new ProdottoDaoImpl();

	    try {
	        if ("delete".equalsIgnoreCase(action)) {
	            int codice = Integer.parseInt(request.getParameter("codice"));
	            dao.doDelete(codice); 
	        } else if ("activate".equalsIgnoreCase(action)) {
	            int codice = Integer.parseInt(request.getParameter("codice"));
	            dao.doActivate(codice); 
	        } else if ("update".equalsIgnoreCase(action)) {
	            ProdottoBean p = new ProdottoBean();
	            p.setCodice(Integer.parseInt(request.getParameter("codice")));
	            p.setNome(request.getParameter("nome"));
	            p.setDescrizione(request.getParameter("descrizione"));
	            p.setPrezzo(new java.math.BigDecimal(request.getParameter("prezzo")));
	            p.setCategoriaNome(request.getParameter("categoria"));
	            
	            // Gestione Immagine (se caricata)
	            jakarta.servlet.http.Part filePart = request.getPart("immagine");
	            if (filePart != null && filePart.getSize() > 0) {
	                p.setImmagine(filePart.getInputStream());
	            }

	            dao.doUpdate(p); 
	        } else if ("insert".equalsIgnoreCase(action)) {
	            ProdottoBean p = new ProdottoBean();
	            p.setNome(request.getParameter("nome"));
	            p.setDescrizione(request.getParameter("descrizione"));
	            p.setPrezzo(new java.math.BigDecimal(request.getParameter("prezzo")));
	            p.setCategoriaNome(request.getParameter("categoria"));
	            
	            // Gestione Immagine 
	            jakarta.servlet.http.Part filePart = request.getPart("immagine");
	            if (filePart != null && filePart.getSize() > 0) {
	                p.setImmagine(filePart.getInputStream());
	            }

	            // Chiamata al DAO per salvare il nuovo prodotto nel Database
	            dao.doSave(p); 
	        }
	    } catch (SQLException | NumberFormatException e) {
	        e.printStackTrace();
	    }


	    response.sendRedirect(request.getContextPath() + "/adminCatalogo");
	}

}