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

@WebServlet("/Registration")
public class RegistrazioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String nome = request.getParameter("firstname");
        String cognome = request.getParameter("lastname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String telefono = request.getParameter("phone");

        UtenteBean nuovoUtente = new UtenteBean();
        nuovoUtente.setNome(nome);
        nuovoUtente.setCognome(cognome);
        nuovoUtente.setEmail(email);
        nuovoUtente.setPassword(password);
        nuovoUtente.setTelefono(telefono);
        nuovoUtente.setRuolo("cliente"); 


        DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
        UtenteDaoImpl utenteDao = new UtenteDaoImpl(ds);

        try {
            utenteDao.doSave(nuovoUtente);

            request.setAttribute("messaggio", "Registrazione completata con successo! Ora puoi accedere.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante la registrazione. L'email potrebbe essere già in uso.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
        }
    }


}