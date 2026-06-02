package model;

import java.io.Serializable;
import java.math.BigDecimal;

public class DettaglioOrdineBean implements Serializable {
	 private static final long serialVersionUID = 1L;

	    private int codiceOrdine;
	    private ProdottoBean prodotto;
	    private int quantita;
	    private BigDecimal prezzoUnitario;

	    public int getCodiceOrdine() { return codiceOrdine; }
	    public void setCodiceOrdine(int codiceOrdine) { this.codiceOrdine = codiceOrdine; }

	    public ProdottoBean getProdotto() { return prodotto; }
	    public void setProdotto(ProdottoBean prodotto) { this.prodotto = prodotto; }

	    public int getQuantita() { return quantita; }
	    public void setQuantita(int quantita) { this.quantita = quantita; }

	    public BigDecimal getPrezzoUnitario() { return prezzoUnitario; }
	    public void setPrezzoUnitario(BigDecimal prezzoUnitario) { this.prezzoUnitario = prezzoUnitario; }

}
