package dao;

import java.sql.SQLException;
import java.util.List;

import model.OrdineBean;

public interface OrdineDao {
	public void salvaOrdine(OrdineBean ordine) throws SQLException;
	public List<OrdineBean> getOrdiniByUtente(int utenteCodice) throws SQLException;

}
