data Arbre c v = Empty | Node c v (Arbre c v) (Arbre c v)
     deriving (Show)

simpleTree :: Arbre String String
simpleTree = Node "rouge" "a"
                  (Node "vert" "b" Empty Empty)
                  (Node "bleu" "c" Empty
                                   (Node "orange" "d" Empty Empty))
