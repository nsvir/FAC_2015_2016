data Arbre a c  = Empty | Node a c (Arbre c a) (Arbre c a)
             deriving (Show)

simpleTree :: Arbre a c
simpleTree = Node ("rouge","a")
                  (Node ("vert", "b") Empty Empty)
                  (Node ("bleu", "c") Empty
                                   (Node ("orange", "d") Empty Empty))

mapTree :: (a -> c -> b) -> Arbre a c -> Arbre b
mapTree _ Empty = Empty
mapTree f (Node content left right) = Node (f content) (mapTree f left) (mapTree f right)

foldTree :: (Content -> b -> b) -> b -> Arbre a c -> b
foldTree _ r Empty = r
foldTree f e (Node content left right) = f content (foldTree f (foldTree f e right) left)

concatTree :: Arbre a String -> String
concatTree = foldTree (\x  y) e -> y ++ e) []

hauteur :: Arbre a c -> Integer
hauteur Empty = 0
hauteur (Node _ left right) | rl > rr = rl + 1
                            | otherwise = rr + 1
  where rl = hauteur left
        rr = hauteur right

hauteur' :: Arbre a c -> Integer
hauteur' = foldTree (\x y -> if x > y then x else y + 1) 0 . mapTree (\_ -> 1)

taille :: Arbre a c -> Integer
taille Empty = 0
taille (Node _ left right) = 1 + taille left + taille right

taille' :: Arbre a c -> Integer
taille' = foldTree (\_ e -> e + 1) 0

