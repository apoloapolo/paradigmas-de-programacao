{-Crie um programa em Haskell que leia um arquivo "romano.txt" onde cada linha possui um número romano e deve gerar um arquivo "arabico.txt"
que contém a conversão de cada número romano do arquivo de entrada em um número arábico (sistema numérico que utilizamos) ao longo de suas linhas.

Os romanos escreviam números usando as letras I, V, X, L, C, D, M.

 1  => I
10  => X
 7  => VII
Assuma que os números a serem convertidos vão de 0 até 3000. Pesquise na Internet as regras para as numerações romanas
(por exemplo, em http://www.novaroma.org/via_romana/numbers.html). Abaixo segue algumas conversões:

O número 1990 é MCMXC: 

1000=M 900=CM 90=XC

2008 é escrito como MMVIII:

2000=MM 8=VIII

Dica: implemente uma função "numeral" que talvez (tipo Maybe) converta um numeral romano para uma String representando o número arábico.-}

romano 'I' = 1
romano 'V' = 5
romano 'X' = 10
romano 'L' = 50
romano 'C' = 100
romano 'D' = 500
romano 'M' = 1000
romano _ = 0
-- Valores romanos padrões

main :: IO ()
main =  do x <- readFile "romano.txt"
           writeFile "arabico.txt" (linhas (lines x))
{- Função a ser testada de acordo com o enunciado (é só chamar ela). 
Não esqueça de de colocar o arquivo "romano.txt" na mesma pasta que o "q2.hs" está, "arabico.txt" também aparecerá lá.-}

romanoParaArabico :: String -> Int
romanoParaArabico [] = 0
romanoParaArabico (a:as)| null as = romano a 
                        | romano a < romano (head as) = (romano (head as) - romano a) + romanoParaArabico (tail as)
                        | otherwise = romano a + romanoParaArabico as
-- Função que transforma algarismos romanos em valores inteiros.

linhas :: [String] -> String
linhas [] = ""
linhas (a:as)| null as = show (romanoParaArabico a)
             | otherwise = show (romanoParaArabico a) ++ "\n" ++ linhas as
-- Função que recebe a lista do lines e transforma em uma string (dos valores já em arábicos) para utilização no writeFile.