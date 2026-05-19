package model;

import java.math.BigDecimal;

public class ProdottoBean {
	
	private int codice;
	private String nome;
	private String descrizione;
	private BigDecimal prezzo;
	private Integer categoriaCodice;
	
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

	public Integer getCategoriaCodice() {
		return categoriaCodice;
	}

	public void setCategoriaCodice(Integer categoriaCodice) {
		this.categoriaCodice = categoriaCodice;
	} 
}
