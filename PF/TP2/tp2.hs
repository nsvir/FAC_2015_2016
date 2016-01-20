alterne []       = []
alterne (x:[])   = [x]
alterne (x:_:xs) = x : alterne xs

combine _  _ [] = []
combine _ []  _ = []
combine f (x:xs) (y:ys) = (f x y) : combine f xs ys

pasPascal [] = [1]
pasPascal xs = zipWith (+) (0:xs) (reverse (0:xs))

pascal = iterate (pasPascal) [1]
