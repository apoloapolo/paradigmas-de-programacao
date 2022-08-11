{- Uma empresa deseja fazer uma análise sobre posts de personalidades no Twitter para saber os temas mais abordados.
Assim, crie uma função em Haskell que recebe uma lista de tweets (lista de Strings), e devolve uma lista de tuplas,
nas quais o primeiro elemento é a palavra e o segundo a quantidade de vezes que esta palavra se repete em todos os tweets. 
Faça um tratamento nos tweets para remover palavras irrelevantes (artigos, preposições essenciais, conjunções essenciais) 
e assuma que dentro de cada String as palavras estão separadas por espaço em branco. Na sua resposta cada palavra deve aparecer em somente uma tupla. -}

import Data.List (nub)

import Data.Char (toLower)
-- Importando a função toLower de Data.Char para colocar todos os caracteres de uma string em minúsculo.

preposicoesConjuncoes = ["ante","ap\243s","at\233","com","contra","desde","entre","para","perante","por","sem","sob","sobre","tr\225s","afora","como","conforme","consoante", "durante","exceto","mediante","menos","salvo","segundo","visto","porque","pois","que","logo","portanto","como","t\227o","tanto"]
-- Algumas preposições e conjunções pesquisadas na internet (não foi possível achar todas, afinal de contas, português né ¯\_(ツ)_/¯).

trends :: [String] -> [(String, Int)]
trends l = tuplas (nub a) a
            where a = removeIrrelevantes (minuscula (concat (juntaString l)))
{- Função a ser testada como pedido no enunciado, eu sei, é muita função usada como parâmetro mas siga o raciocínio:
Primeiro junta a lista de strings, depois concatena (já que vão ser listas com listas de strings), após isso transforma tudo em minúscula
para facilitar a comparação com "preposicoesConjuncoes", então remove as palavras irrelevantes para só assim serem usandas como parâmentros
para a criação das tuplas. -} 

removeIrrelevantes :: [String] -> [String]
removeIrrelevantes [] = []
removeIrrelevantes (a:as)| length a > 2 && notElem a preposicoesConjuncoes = a:removeIrrelevantes as| otherwise = removeIrrelevantes as
{- Função que faz um tratamento básico para remover palavras irrelevantes como pedido na questão (palavras dentro de "preposicoesConjuncoes" 
e menores que 3 caracteres não entram na saída). -} 

minuscula :: [String] -> [String]
minuscula = map (map toLower)
-- Função que transforma palavras em minúsculas.

juntaString :: [String] -> [[String]]
juntaString = map words
-- Função que separa todos tuítes da lista de entrada por palavras.

tuplas :: [String] -> [String] -> [(String, Int)]
tuplas [] l = []
tuplas (a:as) l = (a, head (listaQtdRepetidos (a:as) l)):tuplas as l
-- Função que cria as tuplas da saída.

listaQtdRepetidos :: [String] -> [String] -> [Int]
listaQtdRepetidos n l = map (`contaRepetidos` l) n
-- Função que recebe o nub de uma lista, a lista completa e retorna outra lista, baseada no nub, com as quantidades de ocorrências de cada palavra.

contaRepetidos :: String -> [String] -> Int
contaRepetidos t [] = 0
contaRepetidos t (a:as)| t == head (a:as) = 1 + contaRepetidos t as| otherwise = contaRepetidos t as
-- Função que conta a quantidade de vezes que uma palavra repete na lista.