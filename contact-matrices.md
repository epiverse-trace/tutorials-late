---
title: 'Contact matrices'
teaching: 40
exercises: 10
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is a contact matrix?
- How are contact matrices estimated?
- How are contact matrices used in epidemiological analysis?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Use the R package `socialmixr` to estimate a contact matrix
- Understand the different types of analysis contact matrices can be used for 
::::::::::::::::::::::::::::::::::::::::::::::::

<!-- ::::::::::::::::::::::::::::::::::::: prereq -->

<!-- ## Prerequisites -->



<!-- ::::::::::::::::::::::::::::::::: -->


## Introduction

Some groups of individuals have more contacts than others; the average schoolchild has many more daily contact than the average elderly person, for example. This heterogeneity of contact patterns between different groups can affect disease transmission, because certain groups are more likely to transmit to others within that group, as well as to other groups. The rate at which individuals within and between groups make contact with others can be summarised in a contact matrix. 

In this tutorial we are going to learn how contact matrices can be used in different analyses, how the package `{contactsurveys}` can be used to access survey data from different countries, and how the `{socialmixr}` package can be used to estimate contact matrices. We'll use `{dplyr}`, `{ggplot2}` and the pipe `%>%` to connect some of their functions, so let's also call to the `{tidyverse}` package:



``` r
library(contactsurveys)
library(socialmixr)
library(wpp2024)
library(tidyverse)
```

## The contact matrix

The basic contact matrix represents the amount of contact or mixing within and between different subgroups of a population. The subgroups are often age categories but can also be:

- Geographic areas (e.g., different regions or countries)
- Risk groups (e.g., high/low risk occupations)
- Social settings (e.g., household, workplace, school)

For example, a hypothetical contact matrix representing the average number of contacts per day between children and adults could be:

$$
\begin{bmatrix}
2 & 2\\
1 & 3 
\end{bmatrix}
$$

In this example, we would use this to represent that children meet, on average, 2 other children and 2 adult per day (first row), and adults meet, on average, 1 child and 3 other adults per day (second row). We can use this kind of information to account for the role that heterogeneity in contact plays in infectious disease transmission.

::::::::::::::::::::::::::::::::::::: callout

### A Note on Notation
In a contact matrix, the entry $C[i,j]$, at row $i$ and column $j$:

-  Represents the average number of contacts an individual in group $i$ has with individuals in group $j$
- This  is calculated by dividing the total number of contacts between groups $i$ and $j$ by the size of group $i$

::::::::::::::::::::::::::::::::::::::::::::::::

## Using `socialmixr`

