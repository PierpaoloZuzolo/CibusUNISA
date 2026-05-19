package dao;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.ProdottoBean;
import model.UtenteBean;

public class ProdottoDaoImpl implements ProdottoDao {
	
	private DataSource ds;

	public ProdottoDaoImpl(DataSource ds) {
        this.ds = ds;
    }

	@Override
	public void doSave(ProdottoBean p) throws SQLException {
		String query = "INSERT INTO (nome, descrizione, prezzo, categoriaCodice) VALUES (?, ?, ?, ?)";
		
		try (Connection con = ds.getConnection(); 
	             PreparedStatement ps = con.prepareStatement(query)) {

	            ps.setString(1, p.getNome());
	            ps.setString(2, p.getDescrizione());
	            ps.setBigDecimal(3, p.getPrezzo());
	            ps.setInt(4, p.getCategoriaCodice());

	            ps.executeUpdate();
	        }
	}

	@Override
	public ProdottoBean doRetrieveByCodice(int codice) throws SQLException {
		ProdottoBean prodotto = null;
        String query = "SELECT * FROM prodotto WHERE codice = ?";

        try (Connection con = ds.getConnection(); 
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, codice);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    prodotto = new ProdottoBean();
                    prodotto.setCodice(rs.getInt("codice"));
                    prodotto.setNome(rs.getString("nome"));
                    prodotto.setDescrizione(rs.getString("descrizione"));
                    prodotto.setPrezzo(rs.getBigDecimal("prezzo"));
                }
            }
        }
        return prodotto;
	}

	@Override
	public boolean doDelete(int codice) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

}
