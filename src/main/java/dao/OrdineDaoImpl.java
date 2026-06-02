package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.DettaglioOrdineBean;
import model.OrdineBean;

public class OrdineDaoImpl implements OrdineDao{
	private DataSource ds;

    public OrdineDaoImpl() {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/storageDB"); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void salvaOrdine(OrdineBean ordine) throws SQLException {
        Connection connection = null;
        PreparedStatement psOrdine = null;
        PreparedStatement psDettaglio = null;
        ResultSet rs = null;

        String insertOrdine = "INSERT INTO ordine (indirizzo_consegna, metodo_pagamento, utente_codice) VALUES (?, ?, ?)";
        String insertDettaglio = "INSERT INTO dettaglio_ordine (codice_ordine, codice_prodotto, quantita, prezzo_unitario) VALUES (?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            connection.setAutoCommit(false); 

   
            psOrdine = connection.prepareStatement(insertOrdine, Statement.RETURN_GENERATED_KEYS);
            psOrdine.setString(1, ordine.getIndirizzoConsegna());
            psOrdine.setString(2, ordine.getMetodoPagamento()); 
            psOrdine.setInt(3, ordine.getUtenteCodice());
            psOrdine.executeUpdate();

            
            rs = psOrdine.getGeneratedKeys();
            int idOrdine = 0;
            if (rs.next()) {
                idOrdine = rs.getInt(1);
                ordine.setCodice(idOrdine);
            }

            psDettaglio = connection.prepareStatement(insertDettaglio);
            for (DettaglioOrdineBean dettaglio : ordine.getDettagli()) {
                psDettaglio.setInt(1, idOrdine);
                psDettaglio.setInt(2, dettaglio.getProdotto().getCodice());
                psDettaglio.setInt(3, dettaglio.getQuantita());
                
                psDettaglio.setBigDecimal(4, dettaglio.getPrezzoUnitario()); 
                
                psDettaglio.addBatch(); 
            }
            psDettaglio.executeBatch();


            connection.commit(); 
            
        } catch (SQLException e) {
           
            if (connection != null) {
                connection.rollback(); 
            }
            throw e;
        } finally {
            if (rs != null) rs.close();
            if (psOrdine != null) psOrdine.close();
            if (psDettaglio != null) psDettaglio.close();
            if (connection != null) {
                connection.setAutoCommit(true);
                connection.close();
            }
        }
    }

}
