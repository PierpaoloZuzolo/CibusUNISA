package dao;

import model.ProdottoBean;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public interface ProdottoDao {
	
	public void doSave(ProdottoBean u) throws SQLException;
	
	public boolean doUpdate(ProdottoBean p) throws SQLException;
	
	public boolean doDelete(int codice) throws SQLException;
	
	public ProdottoBean doRetrieveByCodice(int codice) throws SQLException;
	
	public List<ProdottoBean> doRetrieveAllActive() throws SQLException;
	
	public List<ProdottoBean> doRetrieveAll() throws SQLException;
	
	public List<String> doRetrieveAllCategories() throws SQLException ;
	
	public boolean doActivate(int codice) throws SQLException;
	
	
}
