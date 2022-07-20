mytake :: Int -> [a] -> [a]
mytake 0 l = []
mytake n [] = []
mytake n (a:as) = a : (mytake (n-1) as)

tWhile :: (a -> Bool) -> [a] -> [a]
tWhile f [] = []
tWhile f (a:as) | not(f a) = []
                | otherwise = a:(tWhile f as)

quadradosPares l = filter even (map (^2) l)