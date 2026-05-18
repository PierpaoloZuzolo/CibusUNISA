package dao;

import model.UtenteBean;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UtenteDaoImpl implements UtenteDao {

    
    private DataSource ds;

    
    public UtenteDaoImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public void doSave(UtenteBean u) throws SQLException {
    
        String query = "INSERT INTO utente (email, password, nome, cognome, ruolo) VALUES (?, ?, ?, ?, ?)";

    
        try (Connection con = ds.getConnection(); 
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, u.getEmail());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getNome());
            ps.setString(4, u.getCognome());
            ps.setString(5, u.getRuolo());

            ps.executeUpdate();
        }
    }

    @Override
    public UtenteBean doRetrieveByEmail(String email) throws SQLException {
        UtenteBean utente = null;
        String query = "SELECT * FROM utente WHERE email = ?";

        try (Connection con = ds.getConnection(); 
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    utente = new UtenteBean();
                    utente.setCode(rs.getInt("code"));
                    utente.setEmail(rs.getString("email"));
                    utente.setPassword(rs.getString("password"));
                    utente.setNome(rs.getString("nome"));
                    utente.setCognome(rs.getString("cognome"));
                    utente.setRuolo(rs.getString("ruolo"));
                }
            }
        }
        return utente;
    }
}