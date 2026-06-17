package dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.ProdottoBean;

public class ProdottoDaoImpl implements ProdottoDao {
	
	private DataSource ds;

	public ProdottoDaoImpl() {
		try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            this.ds = (DataSource) envContext.lookup("jdbc/storageDB"); 
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

	@Override
	public void doSave(ProdottoBean p) throws SQLException {
		String query = "INSERT INTO prodotto (nome, descrizione, prezzo, categoria_nome, immagine) VALUES (?, ?, ?, ?, ?, ?)";
		
		try (Connection con = ds.getConnection(); 
	         PreparedStatement ps = con.prepareStatement(query)) {

	        ps.setString(1, p.getNome());
	        ps.setString(2, p.getDescrizione());
	        ps.setBigDecimal(3, p.getPrezzo());
	        ps.setBoolean(4, true);
	        ps.setString(5, p.getCategoriaNome());

            if (p.getImmagine() != null) {
                ps.setBinaryStream(6, p.getImmagine());
            } else {
                ps.setNull(6, java.sql.Types.BLOB);
            }

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
                    prodotto.setCategoriaNome(rs.getString("categoria_nome"));
                    prodotto.setAttivo(rs.getBoolean("attivo"));
                }
            }
        }
        return prodotto;
	}

	@Override
	public boolean doDelete(int codice) throws SQLException {
		String query = "UPDATE prodotto SET attivo = FALSE WHERE codice = ?";
        try (Connection connection = ds.getConnection();
        	 PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, codice);
            int result = preparedStatement.executeUpdate();
            return result != 0;
        }
	}
	

	public List<ProdottoBean> doRetrieveAllActive() throws SQLException {
		List<ProdottoBean> prodotti = new ArrayList<>();
        String query = "SELECT * FROM prodotto WHERE attivo = TRUE ORDER BY categoria_nome";

        try (Connection con = ds.getConnection(); 
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProdottoBean prodotto = new ProdottoBean();
                prodotto.setCodice(rs.getInt("codice"));
                prodotto.setNome(rs.getString("nome"));
                prodotto.setDescrizione(rs.getString("descrizione"));
                prodotto.setPrezzo(rs.getBigDecimal("prezzo"));
                prodotto.setCategoriaNome(rs.getString("categoria_nome"));
                prodotto.setAttivo(rs.getBoolean("attivo"));
                
                prodotti.add(prodotto);
            }
        }
        return prodotti;
	}

	@Override
	public boolean doUpdate(ProdottoBean p) throws SQLException {
		String query = "UPDATE prodotto SET nome=?, descrizione=?, prezzo=?, categoria_nome=?, attivo=?, immagine=? WHERE codice=?";
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, p.getNome());
            ps.setString(2, p.getDescrizione());
            ps.setBigDecimal(3, p.getPrezzo());
            ps.setString(4, p.getCategoriaNome());
            ps.setBoolean(5, p.isAttivo());
            
            if (p.getImmagine() != null) {
                ps.setBinaryStream(6, p.getImmagine());
            } else {
                ps.setNull(6, java.sql.Types.BLOB);
            }
            ps.setInt(7, p.getCodice());
            
            return ps.executeUpdate() > 0;
        }
	}

	@Override
	public List<ProdottoBean> doRetrieveAll() throws SQLException {
		List<ProdottoBean> prodotti = new ArrayList<>();
		String query = "SELECT * FROM prodotto ORDER BY categoria_nome";

		try (Connection con = ds.getConnection(); 
				PreparedStatement ps = con.prepareStatement(query);
				ResultSet rs = ps.executeQuery()) {
			ProdottoBean p = new ProdottoBean();
			while (rs.next()) {
				p.setCodice(rs.getInt("codice"));
				p.setNome(rs.getString("nome"));
				p.setDescrizione(rs.getString("descrizione"));
				p.setPrezzo(rs.getBigDecimal("prezzo"));
				p.setCategoriaNome(rs.getString("categoria_nome"));
				p.setAttivo(rs.getBoolean("attivo"));
				p.setImmagine(rs.getBinaryStream("immagine"));
			}
		}
		return prodotti;
	}
}