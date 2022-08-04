{- Assumindo que os dados de vacina para o COVID-19 estejam em um arquivo "vacina.txt" e que as linhas representam dados das pessoas
que participam do estudo e estão estruturadas da seguinte forma:

[id];[idade];[placebo];[reação]

onde [id] representa um inteiro identificando uma pessoa, [idade] informa a idade da pessoa, [placebo] caso seja "true" indica que
a vacina tomada é um placebo, caso seja "false" indica que realmente foi a vacina sendo testada, e [reação] pode ser "nenhuma" caso
não tenha tido reação, "leve" caso tenha tido algum sintoma leve, "forte" caso tenha sentido algum sintoma forte.
Crie um programa em Haskell deve ler este arquivo e imprimir na saída padrão as seguintes informações:
- A razão de pessoas que tomaram placebo;
- A razão de pessoas que não tomaram placebo;
- A razão de pessoas que tomaram a vacina (não foi placebo) não tiveram reação;
- Quantidade de pessoas acima de 50 anos que tomaram a vacina (não foi placebo) e tiveram algum tipo de reação; -}

data Pessoa = Pessoa {id :: Int, idade :: Int, placebo :: String, reacao :: String}

main :: IO ()
main = do v <- readFile "vacina.txt"
          putStrLn ("Razão de pessoas que tomaram placebo: " ++ show (contaPlacebo(listaPessoas (lines v))) ++ "/" ++ show (length (lines v)))
          putStrLn ("Razão de pessoas que não tomaram placebo: " ++ show (contaNaoPlacebo(listaPessoas (lines v))) ++ "/" ++ show (length (lines v)))
          putStrLn ("Razão de pessoas que tomaram a vacina (não foi placebo) não tiveram reação: " ++ show (contaVacinaNaoReacao(listaPessoas (lines v))) ++ "/" ++ show (length (lines v)))
          putStrLn ("Quantidade de pessoas acima de 50 anos que tomaram a vacina (não foi placebo) e tiveram algum tipo de reação: " ++ show (contaQtdAcima50(listaPessoas (lines v))))
-- Função a ser testada de acordo com o enunciado (basta chamar ela). Não esqueça de colocar o arquivo "vacina.txt" na mesma pasta que o "q1.hs" está.
-- As razões apareceram na forma a/b onde a é a quantidade do filtro e b é o total de vacinados no arquivo.

contaPlacebo :: [Pessoa] -> Int
contaPlacebo [] = 0
contaPlacebo (a:as) | placebo a == "true" = 1 + contaPlacebo as | otherwise = contaPlacebo as
-- Função que conta a quantidade de pessoas que receberam placebo.

contaNaoPlacebo :: [Pessoa] -> Int
contaNaoPlacebo [] = 0
contaNaoPlacebo (a:as) | placebo a == "false" = 1 + contaNaoPlacebo as | otherwise = contaNaoPlacebo as
-- Função que conta a quantidade de pessoas que não receberam placebo.

contaVacinaNaoReacao :: [Pessoa] -> Int
contaVacinaNaoReacao [] = 0
contaVacinaNaoReacao (a:as)| placebo a == "false" && reacao a == "nenhuma" = 1 + contaVacinaNaoReacao as | otherwise = contaVacinaNaoReacao as
-- Função que conta a quantidade de pessoas que não receberam placebo e não tiveram reação.

contaQtdAcima50 :: [Pessoa] -> Int
contaQtdAcima50 [] = 0
contaQtdAcima50 (a:as) | idade a > 50 && placebo a == "false" && reacao a /= "nenhuma" = 1 + contaQtdAcima50 as | otherwise = contaQtdAcima50 as
-- Função que conta a quantidade de pessoas acima de 50 anos que tomaram a vacina e tiveram reação.

listaPessoas :: [String] -> [Pessoa]
listaPessoas = map (criaPessoa . split)
-- Função que cria uma lista de pessoas a partir da lista da função lines.

criaPessoa :: [String] -> Pessoa
criaPessoa x = case x of
    (id:idade:placebo:reacao:t) -> Pessoa (read id :: Int) (read idade :: Int) placebo reacao
    _ -> Pessoa 0 0 "" ""
-- Função que cria uma pessoa a partir da lista de parâmetros gerados na função split.

split :: String -> [String]
split p = words [if c == ';' then ' ' else c|c <- p]
-- Função que separa os valores de uma linha do txt de entrada a partir de ";" (muito parecido com as funções split string de outras linguagens).