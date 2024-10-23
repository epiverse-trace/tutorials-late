---
title: 'Contact matrices'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is a contact matrix?
- How are contact matrices estimated?
- How are contract matrices used?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Use the R package `socialmixr` to estimate a contact matrix
- Understand the different types of analysis contact matrices can be used for 
::::::::::::::::::::::::::::::::::::::::::::::::

<!-- ::::::::::::::::::::::::::::::::::::: prereq -->

<!-- ## Prerequisites -->



<!-- ::::::::::::::::::::::::::::::::: -->


## Introduction

Heterogeneity of contact patterns between different groups affects disease transmission. The rate of contact within and between groups can be presented in a contact matrix. In this tutorial we are going to learn how contact matrices can be used in different analyses and how the `{socialmixr}` package can be used to estimate contact matrices. 



``` r
library(socialmixr)
```


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

## The contact matrix

A contact matrix represents the amount of contact or mixing within and between subgroups. The subgroups are often age categories but can also be geographic areas or high/low risk groups. For example, a contact matrix representing the average number of contacts per day between children and adults could be:

$$
\begin{bmatrix}
2 & 2\\
1 & 3 
\end{bmatrix}
$$
In this example, we would use this to represent that children meet, on average, 2 other children and 2 adult per day (first row), and adults meet, on average, 1 child and 3 other adults per day (second row). We can use this kind of information to account for the role heterogeneity in contact plays in infectious disease transmission.


## Estimating contact matrices

