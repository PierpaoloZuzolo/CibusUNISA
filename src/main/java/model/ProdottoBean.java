package model;

import java.io.InputStream;
import java.io.Serializable;
import java.math.BigDecimal;

public class ProdottoBean implements Serializable{
	
	private int codice;
	private String nome;
	private String descrizione;
	private BigDecimal prezzo;
	private String categoriaNome;
	private boolean attivo;
	private InputStream immagine; 
	
	public InputStream getImmagine() {
		return immagine;
	}

	public void setImmagine(InputStream immagine) {
		this.immagine = immagine;
	}

	public int getCodice() {
		return codice;
	}
	
	public void setCodice(int codice) {
		this.codice = codice;
	}
	
	public String getNome() {
		return nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public String getDescrizione() {
		return descrizione;
	}
	
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	
	public BigDecimal getPrezzo() {
		return prezzo;
	}
	
	public void setPrezzo(BigDecimal prezzo) {
		this.prezzo = prezzo;
	}

	public String getCategoriaNome() {
		return categoriaNome;
	}

	public void setCategoriaNome(String categoriaNome) {
		this.categoriaNome = categoriaNome;
	} 
	
	public boolean isAttivo() {
		return attivo;
	}

	public void setAttivo(boolean attivo) {
		this.attivo = attivo;
	}
}
