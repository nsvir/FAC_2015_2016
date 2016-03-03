type TreeContent x y = (x, y)

data GenericTree c v = Empty | Node (TreeContent c v) (GenericTree c v) (GenericTree c v)
     deriving (Show)

type Arbre = GenericTree String String
     
simpleTree :: Arbre
simpleTree = Node (TreeContent "rouge" "a")
                  (Node (TreeContent "bleu" "c") Empty
                                   (Node "orange" "d" Empty Empty))

mapArbre :: (ConsVal -> ConsVal) -> Arbre -> Arbre
mapArbre f Empty = Empty
mapArbre f tree@(Node content left right) = Node (f content) (mapArbre left) (mapArber right)
