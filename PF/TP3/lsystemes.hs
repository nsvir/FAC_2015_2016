module Lsystemes where

type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

motSuivant :: Regles -> Mot -> Mot

motSuivant rules (a:as) = rules a ++ motSuivant rules as
motSuivant _ [] = []

motSuivant' rules ws = [ x | w <- ws, x <- rules w]

motSuivant'' = concatMap

kochRules :: Symbole -> Mot
kochRules 'F' = ['F','-','F','+','+','F','-','F']
kochRules '+' = ['+']
kochRules '-' = ['-']

kochSuivant = ant kochRules
kochSuivant= motSuivant' kochRules
kochSuivant'' = motSuivant'' kochRules

lsysteme :: Axiome -> Regles -> LSysteme
lsysteme w rules = iterate (motSuivant rules) w

lsystemeKoch = revCur lsysteme kochRules

revCur f a b = f b a
