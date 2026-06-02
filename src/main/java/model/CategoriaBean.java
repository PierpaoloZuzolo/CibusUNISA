package model;

import java.io.Serializable;

public class CategoriaBean implements Serializable{
	    private static final long serialVersionUID = 1L;
	    
	    private String nome;
	    private String descrizione;

	    public String getNome() { return nome; }
	    public void setNome(String nome) { this.nome = nome; }

	    public String getDescrizione() { return descrizione; }
	    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }	
}
