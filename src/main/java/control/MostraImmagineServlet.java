package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import dao.ProdottoDaoImpl;

/**
 * Implementazione per mostrare le immagini dei prodotti
 */
@WebServlet("/MostraImmagine")
public class MostraImmagineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MostraImmagineServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String codiceStr = request.getParameter("codice");
        
        if (codiceStr != null && !codiceStr.trim().isEmpty()) {
            try {
                int codice = Integer.parseInt(codiceStr);
                ProdottoDaoImpl dao = new ProdottoDaoImpl();
                byte[] immagineBytes = dao.getImmagineByCodice(codice);
                
                if (immagineBytes != null && immagineBytes.length > 0) {
                    // Diciamo al browser che stiamo inviando un'immagine
                    response.setContentType("image/jpeg"); 
                    // Scriviamo i byte dell'immagine nella risposta HTTP
                    response.getOutputStream().write(immagineBytes);
                    response.getOutputStream().flush();
                    response.getOutputStream().close();
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
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
