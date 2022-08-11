{-Um dos principais componentes de uma ração para cães é a proteína bruta.
Existem pesquisas que indicam que o percentual mínimo de proteína bruta para cães adultos
é de 21% enquanto que para filhotes é 25%. Assim, crie um programa em Haskell  que lê um
arquivo "racoes.txt", onde em cada linha possui as seguinte informações separadas por ponto e vírgula:
nome da ração, quantidade total em quilos, quantidade em kilos de proteína bruta. Em seguida,
seu programa deve perguntar ao usuário se a consulta é para um cão adulto ou filhote. 
Por último, seu programa deve imprimir na saída padrão o nome e percentuais de proteína bruta das rações
cujos percentuais estão iguais ou acima do recomendado para a maturidade do cão consultada. Exemplo de conteúdo de arquivo:

Dog Excellence;15;3.9

Royal Canin;15;3,6

Golden Special;20;4.4

Premier;12;3.36-}

data Racao = Racao {nome :: String, kgtotal :: Float, kgproteina :: Float}

main :: IO ()
main = do r <- readFile "racoes.txt"
          putStrLn "Cão adulto ou filhote?"
          cao <- getLine
          ehAdulto cao (linhas (racoesAdulto (listaRacoes (lines r)))) (linhas (racoesFilhote (listaRacoes (lines r))))

ehAdulto :: String -> String -> String -> IO()  
ehAdulto "adulto" s a = putStrLn s
ehAdulto _ _ a = putStrLn a

linhas :: [Racao] -> String
linhas [] = ""
linhas (a:as) = (nome a) ++ ": " ++ show ((kgproteina a / kgtotal a)*100) ++ "% de proteina"++"\n"++linhas as

racoesAdulto :: [Racao] -> [Racao]
racoesAdulto [] = []
racoesAdulto (a:as)|(kgproteina a / kgtotal a) >= 0.21 = a:racoesAdulto as|otherwise = racoesAdulto as

racoesFilhote :: [Racao] -> [Racao]
racoesFilhote [] = []
racoesFilhote (a:as)|(kgproteina a / kgtotal a) >= 0.25 = a:racoesFilhote as|otherwise = racoesFilhote as

listaRacoes :: [String] -> [Racao]
listaRacoes = map (criaRacao . split)

criaRacao :: [String] -> Racao
criaRacao x = case x of
    (n:kt:kp:t) -> Racao n (read kt :: Float) (read kp :: Float)
    _ -> Racao "" 0.0 0.0

split :: String -> [String]
split p = words [if c == ';' then ' ' else c|c <- p]