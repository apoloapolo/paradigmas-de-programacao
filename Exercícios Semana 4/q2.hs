{- Aluno: Vinicius Augusto Andrade Albuquerque (Apolo)

Utilizando a linguagem funcional Haskell, defina uma função que recebe uma lista de listas de elementos de um tipo t (genérico)
e retorna uma lista de tuplas-2 onde o primeiro elemento é um valor do tipo t que existe em pelo menos uma das sub-listas da entrada
e o segundo é o número de ocorrências desse valor nas sub-listas.

Exemplos: contaOcorr ["haskell","eh","legal"] -> [('h',2),('a',2),('s',1),('k',1),('e',3),('l',4),('g',1)]
contaOcorr [[2,45,6,2,1],[7,7,4,3,2]] -> [(2,3),(45,1),(6,1),(1,1),(7,2),(4,1),(3,1)] -}

import Data.List
-- Importando Data.List para usar a função "nub" que remove valores repetidos

contaOcorr :: Eq t => [[t]] -> [(t, Int)]
contaOcorr t = contaOcorrConcatenados (nub (concat t)) (concat t)
-- Função para ser testada: feita como nos exemplos da questão

contaOcorrConcatenados :: Eq t => [t] -> [t] -> [(t, Int)]
contaOcorrConcatenados [] t = []
contaOcorrConcatenados (a:as) t = (a , head (listaQtdRepetidos (a:as) t)):contaOcorrConcatenados as t
-- Função que recebe, já concatenados, nub (valores não repetidos da lista) e a lista completa inserida, retornando uma lista de tuplas como em "contaOcorr"

listaQtdRepetidos :: Eq t => [t] -> [t] -> [Int]
listaQtdRepetidos n l = map (`contaRepetidos` l) n
-- Função que recebe o nub de uma lista, a lista completa e retorna outra lista, baseada no nub, com as quantidades de ocorrências de cada valor

contaRepetidos :: Eq t => t -> [t] -> Int
contaRepetidos t [] = 0
contaRepetidos t (a:as)| t == head (a:as) = 1 + contaRepetidos t as| otherwise = contaRepetidos t as
-- Função que recebe um valor e uma lista concatenada e devolve a quantidade de ocorrências desse valor na lista