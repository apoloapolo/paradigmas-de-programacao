package cooperacaoSemaforo;

public class ThreadEsvaziar extends Thread {

    private final BufferSemaforo buf;
    private final char id;

    public ThreadEsvaziar(BufferSemaforo buf, char c) {
        this.buf = buf;
        this.id = c;
    }

    @Override
    public void run() {
        String result;
        for (int i = 0; i < 10; i++) {
            result = buf.esvaziar();
            System.out.println("\n\nImpressao # " + (i + 1) + " ("+ this.id +") "+ ":\n Buffer = "
                    + result + " -> Tamanho: " + result.length());
        }
        System.out.println("ThreadEsvaziar" + " ("+ this.id +") " + "terminou");
    }
}
