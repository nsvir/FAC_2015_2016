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
main = myanim vonKoch2Anime

myanim = animate (InWindow "flocon" (500, 500) (0, 0)) white 

dessin = interpreteMot aConfig "F"

anim = lsystemeAnime (lsystemeKoch "F") aConfig 

lsystemeAnime :: LSysteme -> Config -> Float -> Picture
lsystemeAnime l (et, p, e, a, xs) f = interpreteMot 
                                        (et, p * (e ^ n), e, a, xs) 
                                        (l !! n)
                            where n = ((round f) `mod` 8)

aConfig :: Config
aConfig =  (((-150,0),0),100,1/3,pi/3,"F+-")

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

type EtatDessin = (EtatTortue, [Path])

etatPoint (p, _) = p
etatPath (_, p) = p

first (a, _) = a

interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole c (e, px) '+' = (tourneAGauche c e, px)
interpreteSymbole c (e, px) '-' = (tourneADroite c e, px)
interpreteSymbole c (e, (h:px)) '[' = ((ne, 0), n:h:px)
                                where n@(ne: _) = reverse h

interpreteSymbole c (e, px) ']' = (e, []:px)

interpreteSymbole c (e, (h:px)) 'F' = (x, (p:(h)):px)
                        where x@(p, a) = (avance c e)

interpreteSymbole _ p _   = p






interpreteMot :: Config -> Mot -> Picture
interpreteMot c@(et@(p, a), _,_,_,_) m = Line (concat (etatPath 
                                        (foldl (interpreteSymbole c) (et, [[p]]) m)))

vonKoch1 :: LSysteme
vonKoch1 = lsysteme "F" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

vonKoch2 :: LSysteme
vonKoch2 = lsysteme "F++F++F++" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

hilbert :: LSysteme
hilbert = lsysteme "X" regles
    where regles 'X' = "+YF-XFX-FY+"
          regles 'Y' = "-XF+YFY+FX-"
          regles  s  = [s]

dragon :: LSysteme
dragon = lsysteme "FX" regles
    where regles 'X' = "X+YF+"
          regles 'Y' = "-FX-Y"
          regles  s  = [s]

vonKoch1Anime :: Float -> Picture
vonKoch1Anime = lsystemeAnime vonKoch1 (((-400, 0), 0), 800, 1/3, pi/3, "F+-")

vonKoch2Anime :: Float -> Picture
vonKoch2Anime = lsystemeAnime vonKoch2 (((-400, -250), 0), 800, 1/3, pi/3, "F+-")

hilbertAnime :: Float -> Picture
hilbertAnime = lsystemeAnime hilbert (((-400, -400), 0), 800, 1/2, pi/2, "F+-")

dragonAnime :: Float -> Picture
dragonAnime = lsystemeAnime dragon (((0, 0), 0), 50, 1, pi/2, "F+-")

--foldl :: (b -> a -> b) -> b -> t a -> b 
--(a -> b -> a) [b]

brindille :: LSysteme
brindille = lsysteme "F" regles
    where regles 'F' = "F[-F]F[+F]F"
          regles  s  = [s]

broussaille :: LSysteme
broussaille = lsysteme "F" regles
    where regles 'F' = "FF-[-F+F+F]+[+F-F-F]"
          regles  s  = [s]

brindilleAnime :: Float -> Picture
brindilleAnime = lsystemeAnime brindille (((0, -400), pi/2), 800, 1/3, 25*pi/180, "F+-[]")

broussailleAnime :: Float -> Picture
broussailleAnime = lsystemeAnime broussaille (((0, -400), pi/2), 500, 2/5, 25*pi/180, "F+-[]")
