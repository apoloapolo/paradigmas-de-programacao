import java.util.ArrayList;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author sidneynogueira
 */
public class MeuMapeamento<C,V> implements IMeuMapeamento<C,V> {
	
	private ArrayList<C> chaves;
	private ArrayList<V> valores;

	public MeuMapeamento() {
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

    @SuppressWarnings("unchecked")
	@Override
    public V[] valores() {
    	V[] v = (V[]) this.valores.toArray();
        return v;
    }

    
	@SuppressWarnings("unchecked")
	@Override
    public C[] chaves() {
    	C[] c = (C[]) this.chaves.toArray();
    	C[] c1 = new C[];
    	System.arraycopy(c, 0, c1, 0, this.chaves.size() );
        return (C[]) c;
    }

   
}