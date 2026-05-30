package control;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.UtenteBean;
import dao.UtenteDaoImpl;

@WebServlet("/login")
public class AccessoServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");


        DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
        UtenteDaoImpl utenteDao = new UtenteDaoImpl(ds);

        try {
            UtenteBean bean = utenteDao.doRetrieveByEmail(email);

            if (bean != null && bean.getPassword().equals(password)) {
                request.getSession().setAttribute("utente", bean); 
                response.sendRedirect(request.getContextPath() + "/ordina");
            } else {
                request.setAttribute("errore", "Email o password errati.");
                request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
           
            request.setAttribute("errore", "Errore tecnico del server.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }


}
	

