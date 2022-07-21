{- Aluno: Vinicius Augusto Andrade Albuquerque (Apolo)

Jon Snow precisa planejar seu ataque contra os exércitos da rainha Cersei. Para tanto, ele precisa calcular a força dos exércitos.
Ele pediu a seu amigo Samwell Tarly para construir um programa em Haskell que receba uma lista de tuplas (String, Int),
onde o primeiro argumento da tupla é o tipo de unidade e o segundo é a quantidade destas unidades e retorne o poder do exército.
Cada unidade tem um poder de força: “soldado” – 2, “cavaleiro” – 10, “catapulta” – 30 e “dragão” – 100. Desta forma, ajude Samwell
e desenvolva um programa que dado um exército (lista de tuplas (String,Int)) retorne seu poder (soma dos poderes de cada unidade no exército – força*quantidade).
Por exemplo:
calculaForca [(“soldado”,50), (“catapulta”,5),(“cavaleiro”,10),(“dragão”,2)] = 2*50+30*5+10*10+100*2= 550 -}

poder "soldado" = 2
poder "cavaleiro" = 10
poder "catapulta" = 30
poder "dragão" = 100

calculaForca :: [(String, Int)] -> Int
calculaForca = foldr (\ qtd -> (+) (snd qtd * poder (fst qtd))) 0