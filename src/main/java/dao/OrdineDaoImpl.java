package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.DettaglioOrdineBean;
import model.OrdineBean;
import model.ProdottoBean;

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
    
    public List<OrdineBean> getOrdiniFiltrati(String dataInizio, String dataFine, Integer utenteCodice) throws Exception {
        List<OrdineBean> storico = new ArrayList<>();
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String query = "SELECT * FROM ordine WHERE data_ordine BETWEEN ? AND ? ";
        if (utenteCodice != null) {
            query += "AND utente_codice = ? ";
        }
        query += "ORDER BY data_ordine DESC";

       
        String queryDettagli = "SELECT d.quantita, d.prezzo_unitario, p.codice, p.nome " +
                               "FROM dettaglio_ordine d " +
                               "LEFT JOIN prodotto p ON d.codice_prodotto = p.codice " +
                               "WHERE d.codice_ordine = ?";

        try {
            connection = ds.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, dataInizio + " 00:00:00");
            ps.setString(2, dataFine + " 23:59:59");
            
            if (utenteCodice != null) {
                ps.setInt(3, utenteCodice);
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                OrdineBean ordine = new OrdineBean();
                ordine.setCodice(rs.getInt("codice"));
                ordine.setDataOrdine(rs.getTimestamp("data_ordine"));
                ordine.setIndirizzoConsegna(rs.getString("indirizzo_consegna"));
                ordine.setMetodoPagamento(rs.getString("metodo_pagamento"));
                ordine.setUtenteCodice(rs.getInt("utente_codice"));
              
                List<DettaglioOrdineBean> dettagli = new ArrayList<>();
                PreparedStatement psDettaglio = null;
                ResultSet rsDettaglio = null;
                
                try {
                    psDettaglio = connection.prepareStatement(queryDettagli);
                    psDettaglio.setInt(1, ordine.getCodice());
                    rsDettaglio = psDettaglio.executeQuery();
                    
                    while (rsDettaglio.next()) {
                        DettaglioOrdineBean dettaglio = new DettaglioOrdineBean();
                        dettaglio.setQuantita(rsDettaglio.getInt("quantita"));
                        
                        dettaglio.setPrezzoUnitario(rsDettaglio.getBigDecimal("prezzo_unitario")); 
                        
                        ProdottoBean prodotto = new ProdottoBean();
                        prodotto.setCodice(rsDettaglio.getInt("codice"));
                        
                        String nomeProdotto = rsDettaglio.getString("nome");
                        if (nomeProdotto == null) {
                            prodotto.setNome("Prodotto rimosso dal catalogo");
                        } else {
                            prodotto.setNome(nomeProdotto);
                        }
                        
                        dettaglio.setProdotto(prodotto);
                        dettagli.add(dettaglio);
                    }
                } finally {
                    if (rsDettaglio != null) rsDettaglio.close();
                    if (psDettaglio != null) psDettaglio.close();
                }
                
              
                ordine.setDettagli(dettagli);


                storico.add(ordine);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (connection != null) connection.close();
        }
        
        return storico;
    }
}
