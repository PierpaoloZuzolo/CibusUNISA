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
 * Servlet implementation class AdminCatalogoServlet
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
	    }else {
	    	
	    	ProdottoDaoImpl dao = new ProdottoDaoImpl();
	        try {
	            List<ProdottoBean> prodotti = dao.doRetrieveAll();
	            request.setAttribute("prodotti", prodotti);
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    	request.getRequestDispatcher("/WEB-INF/view/adminCatalogo.jsp").forward(request, response);
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}