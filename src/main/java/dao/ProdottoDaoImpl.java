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
		String query = "INSERT INTO prodotto (nome, descrizione, prezzo, categoria_codice) VALUES (?, ?, ?, ?)";
		
		try (Connection con = ds.getConnection(); 
	         PreparedStatement ps = con.prepareStatement(query)) {

	        ps.setString(1, p.getNome());
	        ps.setString(2, p.getDescrizione());
	        ps.setBigDecimal(3, p.getPrezzo());
	        
	        if (p.getCategoriaCodice() != null) {
	        	ps.setInt(4, p.getCategoriaCodice());
	        } else {
	        	ps.setNull(4, java.sql.Types.INTEGER);
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
                    
             
                    int catCodice = rs.getInt("categoria_codice");
                    
                    prodotto.setCategoriaCodice(rs.wasNull() ? null : catCodice);
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
        String query = "SELECT * FROM prodotto WHERE attivo = TRUE ORDER BY categoria_codice ASC";

        try (Connection con = ds.getConnection(); 
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProdottoBean prodotto = new ProdottoBean();
                prodotto.setCodice(rs.getInt("codice"));
                prodotto.setNome(rs.getString("nome"));
                prodotto.setDescrizione(rs.getString("descrizione"));
                prodotto.setPrezzo(rs.getBigDecimal("prezzo"));
                
                int catCodice = rs.getInt("categoria_codice");
                prodotto.setCategoriaCodice(rs.wasNull() ? null : catCodice);
                prodotto.setAttivo(rs.getBoolean("attivo"));
                
                prodotti.add(prodotto);
            }
        }
        return prodotti;
	}
}