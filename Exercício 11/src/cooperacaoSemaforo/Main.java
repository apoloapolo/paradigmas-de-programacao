package cooperacaoSemaforo;

// Aluno: Vinicius Augusto Andrade Albuquerque (Apolo)
public class Main {
	
    public static void main(String[] args) {
        int NUM_INSERIR = 4;
        int NUM_ESVAZIAR = 2;
        
        ThreadInserir[] ti = new ThreadInserir[NUM_INSERIR];
        ThreadEsvaziar[] te = new ThreadEsvaziar[NUM_ESVAZIAR];
        
        BufferSemaforo buf = new BufferSemaforo();
    	
        for(int i = 0; i < NUM_INSERIR; i++) {
        	ti[i] = new ThreadInserir(buf, Integer.toString(i+1).charAt(0));
        	ti[i].start();
        }
        
        // Foi removido os joins deste for que aconteciam logo em seguida do .start
        for(int i = 0; i < NUM_ESVAZIAR; i++) {
        	te[i] = new ThreadEsvaziar(buf, Integer.toString(i+1).charAt(0));
        	te[i].start();
        }
        
        int threadEsvaziarEncerradas = 0;
        
        // Função que verificava se haviam threads esvaziar ativas. 
        // (optei por manter já que já tinha mostrado ao senhor em sala)
        while (threadEsvaziarEncerradas < NUM_ESVAZIAR) {
        	for(int i = 0; i < NUM_ESVAZIAR; i++) {
        		if (te[i] != null) {
        			if (te[i].isAlive()) {
        				continue;
        			} else {
        				threadEsvaziarEncerradas++;
        				te[i] = null;
        			}
        		} else {
        			continue;
        		}
        	}
        }
        
        // Função que chama o método meuStop das threads inserir.
        for(int i = 0; i < NUM_INSERIR; i++) {
        	ti[i].meuStop();
        } 
    }
}
