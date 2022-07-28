{- Blockchain é basicamente um banco de dados distribuído onde os dados são armazenados em blocos onde cada bloco possui transações financeiras
e uma referência para o próximo bloco formando uma corrente. Assumindo os tipos de dados abaixo, crie uma função em Haskell que dado um Bloco
como entrada, retorna o índice do bloco da corrente com o maior volume financeiro de transações;

data Transacao = Transacao { de :: String -- Conta que paga
                            , para :: String -- Conta que recebe
                            , valor :: Float -- Quanto está pagando
                            } deriving (Show)

data Bloco = Bloco { indice :: Int -- Indice do bloco
                                 , trs :: [Transacao] -- Lista de transações de um bloco
                                 , proximo :: Maybe Bloco -- Proximo bloco
                                 } deriving (Show)

OBS: para definir um valor do tipo bloco é só especificar (Bloco ind trs prox), onde ind é um inteiro, trs é uma lista de transações e prox é um Maybe Bloco.
O mesmo se aplica ao tipo Transacao. -}

data Transacao = Transacao { de :: String, para :: String, valor :: Float } deriving (Show)
data Bloco = Bloco { indice :: Int, trs :: [Transacao], proximo :: Maybe Bloco } deriving (Show)

maiorTransacao :: Bloco -> Int
maiorTransacao b = indice (comparaBloco (b:listaBloco (proximo b)))
-- Função a ser testada de acordo com o enunciado: recebe um bloco e devolve o indice do bloco com maior valor de transações na corrente.

{- ATENÇÃO: MUITO CUIDADO NA HORA DE TESTAR, A ENTRADA PARA A FUNÇÃO PODE SER BEM CONFUSA POR SE TRATAR DE BLOCOS DENTRO DE BLOCOS.
VERIFIQUE SE NÃO ESTÁ FALTANDO ALGUM PARÊNTESE. -}

listaBloco :: Maybe Bloco -> [Bloco]
listaBloco Nothing = []
listaBloco (Just b1) = b1: listaBloco (proximo b1)
-- Função que retorna um lista de blocos a partir dos "proximo"s de um determinado bloco.

comparaBloco :: [Bloco] -> Bloco
comparaBloco [] = (Bloco (-1) [] Nothing)
comparaBloco (a:as) |null as = a
                    |max (somaTransacoes (trs a)) (somaTransacoes (trs (head as))) == somaTransacoes (trs a) = comparaBloco (a:tail as)
                    |otherwise = comparaBloco as
-- Função que compara uma lista de blocos procurando pelo maior valor de transações entre eles: retorna o bloco com maior valor de transações.
-- "(Bloco (-1) [] Nothing)" é apenas um bloco genérico para o caso de lista vazia (o que não pode acontecer pois o erro viria já na função maiorTransacao).

somaTransacoes :: [Transacao] -> Float
somaTransacoes = foldr ((+) . valor) 0.0