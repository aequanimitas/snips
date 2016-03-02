-- comparing functions error messages
doubleUs x y = doubleMe x + doubleMe y

doubleMe x = x * x

doubleYeah :: Int -> Int -> Int
doubleYeah x y = doubleMe x + doubleMe y


-- lists
longList = [1...1000000]

charA = 'A'
charBrackets = "A"

-- charBrackets:" LONG" wont work
-- charA:" LONG" will