Contact matrices are commonly estimated from studies that use diaries to record interactions. For example, the POLYMOD survey measured contact patterns in 8 European countries using data on the location and duration of contacts reported by the study participants [(Mossong et al. 2008)](https://doi.org/10.1371/journal.pmed.0050074).

The R package `{socialmixr}` contains functions which can estimate contact matrices from POLYMOD and other surveys. We can download and load the POLYMOD survey data directly from Zenodo using `{contactsurveys}` and `{socialmixr}`:


``` r
survey_files <- contactsurveys::download_survey(
  survey = "https://doi.org/10.5281/zenodo.3874557",
  verbose = FALSE
)

survey_load <- socialmixr::load_survey(files = survey_files)
```

::::::::::::::::::::::::::::::::::::: callout

### Inspect available countries

A single survey file can contain data from multiple countries. You can inspect the available countries with:


``` r
levels(survey_load$participants$country)
```

``` output
[1] "Belgium"        "Finland"        "Germany"        "Italy"         
[5] "Luxembourg"     "Netherlands"    "Poland"         "United Kingdom"
```

::::::::::::::::::::::::::::::::::::::::::::::::

We obtain the contact matrix for the United Kingdom — passing `countries = "United Kingdom"` to select data from the intended country, `age_limits` to define age categories, and `survey_pop` to supply the population structure from `{wpp2024}` required by `{socialmixr}`.


``` r
data(popAge1dt, package = "wpp2024")

uk_pop <- popAge1dt %>%
  dplyr::filter(name == "United Kingdom", year == 2020) %>%
  dplyr::select(lower.age.limit = age, population = pop) %>%
  dplyr::mutate(population = population * 1000)

contacts_byage <- socialmixr::contact_matrix(
  survey = survey_load,
  countries = "United Kingdom",
  age_limits = c(0, 20, 40),
  symmetric = TRUE,
  survey_pop = uk_pop
)
contacts_byage
```

``` output
$matrix
          contact.age.group
age.group    [0,20)  [20,40) [40,Inf)
  [0,20)   7.883663 3.114224 3.230298
  [20,40)  2.799168 4.854839 4.873347
  [40,Inf) 1.507146 2.529653 5.005571

$demography
   age.group population proportion  year
      <char>      <num>      <num> <int>
1:    [0,20)   15842062  0.2349693    NA
2:   [20,40)   17625140  0.2614159    NA
3:  [40,Inf)   33954633  0.5036148    NA

$participants
   age.group participants proportion
      <char>        <int>      <num>
1:    [0,20)          404  0.3996044
2:   [20,40)          248  0.2453017
3:  [40,Inf)          359  0.3550940
```

### Symmetric contact matrices

Although the contact matrix `contacts_byage$matrix` is not itself mathematically symmetric, it satisfies the condition that the total number of contacts of one group with another is the same as the reverse. 

In other words:
`contacts_byage$matrix[j,i]*contacts_byage$demography$proportion[j] = contacts_byage$matrix[i,j]*contacts_byage$demography$proportion[i]`.


``` r
contacts_byage$matrix * contacts_byage$demography$population
```

``` output
          contact.age.group
age.group     [0,20)  [20,40)  [40,Inf)
  [0,20)   124893484 49335724  51174588
  [20,40)   49335724 85567212  85893423
  [40,Inf)  51174588 85893423 169962327
```

For the mathematical explanation, see the worked example below.

::::::::::::::::::: spoiler

### Worked example

Recall the hypothetical contact matrix from earlier, representing the average number of contacts per day between children and adults:

$$
C =
\begin{bmatrix}
2 & 2\\
1 & 3
\end{bmatrix}
$$

i.e. a child has, on average, 2 contacts with other children and 2 contacts with adults per day; an adult has, on average, 1 contact with children and 3 contacts with other adults per day. Suppose the child population is $N_{child} = x$ and the adult population is $N_{adult} = 3x$.

To get the total number of contacts, we redistribute the average number of contacts by the population size per group: $T_{ij} = m_{ij} N_i$

$$
T =
\begin{bmatrix}
2 \times x & 2 \times x\\
1 \times 3x & 3 \times 3x
\end{bmatrix}
=
\begin{bmatrix}
2x & 2x\\
3x & 9x
\end{bmatrix}
$$

Conceivably, the total number of contacts should be the same in both directions, i.e. $T_{1,2} = T_{2,1}$. Here $T_{1,2} = 2x$ but $T_{2,1} = 3x$: they disagree, so this toy example is *not* reciprocal — exactly the situation described above, where sampling variation means these totals usually don't match exactly.

$T_{1,2}$ and $T_{2,1}$ are two different, noisy "measurements" of the same underlying number of contact events between children and adults — one reported from the child side, one from the adult side. Neither alone is more trustworthy than the other. Just as we would average repeated measurements of a quantity to approximate its true value, we pool the two totals and take their mean:

$$
\frac{T_{1,2}+T_{2,1}}{2} = \frac{2x+3x}{2} = 2.5x
$$

This pooled value, $2.5x$, is our best single estimate of the true (symmetric) total number of contacts between the two groups — the same value regardless of which direction we started from. To turn it back into a per-capita rate, we divide by the population size of the *reporting* group for each direction:

$$
m'_{1,2} = \frac{2.5x}{N_{child}} = \frac{2.5x}{x} = 2.5 \qquad\qquad m'_{2,1} = \frac{2.5x}{N_{adult}} = \frac{2.5x}{3x} = \frac{5}{6}
$$

At the level of total contacts, this gives the symmetric matrix

$$
T' =
\begin{bmatrix}
2x & 2.5x\\
2.5x & 9x
\end{bmatrix}
$$

and, converted back to per-capita rates, the symmetrized contact matrix

$$
C' =
\begin{bmatrix}
2 & 2.5\\
5/6 & 3
\end{bmatrix}
$$

This pool-and-redistribute procedure is expressed as a single formula in [the corresponding section in the `socialmixr` documentation](https://epiforecasts.io/socialmixr/articles/socialmixr.html#symmetric-contact-matrices).

:::::::::::::::::::

::::::::::::::::::::::::::::::::::::: callout

### Why would a contact matrix be non-symmetric?

One of the arguments we gave the function `contact_matrix()` is `symmetric=TRUE`. This ensures that the total number of contacts from one group to another is equal to the total from the second group back to the first (see the `socialmixr` [vignette](https://cran.r-project.org/web/packages/socialmixr/vignettes/socialmixr.html) for more detail). 

However, when contact matrices are estimated from surveys or other sources, the *reported* number of contacts may differ by age group for several reasons:

- Recall bias: Different age groups may have different abilities to remember and report contacts accurately
- Reporting bias: Some groups may systematically over- or under-report their contacts
- Sampling uncertainty: Limited sample sizes can lead to statistical variations
[(Prem et al. 2021)](https://doi.org/10.1371/journal.pcbi.1009098)

If `symmetric` is set to TRUE, the `contact_matrix()` function will internally use an average of reported contacts to ensure the resulting total number of contacts are symmetric.

::::::::::::::::::::::::::::::::::::::::::::::::

## Find more surveys by DOI

The example above uses the POLYMOD survey. Other surveys are available in the [Zenodo Social Contact Data community](https://zenodo.org/communities/social_contact_data/). 

To use a different survey, first identify its DOI. Browse available surveys in the [Zenodo Social Contact Data community](https://zenodo.org/communities/social_contact_data/), or list them programmatically from `contactsurveys::list_surveys()`:


``` r
library(contactsurveys)
library(tidyverse)

# Get URL for Zambia contact survey data from {contactsurveys}
contactsurveys::list_surveys() %>%
  dplyr::filter(stringr::str_detect(title, "Zambia")) %>%
  dplyr::pull(url)
```

``` output
[1] "https://doi.org/10.5281/zenodo.3874675"
```

Then download and load it with `contactsurveys::download_survey()` and `socialmixr::load_survey()`. Here we use the Zambia and South Africa contact survey:


``` r
# Download and load the contact survey data for Zambia from Zenodo
survey_files_zambia <- contactsurveys::download_survey(
  survey = "https://doi.org/10.5281/zenodo.3874675",
  verbose = FALSE
)

survey_load_zambia <- socialmixr::load_survey(files = survey_files_zambia)
```


::::::::::::::::::::::::::::::::::::: challenge 

## Zambia contact matrix

The R package {socialmixr} contains functions which can estimate contact matrices from POLYMOD and other surveys. Outputs include demographic information like population size and number of participants in the study. Using {socialmixr}: 

+ Get access to the survey from Zambia. 
+ Generate a symmetric contact matrix for Zambia using the following age bins:

    + [0,20)
    + 20+

+ Get access to the vector of `population` size per age bin from the `demography` dataset inside the contact matrix output.

::::::::::::::::::::: hint

The survey object `survey_load_zambia` contains data from two countries. If you need to estimate the social contact matrix from data of the specific country of Zambia, identify what argument in `socialmixr::contact_matrix()` you need for this.


``` r
# Inspect the countries within the survey object
levels(survey_load_zambia$participants$country)
```

``` output
[1] "South Africa" "Zambia"      
```

Similar to the code above, to access vector values within a dataframe, you can use the dollar-sign operator: `$`

:::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::: instructor 


``` r
data(popAge1dt, package = "wpp2024")

zambia_pop <- popAge1dt %>%
  dplyr::filter(name == "Zambia", year == 2020) %>%
  dplyr::select(lower.age.limit = age, population = pop) %>%
  dplyr::mutate(population = population * 1000)

# Generate the contact matrix for Zambia only
contacts_byage_zambia <- socialmixr::contact_matrix(
  survey = survey_load_zambia,
  countries = "Zambia", # key argument
  age_limits = c(0, 20),
  symmetric = TRUE,
  survey_pop = zambia_pop
)
```

``` warning
Warning: Survey contains multiple observations per participant (4531 rows, 3576 unique
participants).
• Results will aggregate across all observations.
ℹ Use `filter` to select by "Building_id".
```

``` r
# Print the contact matrix for Zambia only
contacts_byage_zambia
```

``` output
$matrix
          contact.age.group
age.group    [0,20) [20,Inf)
  [0,20)   3.766393 1.560562
  [20,Inf) 1.840187 2.642584

$demography
   age.group population proportion  year
      <char>      <num>      <num> <int>
1:    [0,20)   10460632  0.5411123    NA
2:  [20,Inf)    8871089  0.4588877    NA

$participants
   age.group participants proportion
      <char>        <int>      <num>
1:    [0,20)          244 0.08531469
2:  [20,Inf)         2616 0.91468531
```

``` r
# Print the vector of population size for {epidemics}
contacts_byage_zambia$demography$population
```

``` output
[1] 10460632  8871089
```
:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: callout

## Synthetic contact matrices

Contact matrices can be estimated from data obtained from diary (such as POLYMOD), survey or contact data, or synthetic ones can be used. [Prem et al. 2021](https://doi.org/10.1371/journal.pcbi.1009098) used the POLYMOD data within a Bayesian hierarchical model to project contact matrices for 177 other countries.

::::::::::::::::::::::::::::::::::::::::::::::::


## Analyses with contact matrices

Contact matrices can be used in a wide range of epidemiological analyses, they can be used:

+ to calculate the basic reproduction number while accounting for different rates of contacts between age groups [(Funk et al. 2019)](https://doi.org/10.1186/s12916-019-1413-7),
+ to calculate final size of an epidemic, as in the R package `{finalsize}`,
+ to assess the impact of interventions finding the relative change between pre and post intervention contact matrices to calculate the relative difference in $R_0$ [(Jarvis et al. 2020)](https://doi.org/10.1186/s12916-020-01597-8),
+ and in mathematical models of transmission within a population, to account for group-specific contact patterns.


However, all of these applications require us to perform some additional calculations using the contact matrix. Specifically, there are two main calculations we often need to do:

### 1. Convert contact matrix into expected number of secondary cases

If contacts vary between groups, then the average number of secondary cases won't be equal simply to the average number of contacts multiplied by the probability of transmission-per-contact. This is because the average amount of transmission in each generation of infection isn't just a matter of whom a group came into contact with; it's about whom *their contacts* subsequently come into contact with. 

The function `r_eff()` in the package `{finalsize}` can perform this conversion, taking a contact matrix, demography and proportion susceptible and converting it into an estimate of the average number of secondary cases generated by a typical infectious individual (i.e. the effective reproduction number).

### 2. Convert contact matrix into contact rates

Whereas a contact matrix gives the average number of contacts that one groups makes with another, epidemic dynamics in different groups depend on the rate at which one group infects another. We therefore need to scale the rate of interaction between different groups (i.e. the number of contacts per unit time) to get the rate of transmission. 

However, we need to be careful that we are defining transmission to and from each group correctly in any model. Specifically, the entry $(i,j)$ in a mathematical model contact matrix represents contacts of group $i$ with group $j$. But if we want to know the rate at which a group $i$ are getting infected, then we want to multiply the number of contacts of susceptibles in group $i$ ($S_i$) with group $j$ ($C[i,j]$) with the proportion of those contacts that are infectious ($I_j/N_j$), and the transmission risk per contact ($\beta$).

::::::::::::::::::::::::::::::::::::: callout

### Why we transpose the contact matrix to get contact rates

Recall from **A Note on Notation** above that entry $C[i,j]$ of the matrix from `socialmixr::contact_matrix()` is read from the participant's side: the average number of contacts a participant in group $i$ reports having with people in group $j$.

To convert this into a contact *rate*, we read the matrix the other way round: "susceptibles in group $i$ ($S_i$), *contacted by* group $j$". That's the same contact seen from the susceptible side rather than the reporting side — group $j$ is doing the contacting, group $i$ is being exposed. In other words, the entry we need at position $(i,j)$ is the reported contact at `socialmixr`'s position $(j,i)$: the two conventions are transposes of each other.

To go from one convention to the other, we transpose the matrix:

```r
contacts_byage_matrix <- t(contacts_byage$matrix)
```

This is the matrix used as $C_{i,j}$ in $\beta S_i \sum_j C_{i,j} I_j/N_j$ below.

::::::::::::::::::::::::::::::::::::::::::::::::

### In mathematical models

Consider the SIR model where individuals are categorized as either susceptible $S$,  infected $I$ and recovered $R$. The schematic below shows the processes which describe the flow of individuals between the disease states $S$, $I$ and $R$ and the key parameters for each process.

```mermaid
flowchart LR
    accTitle: SIR compartmental model
    accDescr: Three compartments: S (Susceptible), I (Infectious), R (Recovered). Transitions: S to I by infection at transmission rate beta; I to R by recovery at rate gamma.
    S -->|"infection<br>(transmission rate &beta;)"| I
    I -->|"recovery<br>(recovery rate &gamma;)"| R
```

The [differential equations](../learners/reference.md#ordinary) below describe how individuals move from one state to another [(Bjørnstad et al. 2020)](https://doi.org/10.1038/s41592-020-0822-z).


$$
\begin{aligned}
\frac{dS}{dt} & = - \beta S I /N \\
\frac{dI}{dt} &= \beta S I /N - \gamma I \\
\frac{dR}{dt} &=\gamma I \\
\end{aligned}
$$

To add age structure to our model, we need to add additional equations for the infection states $S$, $I$ and $R$ for each age group $i$. If we want to assume that there is heterogeneity in contacts between age groups then we must adapt the transmission term $\beta SI$ to include the contact matrix $C$ as follows:

$$ \beta S_i \sum_j C_{i,j} I_j/N_j. $$ 

Susceptible individuals in age group $i$ become infected dependent on their rate of contact with individuals in each age group. For each disease state ($S$,  $I$ and $R$) and age group ($i$), we have a differential equations describing the rate of change with respect to time.  

$$
\begin{aligned}
\frac{dS_i}{dt} & = - \beta S_i \sum_j C_{i,j} I_j/N_j \\
\frac{dI_i}{dt} &= \beta S_i\sum_j C_{i,j} I_j/N_j - \gamma I_i \\
\frac{dR_i}{dt} &=\gamma I_i \\
\end{aligned}
$$

## Summary 

In this tutorial, we have learnt the definition of the contact matrix, how they are estimated and how to access social contact data using `{contactsurveys}` and `{socialmixr}`. In the next tutorial, we will learn how to use the R package `{epidemics}` to generate disease trajectories from mathematical models, with contact matrices using `socialmixr`.

::::::::::::::::::::::::::::::::::::: keypoints 

- Contact matrices quantify the mixing patterns between different population groups
- `socialmixr` provides tools to estimate contact matrices from survey data
- Contact matrices can be used in various epidemiological analyses, from calculating $R_0$ to modeling interventions

::::::::::::::::::::::::::::::::::::::::::::::::
