{-- Aluno: Vinicius Augusto Andrade Albuquerque (Apolo)

Questão 2:
Assumindo a estrutura de sinônimos abaixo:

type Nome = String
type Idade = Int
type Telefone = Int
type Pessoa = (Nome, Idade , Telefone)

Crie uma função que recebe quatro pessoas e deve retornar uma String contendo nome e telefone das pessoas cujas idades
são maiores ou iguais a média das idades das quatro pessoas passadas como parâmetro.--}

type Nome = String
type Idade = Int
type Telefone = Int
type Pessoa = (Nome, Idade , Telefone)

nometelefone :: Pessoa -> Pessoa -> Pessoa -> Pessoa -> String
nometelefone (n1 , i1 , t1) (n2 , i2 , t2) (n3 , i3 , t3) (n4 , i4 , t4) = verificapessoa (n1 , i1 , t1) s ++ verificapessoa (n2 , i2 , t2) s ++ verificapessoa (n3 , i3 , t3) s ++ verificapessoa (n4 , i4 , t4) s
        where s = fromIntegral (i1 + i2 + i3 + i4) :: Float

verificapessoa :: Pessoa -> Float -> String
verificapessoa (n , i , t) s | idade (n , i , t) >= (s/4) = "| Nome: " ++ nome (n , i , t) ++ ", " ++ "Telefone: "++ telefone (n , i , t) ++ " |" | otherwise = ""

nome :: Pessoa -> String
nome (n , i , t) = n

idade :: Pessoa -> Float
idade (n , i , t) = id
        where id = fromIntegral i :: Float

telefone :: Pessoa -> String
telefone (n , i , t) = show t