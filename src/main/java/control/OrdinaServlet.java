package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProdottoBean;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.ProdottoDaoImpl;

/**
 * Servlet implementation class OrdinaServlet
 */
@WebServlet("/ordina")
public class OrdinaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrdinaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		ProdottoDaoImpl prodottoDao = new ProdottoDaoImpl();
		try {
			List<ProdottoBean> listaProdotti;
			listaProdotti = prodottoDao.doRetrieveAllActive();
			request.setAttribute("catalogo", listaProdotti);
		} catch (SQLException e) {
			request.setAttribute("errore", "Errore nel caricamento del catalogo.");
			request.getRequestDispatcher("/WEB-INF/view/ordina.jsp").forward(request, response);;
		}
		
		
		request.getRequestDispatcher("/WEB-INF/view/ordina.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
