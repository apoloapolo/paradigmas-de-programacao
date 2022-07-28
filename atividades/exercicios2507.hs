data Expr = Lit Int |
            Add Expr Expr |
            Sub Expr Expr

showExpr :: Expr -> String
showExpr (Lit n) = show n
showExpr (Add e1 e2) = (showExpr e1) ++ " + " ++ (showExpr e2)
showExpr (Sub e1 e2) = (showExpr e1) ++ " - " ++ (showExpr e2)

data Mylist t = Nulo | Const t (Mylist t) deriving (Show)

data Tree t = Nil | No t ( Tree t ) ( Tree t ) deriving (Show)

toList :: Mylist t -> [t]
toList Nulo = []
toList (Const t l) = t : toList l

fromList :: [t] -> Mylist t
fromList [] = Nulo
fromList (a:as) = Const a(fromList as)

depth :: Tree t -> Int
depth Nil = 0
depth (No a b c) = 1 + max (depth b) (depth c)

type Acao = String
type Estado = Int
type Transicao = ((Estado, Estado), Acao)
type LTS = [Transicao]

verificaLista :: [String] -> String -> Bool
verificaLista [] s = False
verificaLista (a:as) s | a == s = True|otherwise = verificaLista as s

listaPraOnde :: LTS -> Estado -> [String]
listaPraOnde [] e = []
listaPraOnde (a:as) e|e == fst (fst a) = snd a:listaPraOnde as e|otherwise = listaPraOnde as e

listaDeOnde :: LTS -> Estado -> [String]
listaDeOnde [] e = []
listaDeOnde (a:as) e|e == snd (fst a) = snd a:listaDeOnde as e|otherwise = listaDeOnde as e