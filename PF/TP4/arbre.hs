import Test.QuickCheck 

data Arbre coul a  = Empty | Node coul a (Arbre coul a) (Arbre coul a)
             deriving (Show)

simpleTree :: Arbre String String
simpleTree = Node "rouge" "a"
                  (Node "vert"  "b" Empty Empty)
                  (Node "bleu"  "c" Empty
                                   (Node "orange" "d" Empty Empty))

mapTree :: (c -> a -> b) -> Arbre c a -> Arbre c b
mapTree _ Empty = Empty
mapTree f (Node c a left right) = Node c (f c a) (mapTree f left) (mapTree f right)

foldTree :: (c -> a -> b -> b -> b) -> b -> Arbre c a -> b
foldTree _ r Empty = r
foldTree f e (Node c a left right) = f c a (foldTree f e right) (foldTree f e left)

concatTree :: Arbre a String -> String
concatTree = foldTree (\x y e f -> y ++ e ++ f) []

hauteur :: Arbre a c -> Int
hauteur Empty = 0
hauteur (Node _ _ left right) | rl > rr = rl + 1
                              | otherwise = rr + 1
  where rl = hauteur left
        rr = hauteur right

hauteur' :: Arbre a c -> Int
hauteur' = foldTree (\x y l r -> 1 + max l r) 0

taille :: Arbre a c -> Int
taille Empty = 0
taille (Node _ _ left right) = 1 + taille left + taille right

taille' :: Arbre a c -> Int
taille' = foldTree (\_ e l r -> 1 + l + r) 0

peigneGauche :: [(c, a)] -> Arbre c a
peigneGauche [] = Empty
peigneGauche ((c,a):xs) = Node c a (peigneGauche xs) Empty

-- Il vérifie que la hauteur de notre arbre est égale
-- à la longueur de la liste envoyé à peigneGauche
prop_hauteurPeigne xs = length xs == hauteur (peigneGauche xs)

prop_taille xs = length xs == taille (peigneGauche xs)
                 
estComplet :: Arbre c a -> Bool
estComplet Empty = True
estComplet (Node _ _ Empty Empty) = True
estComplet (Node _ _ _ Empty) = False
estComplet (Node _ _ Empty _) = False
estComplet (Node _ _ left right) = estComplet left && estComplet right

complet :: (Int n) => n -> [(a, c)] -> Arbre a c
complet 0 _ = error ""
complet 1 [] = error ""
complet 1 ((a, c):[]) = Node a c Empty Empty
complet h ((x, y):xs) = Node x y (complet (h - 1) xs) (complet (h - 1)
                                                       (drop ((2 ** h) - 1) xs))
