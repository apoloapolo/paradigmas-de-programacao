// Aluno: Vinícius Augusto Andrade Albuquerque (Apolo)
package main

import (
	"fmt"
	"sync"
	"time"
)

// Estrutura criada de acordo com o que foi pedido na questão. O array de rune é para armazenar os caracteres.
type Buffer struct {
	buffer     []rune
	tamanho    int
	capacidade int
}

// Utilizei um mutex na função abaixo para fazer as impressões do main corretamente.
var mutex sync.Mutex

// ThreadInsere recebe um ponteiro para o buffer e dois tipos de canais: um que avisa quando está cheio e outro que espera o aviso de esvaziar.
func ThreadInsere(b *Buffer, encheu chan int, esvaziou chan int, id rune) {
	// defer para enviar e receber pelos canais uma última vez (o for no main está escutando o canal que as threads enviam),
	// sem isso a ultima iteração do for no main causava deadlock pois,
	// as threads que usavam os canais "encheu(n)" poderiam ter acabado sua execução.
	defer Terminou(encheu, esvaziou)
	for i := 0; i < 500; i++ {
		// Esse if garante que não vai haver desperdícios de inserção.
		if b.tamanho == b.capacidade {
			// Avisa que encheu
			encheu <- 1
			// Espera esvaziar
			<-esvaziou
			// Utilizei o mutex nessa parte pois acontecia de algumas impressões na main não sairem com os 100 caracteres.
			// Muitas threads usando ao mesmo tempo o método append e aumentando o tamanho do buffer pode ter causado isso.
			// Com o .Lock apenas uma faz isso por vez.
			mutex.Lock()
			b.buffer = append(b.buffer, id)
			b.tamanho++
			mutex.Unlock()
			time.Sleep(time.Duration(2) * time.Millisecond)
		} else {
			mutex.Lock()
			b.buffer = append(b.buffer, id)
			b.tamanho++
			mutex.Unlock()
			time.Sleep(time.Duration(2) * time.Millisecond)
		}
	}
}

// A função Terminou faz o último contato com os canais encheu e esvaziou para não dar deadlock na última iteração do for no main.
func Terminou(encheu chan int, esvaziou chan int) {
	encheu <- 1
	<-esvaziou
}

func main() {
	buff := Buffer{make([]rune, 0), 0, 100}
	// 3 canais de encheu (um para cada thread).
	encheu1 := make(chan int)
	encheu2 := make(chan int)
	encheu3 := make(chan int)
	// 3 canais de esvaziou (um para cada thread).
	esvaziou1 := make(chan int)
	esvaziou2 := make(chan int)
	esvaziou3 := make(chan int)
	// Ponteiro para o buffer.
	p := &buff

	go ThreadInsere(p, encheu1, esvaziou1, rune('1'))
	go ThreadInsere(p, encheu2, esvaziou2, rune('2'))
	go ThreadInsere(p, encheu3, esvaziou3, rune('3'))

	// For adaptado para 15 iterações (quantidade total necessária para esvaziar todas as 3 threads que inserem),
	// funciona sem deadlock se a proporção for respeitada para quantidade de threads que passar, caso seja maior gera deadlock,
	// caso seja menor o main encerra antes das ThreadInsere terminarem.
	for i := 0; i < 15; i++ {
		// Neste for (while true) fica-se esperando os 3 canais avisarem que encheram.
		for {
			var i1, i2, i3 = <-encheu1, <-encheu2, <-encheu3
			if i1 == 1 && i2 == 1 && i3 == 1 {
				i1, i2, i3 = 0, 0, 0
				break
			}
		}
		// Uso o mutex aqui para garantir, também, que a definição do tamanho e o restart no buffer ocorram de forma exclusiva.
		mutex.Lock()
		// Imprime de acordo com o código em Java passado na atividade.
		fmt.Println("Impressao #", (i + 1), ":\n Buffer =", string(p.buffer), "-> Tamanho:", p.tamanho)
		p.tamanho = 0
		// Transforma o buffer em um vazio (para começar o processo de inserção novamente).
		p.buffer = make([]rune, 0)
		mutex.Unlock()
		// Avisa as 3 routines que esvaziou.
		esvaziou1 <- 1
		esvaziou2 <- 1
		esvaziou3 <- 1
	}
}