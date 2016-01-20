-- 3.
sommeDeXaY a b = sum [a .. b]

-- 4.
somme []     = 0
somme (x:xs) = x + (somme xs)

-- 5.
last' (x:[]) = x
last' (x:xs) = last' xs
last' []     = error "liste vide"

init' (_:[]) = []
init' (x:xs) = x : (init' xs)
init' []     = error "liste vide"

-- 6.
(!!!) (x:_) 0  = x
(!!!) (x:xs) n = xs !!! (n - 1)
(!!!) [] _     = error "liste vide"

(+++) [] ys = ys
(+++) (x:xs) ys = x : xs +++ ys

concat' [] = error "liste vide"
concat' (xs:[])  = xs
concat' (xs:xss) = xs +++ concat' xss

my_map fct (x:[]) = fct x : []
my_map fct (x:xs) = (fct x) : (my_map fct xs)

-- 7.
-- Nous utilisons la curryfication.
-- C'est a dire que la fontion '(!!)' qui attend deux parametres,
-- devient la fonction '(!!) l' qui attend un seul parametre.

-- 8.
length' l = somme (map (\_ -> 1) l)

-- 9.
function _ x 1 = [x]
function f x n = x : function f (f x) (n - 1)

function' f x n = take n (iterate f x)

-- 10.
loop n = function' (+ 1) 0 n