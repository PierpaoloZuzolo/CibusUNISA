package dao;

import model.ProdottoBean;
import java.sql.SQLException;

public interface ProdottoDao {
	
	public void doSave(ProdottoBean u) throws SQLException;

	public ProdottoBean doRetrieveByCodice(int codice) throws SQLException;
	
	public boolean doDelete(int codice) throws SQLException;
	
}
