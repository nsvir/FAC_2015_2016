import Graphics.Gloss

main = animate (InWindow "Dragon" (500, 500) (0, 0)) white (dragonAnime (50,250) (450,250))

dragonAnime a b t = Line (dragon a b !! (round t `mod` 20))

pointAintercaler (xA, yA) (xB, yB) = ((xA + xB)/2 + (yB - yA)/2, (yA + yB)/2 + (xA - xB)/2)

pasDragon [] = []
pasDragon (x:[]) = [x]
pasDragon (x:y:z:xs) = x : (pointAintercaler x y ) : y :
                           (pointAintercaler z y ) : (pasDragon (z:xs))
pasDragon (x:y:xs) = x : (pointAintercaler x y ) : y : (pasDragon xs)

dragon startPoint endPoint = iterate (pasDragon) [startPoint, endPoint]
