package cooperacaoSemaforo;

public class ThreadInserir extends Thread {

    private final BufferSemaforo buffer;
    private final char id;
    private boolean exit;

    public ThreadInserir(BufferSemaforo buf, char c) {
        this.buffer = buf;
        this.id = c;
        this.exit = false;
    }
    
    public void meuStop() {
    	this.exit = true;
    }

    @Override
    public void run() {
        for (int i = 0; i < 500; i++) {
        	if (exit) {
        		break;
        	} else {
        		buffer.inserir(id);
        	}
        }
        try {
            sleep((long) 30);
        } catch (InterruptedException ie) {}
        System.out.println("Thread " + id + " terminou");
    }
}
