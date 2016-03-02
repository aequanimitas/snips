-- comparing functions error messages
doubleUs x y = doubleMe x + doubleMe y

doubleMe x = x * x

doubleYeah :: Int -> Int -> Int
doubleYeah x y = doubleMe x + doubleMe y


-- lists
longList = [1..1000000]

charA = 'A'
charBrackets = "A"

-- charBrackets:" LONG" wont work
-- charA:" LONG" will
--
-- ranges
reverseCoundown = [20,19..1]
takeMultiples = take 10000 [1,1000..]

repeatTake = take 10 (repeat 5)
replicate3 x y = replicate x y

-- cool comprehension
nouns = ["hobo", "frog", "pope"]
adjectives = ["lazy", "grouchy", "scheming"]

-- [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]
--
length' xs = sum[1 | _ <- xs]
