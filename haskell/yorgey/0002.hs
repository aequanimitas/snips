strLength :: String -> Int
strLength [] = 0
strLength (_:xs) = let len_rest = strLength xs in len_rest + 1
