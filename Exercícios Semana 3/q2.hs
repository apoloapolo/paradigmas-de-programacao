-- Aluno: Vinicius Augusto Andrade Albuquerque (Apolo)

-- Questão 2:
-- Assumindo a estrutura de sinônimos abaixo:
-- type Nome = String
-- type Idade = Int
-- type Telefone = Int
-- type Pessoa = (Nome, Idade , Telefone)
-- Crie uma função que recebe quatro pessoas e deve retornar uma String contendo nome e telefone das pessoas cujas idades são maiores ou iguais a média das idades das quatro pessoas passadas como parâmetro.

type Nome = String
type Idade = Int
type Telefone = Int
type Pessoa = (Nome, Idade , Telefone)

nometelefone :: Pessoa -> Pessoa -> Pessoa -> Pessoa -> String
nometelefone (n1 , i1 , t1) (n2 , i2 , t2) (n3 , i3 , t3) (n4 , i4 , t4) = "dsds"