Contact matrices can be estimated from surveys or contact data, or synthetic ones can be used. The POLYMOD survey measured contact patterns in 8 European countries using data on the location and duration of contacts reported by the study participants [(Mossong et al. 2008)](https://doi.org/10.1371/journal.pmed.0050074). [Prem et al. 2021](https://doi.org/10.1371/journal.pcbi.1009098) used the POLYMOD data within a Bayesian hierarchical model to project contact matrices for 177 other countries. 

The R package `{socialmixr}` contains functions which can estimate contact matrices from POLYMOD and other surveys. We can load the POLYMOD survey data :



``` r
polymod <- socialmixr::polymod
```

Then we can obtain the contact matrix for the age categories we want by specifying `age.limits`. 


``` r
contact_data <- contact_matrix(
  survey = polymod,
  countries = "United Kingdom",
  age.limits = c(0, 20, 40),
  symmetric = TRUE
)
```

``` output
Removing participants that have contacts without age information. To change this behaviour, set the 'missing.contact.age' option
```

``` r
contact_data
```

``` output
$matrix
      contact.age.group
         [0,20)  [20,40)      40+
  [1,] 7.883663 3.120220 3.063895
  [2,] 2.794154 4.854839 4.599893
  [3,] 1.565665 2.624868 5.005571

$demography
   age.group population proportion  year
      <char>      <num>      <num> <int>
1:    [0,20)   14799290  0.2454816  2005
2:   [20,40)   16526302  0.2741283  2005
3:       40+   28961159  0.4803901  2005

$participants
   age.group participants proportion
      <char>        <int>      <num>
1:    [0,20)          404  0.3996044
2:   [20,40)          248  0.2453017
3:       40+          359  0.3550940
```

**Note: although the contact matrix is not mathematically symmetric, it satisfies the condition that the total number of contacts of one group with another is the same as the reverse. For the mathematical explanation see [the corresponding section in the socialmixr documentation](https://epiforecasts.io/socialmixr/articles/socialmixr.html#symmetric-contact-matrices).**


::::::::::::::::::::::::::::::::::::: callout
### Why would a contact matrix be non-symmetric?

One of the arguments we gave the function `contact_matrix()` is `symmetric=TRUE`. This means that the total number of contacts of age group 1 with age group 2, should be the same as the total number of contacts of age group 2 and age group 1 (see the `socialmixr` [vignette](https://cran.r-project.org/web/packages/socialmixr/vignettes/socialmixr.html) for more detail). However, when contact matrices are estimated from surveys or other sources, the *reported* number of contacts may differ by age group resulting in a non-symmetric contact matrix because of uncertainty from using a limited sample of participants [(Prem et al 2021)](https://doi.org/10.1371/journal.pcbi.1009098). If `symmetric` is set to TRUE, the `contact_matrix()` function will internally use an average of reported contacts to ensure resulting total number of contacts are symmetric.
::::::::::::::::::::::::::::::::::::::::::::::::

The example above uses the POLYMOD survey. There are a number of surveys available in `socialmixr`, to list the available surveys use `list_surveys()`. To download a survey, we can use `get_survey()`


``` r
zambia_sa_survey <- get_survey("https://doi.org/10.5281/zenodo.3874675")
```



::::::::::::::::::::::::::::::::::::: challenge 

## Zambia contact matrix

After downloading the survey, generate a symmetric contact matrix for Zambia using the following age bins:

+ [0,15)
+ 20+

:::::::::::::::::::::::: solution 


``` r
contact_data_zambia <- contact_matrix(
  survey = zambia_sa_survey,
  age.limits = c(0, 20),
  symmetric = TRUE
)
```

``` output
Removing participants without age information. To change this behaviour, set the 'missing.participant.age' option
```

``` output
Removing participants that have contacts without age information. To change this behaviour, set the 'missing.contact.age' option
```

``` r
contact_data_zambia
```

``` output
$matrix
      contact.age.group
         [0,20)      20+
  [1,] 3.643137 2.282138
  [2,] 1.795546 2.542346

$demography
   age.group population proportion  year
      <char>      <num>      <num> <int>
1:    [0,20)   28813173  0.4403347  2010
2:       20+   36621532  0.5596653  2010

$participants
   age.group participants proportion
      <char>        <int>      <num>
1:    [0,20)          255 0.07535461
2:       20+         3129 0.92464539
```
:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::


## Analyses with contact matrices

Contact matrices can be used in a wide range of epidemiological analyses, they can be used:

+ to calculate the basic reproduction number while accounting for different rates of contacts between age groups [(Funk et al. 2019)](https://doi.org/10.1186/s12916-019-1413-7),
+ to calculate final size of an epidemic, see the R package `{finalsize}`,
+ to assess the impact of interventions finding the relative change between pre and post intervention contact matrices to calculate the relative difference in $R_0$ [(Jarvis et al. 2020)](https://doi.org/10.1186/s12916-020-01597-8),
+ and in mathematical models to account for group specific contact patterns (see next section.)

::::::::::::::::::::::::::::::::::::: callout
## Normalisation

There are times when we need to change the scale of our contact matrices e.g. to compare matrices to model projected matrices [(Prem et al. 2021)](https://doi.org/10.1371/journal.pcbi.1009098) the entries need to be on the same scale.

Normalisation means converting a value to be between 0 and 1.To normalise a matrix we scale the matrix so that the largest eigenvalue is 1. This transformation scales the entries between 0 and 1 but preserves the relative differences between the entries. To perform this normalisation we divide all entries of the matrix by the largest eigenvalue of the matrix.


``` r
contact_matrix <- t(contact_data$matrix)
contact_matrix <- contact_matrix / max(eigen(contact_matrix)$values)
contact_matrix
```

``` output
                 
contact.age.group      [,1]      [,2]      [,3]
          [0,20)  0.6681250 0.2367991 0.1326870
          [20,40) 0.2644325 0.4114381 0.2224524
          40+     0.2596591 0.3898319 0.4242123
```


::::::::::::::::::::::::::::::::::::::::::::::::

### In mathematical models

Consider the SIR model where individuals are categorized as either susceptible $S$, infected but not yet infectious $E$, infectious $I$ or recovered $R$. The schematic below shows the processes which describe the flow of individuals between the disease states $S$, $I$ and $R$ and the key parameters for each process.

<!--html_preserve--><div class="grViz html-widget html-fill-item" id="htmlwidget-3827d1514a723c9d4089" style="width:504px;height:504px;"></div>
<script type="application/json" data-for="htmlwidget-3827d1514a723c9d4089">{"x":{"diagram":"digraph {\n\n  # graph statement\n  #################\n  graph [layout = dot,\n         rankdir = LR,\n         overlap = true,\n         fontsize = 10]\n\n  # nodes\n  #######\n  node [shape = square,\n       fixedsize = true\n       width = 1.3]\n\n       S\n       I\n       R\n\n  # edges\n  #######\n  S -> I [label = \" infection \n(transmission rate &beta;)\"]\n  I -> R [label = \" recovery \n(recovery rate &gamma;)\"]\n\n}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

The [differential equations](../learners/reference.md#ordinary) below describe how individuals move from one state to another [(Bjørnstad et al. 2020)](https://doi.org/10.1038/s41592-020-0822-z).


$$
\begin{aligned}
\frac{dS}{dt} & = - \beta S I \\
\frac{dI}{dt} &= \beta S I - \gamma I \\
\frac{dR}{dt} &=\gamma I \\
\end{aligned}
$$
To add age structure to our model, we need to add additional equations for the infection states $S$, $I$ and $R$ for each age group $i$. If we want to assume that there is heterogeneity in contacts between age groups then we must adapt the transmission term $\beta SI$ to include the contact matrix $C$ as follows :

$$ \beta S_i \sum_j C_{i,j} I_j. $$ 
Susceptible individuals in age group $i$ become infected dependent on their rate of contact with individuals in each age group. For each disease state ($S$, $E$, $I$ and $R$) and age group ($i$), we have a differential equation describing the rate of change with respect to time.  

$$
\begin{aligned}
\frac{dS_i}{dt} & = - \beta S_i \sum_j C_{i,j} I_j \\
\frac{dI_i}{dt} &= \beta S_i\sum_j C_{i,j} I_j - \gamma I_i \\
\frac{dR_i}{dt} &=\gamma I_i \\
\end{aligned}
$$

::::::::::::::::::::::::::::::::::::: callout
### Check the dimension of $\beta$

In the SIR model without age structure the rate of contact is part of the transmission rate $\beta$, where as in the age-structured model we have separated out the rate of contact, hence the transmission rate $\beta$ in the age structured model will have a different value.

::::::::::::::::::::::::::::::::::::::::::::::::

We can use contact matrices from `socialmixr` with mathematical models in the R package `{epidemics}`. See the tutorial [Simulating transmission](../episodes/simulating-transmission.md) for examples and an introduction to `epidemics`.


### Contact groups

In the example above the dimension of the contact matrix will be the same as the number of age groups i.e. if there are 3 age groups then the contact matrix will have 3 rows and 3 columns. Contact matrices can be used for other groups as long as the dimension of the matrix matches the number of groups.

For example, we might have a meta population model with two geographic areas. Then our contact matrix would be a 2 x 2 matrix with entries representing the contact between and within the geographic areas.


## Summary 

In this tutorial, we have learnt the definition of the contact matrix, how they are estimated and how to access social contact data from `socialmixr`. In the next tutorial, we will learn how to use the R package `{epidemics}` to generate disease trajectories from mathematical models with contact matrices from `socialmixr`.

::::::::::::::::::::::::::::::::::::: keypoints 

- `socialmixr` can be used to estimate contact matrices from survey data
- Contact matrices can be used in different types of analyses

::::::::::::::::::::::::::::::::::::::::::::::::