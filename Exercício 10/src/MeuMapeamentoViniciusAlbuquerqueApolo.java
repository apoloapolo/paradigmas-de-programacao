import java.util.ArrayList;
import java.util.Collection;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author sidneynogueira
 */

//Aluno: Vinicius Augusto Andrade Albuquerque (Apolo)

public class MeuMapeamentoViniciusAlbuquerqueApolo<C,V> implements IMeuMapeamento<C,V> {
	
 	private ArrayList<C> chaves;
	private ArrayList<V> valores;

	public MeuMapeamentoViniciusAlbuquerqueApolo() {
		this.chaves = new ArrayList<C>();
		this.valores = new ArrayList<V>();
	}

	@Override
    public void insere(C chave, V valor) {
		if(chaves.contains(chave)) {
			this.valores.set(this.chaves.indexOf(chave), valor);
		} else {
			this.chaves.add(chave);
			this.valores.add(valor);
		}   
    }

    @Override
    public V valor(C chave) {
        V v = null;
        if (this.chaves.indexOf(chave) != -1) {
        	v = this.valores.get(this.chaves.indexOf(chave));
        }
        return v;
    }

	@Override
    public Collection<V> valores() {
        return this.valores;
    }

	@Override
    public Collection<C> chaves() {
        return this.chaves;
    }

   
}