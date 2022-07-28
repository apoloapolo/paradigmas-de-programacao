{- Um Labelled Transition System (LTS) é um grafo direcionado onde os nós correspondem aos estados de um sistema e as arestas às transições
que modelam ações que mudam o estado do sistema. Abaixo segue um exemplo de uma máquina de venda que libera café (coffee) ou chá (tea) de acordo
com o botão pressionado, vermelho (red) ou azul (blue). Percebam que os estados tem identificadores inteiros e o sistema começa no estado 0 mas
pode mudar para o 3 ou 1 de acordo com a transição escolhida.

Um trace de um LTS é uma sequência de ações que podem ser executadas no sistema.
Por exemplo ["red","coffee","off"] é uma trace válido, enquanto que ["off","red","coffe"] não é um trace válido visto que não podemos
ir do estado 1 para o estado 3. Assim, dado os tipos abaixo para representar um LTS em Haskell,
crie uma função que dado um LTS e um trace (lista de ações), retorna True caso o trace seja válido e False caso contrário.

type Acao = String
type Estado = Int
type Transicao = ((Estado, Estado), Acao)
type LTS = [Transicao] -}

type Acao = String
type Estado = Int
type Transicao = ((Estado, Estado), Acao)
type LTS = [Transicao]

verificaTrace :: LTS -> [String] -> Bool
verificaTrace l [] = False
verificaTrace [] t = False
verificaTrace l (a:as)| consultaEstadoPraOnde l a == (-1) = False
                      | null as = True
                      | consultaEstadoPraOnde l a == consultaEstadoDeOnde l (head as) = verificaTrace l as
                      | otherwise = False
-- Função a ser testada de acordo com o enunciado: recebe um LTS e uma lista de Strings e retorna um booleano caso caminho seja possível ou não.

{- POR FAVOR, NÃO COLOQUE -1 COMO VALOR DE ESTADO EM UMA LTS QUE FOR TESTAR, esse número é a verificação
se a string colocada na lista de entrada está contida na LTS, um fraco tratamento de erro para strings inválidas. -}

consultaEstadoDeOnde:: LTS -> Acao -> Estado
consultaEstadoDeOnde [] t = -1
consultaEstadoDeOnde (a:as) t| snd a == t = fst (fst a)| otherwise = consultaEstadoDeOnde as t
-- Função que retorna o estado de onde uma determinada ação veio ou -1 para uma string inválida.

consultaEstadoPraOnde:: LTS -> Acao -> Estado
consultaEstadoPraOnde [] t = -1
consultaEstadoPraOnde (a:as) t| snd a == t = snd (fst a)| otherwise = consultaEstadoPraOnde as t
-- Função que retorna o estado pra onde uma determinada ação vai ou -1 para uma string inválida.