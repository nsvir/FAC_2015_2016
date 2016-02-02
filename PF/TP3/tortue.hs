type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

type Point = (Float, Float)
type EtatTortue = (Point, Float)

type Config = (EtatTortue -- État initial de la tortue
              ,Float      -- Longueur initiale d’un pas
              ,Float      -- Facteur d’échelle
              ,Float      -- Angle pour les rotations de la tortue
              ,[Symbole]) -- Liste des symboles compris par la tortue

aConfig :: Config
aConfig = (((0,0), pi / 4), sqrt 2, 1, pi / 2, ['F', '-', '+'])

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
