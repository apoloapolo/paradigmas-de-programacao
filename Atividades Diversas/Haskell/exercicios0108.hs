put4times :: String -> IO ()
put4times str = do putStrLn str
                   putStrLn str
                   putStrLn str
                   putStrLn str

getNput :: IO ()
getNput = do line <- getLine
             putStrLn (reverse line)

helloWorld :: IO ()
helloWorld = do putStrLn "Hello World!"

main :: IO()
main = do putStr "Digite seu nome:"
          st <- getLine
          putStrLn "Ao contrario é:"
          putStrLn (reverse st)

main2 :: IO ()
main2 = do putStrLn "Escrevendo"
           writeFile "C:/Users/vinic/Desktop/a.txt" "Hello\nworld"
           appendFile "C:/Users/vinic/Desktop/a.txt" "\nof\nHaskell"
           putStrLn "Lendo o arquivo"
           x <- readFile "C:/Users/vinic/Desktop/a.txt"
           putStrLn x

shorten :: String -> String
shorten [] = ""
shorten (a:as)| a == '=' = "http://youtu.be/" ++ as| otherwise = shorten as

putLines :: [String] -> String
putLines [] = ""
putLines (a:as)|null as = shorten a|otherwise = putLines as

main3 :: IO ()
main3 = do x <- readFile "C:/Users/vinic/Desktop/a.txt"
           putStrLn (putLines (lines x))

