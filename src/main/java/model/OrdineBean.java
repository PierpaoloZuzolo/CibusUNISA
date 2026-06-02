package model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

public class OrdineBean {
	 private static final long serialVersionUID = 1L;

	    private int codice;
	    private Timestamp dataOrdine;
	    private String indirizzoConsegna;
	    private String metodoPagamento;
	    private int utenteCodice;
	    private List<DettaglioOrdineBean> dettagli;

	    public int getCodice() { return codice; }
	    public void setCodice(int codice) { this.codice = codice; }

	    public Timestamp getDataOrdine() { return dataOrdine; }
	    public void setDataOrdine(Timestamp dataOrdine) { this.dataOrdine = dataOrdine; }

	    public String getIndirizzoConsegna() { return indirizzoConsegna; }
	    public void setIndirizzoConsegna(String indirizzoConsegna) { this.indirizzoConsegna = indirizzoConsegna; }

	    public String getMetodoPagamento() { return metodoPagamento; }
	    public void setMetodoPagamento(String metodoPagamento) { this.metodoPagamento = metodoPagamento; }

	    public int getUtenteCodice() { return utenteCodice; }
	    public void setUtenteCodice(int utenteCodice) { this.utenteCodice = utenteCodice; }

	    public List<DettaglioOrdineBean> getDettagli() { return dettagli; }
	    public void setDettagli(List<DettaglioOrdineBean> dettagli) { this.dettagli = dettagli; }
}
