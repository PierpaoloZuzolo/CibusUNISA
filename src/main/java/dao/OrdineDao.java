package dao;

import java.sql.SQLException;

import model.OrdineBean;

public interface OrdineDao {
	public void salvaOrdine(OrdineBean ordine) throws SQLException;

}
