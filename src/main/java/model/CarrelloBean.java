package model;

import java.io.Serializable;

public class CarrelloBean implements Serializable{
	private ProdottoBean prodotto;
    private int quantita;

    public CarrelloBean(ProdottoBean prodotto, int quantita) {
        this.prodotto = prodotto;
        this.quantita = quantita;
    }

    public ProdottoBean getProdotto() { return prodotto; }
    public void setProdotto(ProdottoBean prodotto) { this.prodotto = prodotto; }
    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }
}
