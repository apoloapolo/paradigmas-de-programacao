-- Aluno: Vinicius Augusto Andrade Albuquerque (Apolo)

-- Questão 1:
-- Suponha que precisamos calcular 2 elevado a um número n. Se n é par, por exemplo 2*m, então: 2^n = 2^(2*m) = (2^m)^2
-- Se n é ímpar , por exemplo 2*m+1, então: 2^n = 2^(2*m+1) = ((2^m)^2)*2
-- Desta forma, crie uma função recursiva "eleva2:: Int -> Int" que computa 2 elevado a um número n usando estas ideias e sem usar o operador de potência de Haskell (^).

pot :: Int -> Int -> Int
pot a n | (n == 0) = 1 
        | (n == 1) = a 
        | otherwise = a * (pot a (n-1))

eleva2 :: Int -> Int
eleva2 n | (n == 0) = 1 
        | (mod n 2 == 0) = pot (pot 2 (div n 2)) 2 
        | otherwise = (pot (pot 2 (div n 2)) 2) * 2