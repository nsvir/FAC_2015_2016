module Main where

import Graphics.Gloss
import Lsystemes



--type Point = (Float, Float)
type EtatTortue = (Point, Float)

type Config = (EtatTortue -- État initial de la tortue
              ,Float      -- Longueur initiale d’un pas
              ,Float      -- Facteur d’échelle
              ,Float      -- Angle pour les rotations de la tortue
              ,[Symbole]) -- Liste des symboles compris par la tortue


-- main = display (InWindow "L-système" (1000, 1000) (0, 0)) white dessin
main = animate (InWindow "flocon" (500, 500) (0, 0)) white anim

dessin = interpreteMot (((-150,0),0),100,1,pi/3,"F+-") "F+F--F+F" 

anim = lsystemeAnime (lsystemeKoch "F") aConfig 

lsystemeAnime :: LSysteme -> Config -> Float -> Picture
lsystemeAnime l (et, p, e, a, xs) f = (interpreteMot 
                                        (et, p / (2 ** f), e, a, xs) 
                                        (l !! ((round f) `mod` 4)))
aConfig :: Config
aConfig = (((0,0), 0), 100, 1, pi / 2, ['F', '+', '-'])

etatInitial :: Config -> EtatTortue
etatInitial (a, _, _, _, _) = a

longueurPas :: Config -> Float
longueurPas (_, a, _, _, _) = a

facteurEchelle :: Config -> Float
facteurEchelle (_, _, a, _, _) = a

angle :: Config -> Float
angle (_, _, _, a, _) = a

symbolesTortue :: Config -> [Symbole]
symbolesTortue (_, _, _, _, a) = a

avance :: Config -> EtatTortue -> EtatTortue
avance (_, pas, _, _, _) ((x, y), angle) = ((x + pas * cos angle, y + pas * sin angle), angle)

tourneAGauche :: Config -> EtatTortue -> EtatTortue
tourneAGauche (_, _, _, rot, _) (point, angle) = (point, angle + rot)

tourneADroite :: Config -> EtatTortue -> EtatTortue
tourneADroite (_, _, _, rot, _) (point, angle) = (point, angle - rot)

filtreSymbolesTortue :: Config -> Mot -> Mot
filtreSymbolesTortue (_,_,_,_,syms) mot = filter (`elem` syms) mot 

type EtatDessin = (EtatTortue, Path)

etatPoint (p, _) = p
etatPath (_, p) = p

interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole c (e, px) x = (ne, etatPoint ne:px)
                where ne = case x of
                         '+' -> tourneAGauche c e 
                         '-' -> tourneADroite c e
                         'F' -> avance c e 

tortue :: EtatDessin
tortue = (etatInitial aConfig,[])

interpreteMot :: Config -> Mot -> Picture
interpreteMot c m = Line (etatPath (foldl (interpreteSymbole c) tortue m))

--foldl :: (b -> a -> b) -> b -> t a -> b 
--(a -> b -> a) [b]

