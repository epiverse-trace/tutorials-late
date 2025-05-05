---
title: 'Glossaire des termes : Epiverse-TRACE'
---

## A

[Transmission par voie aérienne]{#airborne}
 Les individus sont infectés par contact avec des particules infectieuses présentes dans l'air. Les exemples incluent la grippe et le COVID-19. Atler et al. (2023) parlent de [les facteurs et les procédures de gestion](https://www.ncbi.nlm.nih.gov/books/NBK531468/) de la transmission par voie aérienne.

## B

[Numéro de reproduction de base]{#basic}
: Mesure de la transmissibilité d'une maladie. Défini comme le nombre moyen de cas secondaires survenant à partir d'un cas initial infecté dans une population entièrement sensible. [Plus d'informations sur l'indice de reproduction de base](https://en.wikipedia.org/wiki/Basic_reproduction_number).

[Inférence bayésienne]{#bayesian}
 L'inférence bayésienne est un type d'inférence statistique dans lequel les croyances préalables sont mises à jour à l'aide des données observées.
[Plus d'informations sur l'inférence bayésienne](https://en.wikipedia.org/wiki/Bayesian_inference).

## C

[Matrice de contact]{#contact}
 Matrice des contacts : La matrice des contacts est une matrice carrée composée de lignes/colonnes égales au nombre de groupes d'âge. Chaque élément représente la fréquence des contacts entre les groupes d'âge. Si nous pensons que la transmission d'une infection se fait par contact et que les taux de contact sont très différents selon les groupes d'âge, la spécification d'une matrice de contact nous permet de prendre en compte les taux de transmission spécifiques à l'âge.

[C++]{#cplusplus}
 C++ : C++ est un langage de programmation de haut niveau qui peut être utilisé dans R pour accélérer des sections de code. Pour en savoir plus sur le C++, consultez les sites suivants [tutoriels](https://cplusplus.com/doc/tutorial/) et apprenez-en plus sur l'intégration de C++ et de R [ici](https://www.rcpp.org/).
 [Censure]{#censoring}
:
signifie que nous savons qu'un événement s'est produit, mais que nous ne savons pas exactement quand il s'est produit. La plupart des données épidémiologiques sont "doublement censurées" parce qu'il y a une incertitude concernant les temps des événements primaires et secondaires. Ne pas tenir compte de la censure peut conduire à des estimations biaisées de l'écart-type du délai ([Park et al.](https://github.com/parksw3/epidist-paper)).
Les différentes approches d'échantillonnage peuvent générer des biais dus à la censure à gauche et à droite dans l'estimation de l'intervalle sériel qui peut se propager à l'estimation de l'intervalle sériel. [période d'incubation](#incubation) et du temps de génération ([Chen et al., 2022](https://www.nature.com/articles/s41467-022-35496-8/figures/2))

## D

[AVCI]{#dalys}
 Les années de vie corrigées de l'incapacité (AVCI) sont une mesure de la charge de morbidité. Plus précisément, elles mesurent les années de vie perdues en raison de la morbidité associée à la maladie. [Plus d'informations sur les AVCI](https://www.who.int/data/gho/indicator-metadata-registry/imr-details/158).

[Modèle déterministe]{#deterministic}
 Modèles qui auront toujours la même trajectoire pour des conditions initiales et des valeurs de paramètres données. Les exemples incluent les équations différentielles ordinaires et les équations aux différences.

[Transmission directe]{#direct}
 Les personnes sont infectées par contact direct avec d'autres personnes infectées. Les infections transmises par voie aérienne sont souvent modélisées comme des infections directement transmises, car elles nécessitent un contact étroit avec des personnes infectées pour réussir à se transmettre.

## E

[Nombre effectif de reproduction]{#effectiverepro}
 Numéro de reproduction effectif : Le numéro de reproduction effectif ou variable dans le temps ($Rt$) est similaire au [Nombre de reproduction de base](#basic) ($R0$), mais $Rt$ mesure le nombre de personnes infectées par une personne infectieuse lorsqu'une partie de la population a déjà été infectée. Pour en savoir plus sur la [étymologie de Nombre de reproduction par Sharma et al, 2023](https://wwwnc.cdc.gov/eid/article/29/8/22-1445_article).

<!-- ## F -->

## G

[Temps de génération]{#generationtime}
 Temps écoulé entre le début de la contagiosité d'un cas index et celle d'un cas secondaire. Ce délai doit toujours être positif.
La distribution du temps de génération est généralement estimée à partir des données relatives à l'épidémie. [intervalle sériel](#serialinterval) d'une infection ([Cori et al. 2017](https://royalsocietypublishing.org/doi/10.1098/rstb.2016.0371)).

[Taux de croissance]{#growth}
 Le taux de croissance exponentiel nous indique dans quelle mesure les cas augmentent ou diminuent au début d'une épidémie. Il nous donne une mesure de la vitesse de transmission, voir [Dushoff \& Park, 2021](https://royalsocietypublishing.org/doi/full/10.1098/rspb.2020.1556).

## H

[Immunité des troupeaux]{#herdimmunity}
Lorsqu'une partie suffisante de la population est immunisée contre l'infection, les individus sensibles sont protégés contre l'infection.
[Plus d'informations sur l'immunité collective](https://vaccineknowledge.ox.ac.uk/herd-immunity#What-is-herd-immunity).

## I

[Période d'incubation]{#incubation}
 La période d'incubation est le temps qui s'écoule entre le moment où l'on est infecté et l'apparition des symptômes.
[Plus d'informations sur la période d'incubation](https://en.wikipedia.org/wiki/Latent_period_\(epidemiology\)#Incubation_period).
Celle-ci peut être différente de la [période de latence](#latent) comme le montre la figure 4 de ([Xiang et al. (2021)](https://www.sciencedirect.com/science/article/pii/S2468042721000038#fig4)).
La relation entre la période d'incubation et le [intervalle sériel](#serialinterval) permet de définir le type de transmission de l'infection (symptomatique ou pré-symptomatique) ([Nishiura et al. (2020)](https://www.ijidonline.com/article/S1201-9712\(20\)30119-3/fulltext#gr2)).

[Transmission indirecte]{#indirect}
 Les infections à transmission indirecte sont transmises à l'homme par contact avec des vecteurs, des animaux ou un environnement contaminé. Les infections à transmission vectorielle, les zoonoses et les infections transmises par l'eau sont modélisées comme des infections à transmission indirecte.

[Conditions initiales]{#initial}
 In [ODEs](#ordinary) les conditions initiales sont les valeurs des variables d'état au début de la simulation du modèle (au temps 0). Par exemple, s'il y a un individu infectieux dans une population de 1000 personnes dans un modèle Susceptible-Infectieux-Récupéré, les conditions initiales sont les suivantes $S(0) = 999$, $I(0) = 1$, $R(0) = 0$.

[Période infectieuse]{#infectiousness}
: Également connue sous le nom de durée de la contagiosité. Période de temps entre le début et la fin de la période infectieuse. [virale infectieuse](#viralshedding).
La charge virale et la détection du virus infectieux sont les deux paramètres clés pour estimer l'infectiosité ([Puhach et al., 2022](https://www.nature.com/articles/s41579-022-00822-w) et [Hakki et al, 2022](https://www.thelancet.com/journals/lanres/article/PIIS2213-2600\(22\)00226-0/fulltext)(fig/infectiousness-covid19.jpg)).

<!-- ## J -->

<!-- ## K -->

## L

[Période de latence]{#latent}
 La période de latence est le temps qui s'écoule entre le moment où l'on est infecté et le moment où l'on commence à être contagieux.
Ce délai peut être différent du [période d'incubation](#incubation) comme le montre la figure 4 de ([Xiang et al, 2021](https://www.sciencedirect.com/science/article/pii/S2468042721000038#fig4))

## M

[Paramètres du modèle (ODE)]{#parsode}
 Les paramètres du modèle sont utilisés dans [l'équation différentielle ordinaire](#ordinary) pour décrire le flux entre les états pathologiques. Par exemple, un taux de transmission $\beta$ est un paramètre du modèle qui peut être utilisé pour décrire le flux entre les états sensibles et infectieux.

## N

[Interventions non pharmaceutiques]{#NPIs}
 Interventions non pharmaceutiques : Les interventions non pharmaceutiques (INP) sont des mesures mises en place pour réduire la transmission qui n'incluent pas l'administration de médicaments ou de vaccins. [Plus d'informations sur les NPI](https://www.gov.uk/government/publications/technical-report-on-the-covid-19-pandemic-in-the-uk/chapter-8-non-pharmaceutical-interventions).

## O

[Equations différentielles ordinaires]{#ordinary}
 Les équations différentielles ordinaires : Les équations différentielles ordinaires (EDO) peuvent être utilisées pour représenter le taux de changement d'une variable (par exemple, le nombre de personnes infectées) par rapport à une autre (par exemple, le temps). Consultez cette introduction aux [ODE](https://mathinsight.org/ordinary_differential_equation_introduction). Les EDO sont largement utilisées dans la modélisation des maladies infectieuses pour modéliser le flux d'individus entre différents états pathologiques.
 [Histoire naturelle de la maladie]{#naturalhistory}
: Désigne le développement d'une maladie du début à la fin, sans aucun traitement ni intervention. En effet, compte tenu de la nocivité d'une épidémie, des mesures de traitement ou d'intervention sont inévitables. Il est donc difficile que l'histoire naturelle d'une maladie ne soit pas influencée par les différents facteurs de couplage. ([Xiang et al, 2021](https://www.sciencedirect.com/science/article/pii/S2468042721000038))

## O

[Distribution de la progéniture]{#offspringdist}
 Distribution du nombre de cas secondaires causés par un individu infecté donné. ([Lloyd-Smith et al, 2005](https://www.nature.com/articles/nature04153), [Endo et al, 2020](https://wellcomeopenresearch.org/articles/5-67/v3))

## P

[(dynamique ou épidémique) Biais de phase]{#phasebias}
: tient compte de la sensibilité de la population au moment où les paires de transmission sont observées.
Il s'agit d'un type de biais d'échantillonnage. Il affecte les données rétrospectives et est lié à la phase de l'épidémie : pendant la phase de croissance exponentielle, les cas qui ont développé des symptômes récemment sont surreprésentés dans les données observées, tandis que pendant la phase de déclin, ces cas sont sous-représentés, ce qui conduit à l'estimation d'intervalles de délai plus courts et plus longs, respectivement. ([Park et al.](https://github.com/parksw3/epidist-paper))

<!-- ## Q -->

## R

[Délai d'établissement des rapports]{#reportingdelay}
 Délai de déclaration : Délai ou décalage entre le moment où un événement se produit (par exemple, l'apparition d'un symptôme) et le moment où il est signalé (par exemple, l'apparition d'un symptôme).[Lawless, 1994](https://www.jstor.org/stable/3315820)). Nous pouvons le quantifier en comparant la liste de référence avec ses versions successives ou en actualisant les comptes de cas agrégés ([Cori et al. 2017](https://royalsocietypublishing.org/doi/10.1098/rstb.2016.0371)).

## S

[Variables d'état]{#state}
 Les variables d'état d'un modèle représenté par [des équations différentielles ordinaires](#ordinary) sont les états pathologiques dans lesquels les individus peuvent se trouver, par exemple si les individus peuvent être sensibles, infectieux ou guéris, les variables d'état sont les suivantes $S$, $I$ et $R$. Il existe une équation différentielle ordinaire pour chaque variable d'état.

[Intervalle de série]{#serialinterval}
 Le délai entre l'apparition des symptômes d'un cas primaire et d'un cas secondaire.
Ce délai peut être négatif en cas d'infection pré-symptomatique.
Le plus souvent, la distribution de l'intervalle sériel d'une infection est utilisée pour estimer le délai d'apparition des symptômes. [temps de génération](#generationtime) ([(Cori et al., 2017)](https://royalsocietypublishing.org/doi/10.1098/rstb.2016.0371)).
La relation entre l'intervalle sériel et le [période d'incubation](#incubation) permet de définir le type de transmission de l'infection (symptomatique ou pré-symptomatique) ([Nishiura et al. (2020)](https://www.ijidonline.com/article/S1201-9712\(20\)30119-3/fulltext#gr2)).

[Modèle stochastique]{#stochastic}
 Modèle qui inclut un processus stochastique entraînant des variations dans les simulations du modèle pour les mêmes conditions initiales et valeurs de paramètres. Les exemples incluent les équations différentielles stochastiques et les modèles de processus de ramification. Pour plus de détails, voir [Allen (2017)](https://doi.org/10.1016/j.idm.2017.03.001).

## T

[(à droite) Troncature]{#truncation}
 Type de biais d'échantillonnage lié au processus de collecte des données. Il est dû au fait que seuls les cas qui ont été signalés peuvent être observés. Le fait de ne pas tenir compte de la troncature à droite pendant la phase de croissance d'une épidémie peut conduire à une sous-estimation du délai moyen ([Park et al.](https://github.com/parksw3/epidist-paper)).

<!-- ## U -->

## V

[Transmission vectorielle]{#vectorborne}
 Transmission vectorielle : La transmission vectorielle signifie qu'une infection peut être transmise d'un vecteur (par exemple, des moustiques) à l'homme. Le paludisme et la dengue sont des exemples de maladies à transmission vectorielle. L'Organisation mondiale de la santé dispose d'une [Fiche d'information sur les maladies à transmission vectorielle](https://www.who.int/news-room/fact-sheets/detail/vector-borne-diseases) avec des informations clés et une liste de ces maladies en fonction de leur vecteur.

[Excrétion virale]{#viralshedding}
 Le processus de libération d'un virus d'une cellule ou d'un corps dans l'environnement où il peut infecter d'autres personnes. ([Dictionnaire de Cambridge, 2023](https://dictionary.cambridge.org/us/dictionary/english/shedding))

<!-- ## W -->

<!-- ## X -->

<!-- ## Y -->

<!-- ## Z -->


