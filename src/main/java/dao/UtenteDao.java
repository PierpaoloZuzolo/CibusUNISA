package dao;

import model.UtenteBean;
import java.sql.SQLException;

public interface UtenteDao {

	public void doSave(UtenteBean u) throws SQLException;

	public UtenteBean doRetrieveByEmail(String email) throws SQLException;

}