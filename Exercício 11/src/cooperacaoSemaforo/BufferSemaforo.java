package cooperacaoSemaforo;

import java.util.concurrent.Semaphore;

/**
 * Similar a classe BufferWaitNotify porém usa Semáforo no lugar de wait/notify
 * @author sidneynogueira
 */
public class BufferSemaforo {

    private final char[] buf;
    private int tam;
    private final int MAX = 100;

    public BufferSemaforo() {
        buf = new char[MAX];
        tam = 0;
    }
    
    // A função inserir notifica as threads de esvaziar (e outras também) e então entra em wait.
    public synchronized void inserir(char c) {
        if (tam == MAX) {
            try {
            	notifyAll();
				wait();
			} catch (InterruptedException e) {}
        } else {
            buf[tam++] = c;
        }

    }
    
    // A função esvaziar entra em wait dentro do while caso o tamanho não seja máximo.
    // Assim que possível transforma tamanho em 0 e notifica as threads inserir (e outras também).
    public synchronized String esvaziar() {
    	while (tam < MAX) {
    		try {
				wait();
			} catch (InterruptedException e) {}
    	}
    	tam = 0;
    	notifyAll();
    	return new String(buf);
    }

}
