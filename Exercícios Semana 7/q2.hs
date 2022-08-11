{-A APAC (Agência Pernambucana de Águas e Clima) deseja fazer uma análise sobre dados das suas Plataformas de Coleta de Dados (PCD). 
Cada plataforma possui sensores que detectam diversas variáveis do ambiente e clima como precipitação de chuva (mm), velocidade do vento (km/h),
dentre outros. Estes dados são registrados em observações onde cada observação possui os seguintes campos (com seus respectivos tipos): 
id da PCD (inteiro), dia (inteiro), mês (inteiro), ano (inteiro), precipitação de chuva (real), e velocidade do vento (real).

Assim, crie um programa em Haskell com a seguinte função:

- mesMaisVentos: recebe como parâmetros uma lista de observações, e um inteiro relacionado a um ano de busca. 
Sua função deve retornar o mês cujo acumulado da média de ventos de cada dia foi o maior para o ano passado como parâmetro. 
Lembre-se que um mesmo dia pode ter várias observações de diferentes PCDs. -}

import Data.List (nub)

data PCD = PCD {id::Int, dia::Int, mes::Int, ano::Int, precipitacao::Float, velocidade::Float}
-- Tipo algébrico para ser usado na lista da entrada para cria-lo basta fazer: (PCD _ _ _ _ _ _) subistituindo "_" pelos valores correspondentes a cada atributo.

mesMaisVentos :: [PCD] -> Int -> IO()
mesMaisVentos [] _ = putStrLn "Lista de Entrada Vazia"
mesMaisVentos l ano| a == 0 = putStrLn "Não houve coleta no ano da entrada"
                   | otherwise = putStrLn ("Mês com maior acumulado da média de ventos: " ++ show a ++ "/"++ show ano)
                    where a = maiorAcumulado (acumuladoMeses (mesEAno (filtroAno l ano)) (filtroAno l ano))
-- Função a ser testada como pedido no enunciado, para entender melhor basta seguir as chamadas no "where a = ...".
-- Na condição "a == 0..." como físicamente a velocidade dos ventos não pode ser menor ou igual a 0, considero essa condição em "maiorAcumulado".

filtroAno :: [PCD] -> Int -> [PCD]
filtroAno l a = filter (\x-> ano x == a) l
-- Função que filtra os PCD em uma lista pelo ano passado na entrada.

mesEAno :: [PCD] -> [(Int,Int)]
mesEAno [] = []
mesEAno (a:as) = nub ((mes a, ano a):mesEAno as)
-- Função que cria o "nub" (valores não repetidos) de tuplas com o mês e ano da lista de PCD na entrada.

acumuladoMeses :: [(Int,Int)] -> [PCD] -> [((Int,Int), Float)]
acumuladoMeses [] _ = []
acumuladoMeses (a:as) l = (a, acumulado (mesmoMes l (fst a))):acumuladoMeses as l
-- Função que retorna uma lista com tuplas que representam o acumulado de ventos de um determinado mês.

maiorAcumulado :: [((Int,Int), Float)] -> Int
maiorAcumulado [] = 0
maiorAcumulado (a:as) | null as = fst (fst a)
                      | max (snd a) (snd (head as)) == snd a = maiorAcumulado (a:tail as)
                      | otherwise = maiorAcumulado as
-- Função que compara os meses de "acumuladoMeses" e retorna o mês com maior acumulado. Retorna 0 consulta em anos que não há PCD na lista.

mesmoMes :: [PCD] -> Int -> [PCD]
mesmoMes [] _ = []
mesmoMes (l:ls) m| mes l == m = l:mesmoMes ls m
                 | otherwise = mesmoMes ls m
-- Função que filtra a lista de PCD para outra lista apenas com PCDs no mesmo mês.

acumulado :: [PCD] -> Float
acumulado [] = 0.0
acumulado (a:as) = mediaDia (mesmoDia a (a:as)) + acumulado (removeMesmoDia a (a:as))
-- Função que calcula o acumulado (somando) do mês somando as médias de cada dia.

mediaDia :: [PCD] -> Float
mediaDia a = sum[velocidade x | x <- a] / fromIntegral (length a)
-- Função que retorna a média de cada dia numa lista de PCD.

mesmoDia :: PCD -> [PCD] -> [PCD]
mesmoDia p [] = []
mesmoDia p (a:as)| dia p == dia a && mes p == mes a = a:mesmoDia p as
                 | otherwise = mesmoDia p as
-- Função que filtra a lista de PCD para outra lista apenas com PCDs no mesmo dia.

removeMesmoDia :: PCD -> [PCD] -> [PCD]
removeMesmoDia p [] = []
removeMesmoDia p (a:as)| dia p == dia a && mes p == mes a && ano p == ano a = removeMesmoDia p as
                       | otherwise = a:removeMesmoDia p as