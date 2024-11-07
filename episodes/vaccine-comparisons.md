---
title: 'Vaccine comparisons'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What questions will this lesson cover?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Objective 1
- Objective 2

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: prereq

+ Complete tutorials [Simulating transmission](../episodes/simulating-transmission.md), [Modelling interventions](../episodes/modelling-interventions.md) and [Comparing public health outcomes of interventions](../episodes/compare-interventions.md). 

Learners should familiarise themselves with following concept dependencies before working through this tutorial: 

**Outbreak response** : [Intervention types](https://www.cdc.gov/nonpharmaceutical-interventions/).
:::::::::::::::::::::::::::::::::


## Introduction

Introductory text

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

Inline instructor notes can help inform instructors of timing challenges
associated with the lessons. They appear in the "Instructor View".

READ THESE LINES AND ERASE:

The Workbench-related sections that the developer must keep are:

- YAML on top
- Questions
- Objectives
- Keypoints

The Epiverse-TRACE sections that we encourage to keep are:

- Prerequisites
- Introduction

Take a look to the Contributing.md file for more writing guidelines.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


## Section header

Lesson content

::::::::::::::::::::::::::::::::::::: challenge 

## Challenge 1 : can the learner run existing code

Load contact and population data from socialmixr::polymod

```r
polymod <- socialmixr::polymod
contact_data <- socialmixr::contact_matrix(
  polymod,
  countries = "United Kingdom",
  age.limits = c(0, 20, 40),
  symmetric = TRUE
)
contact_data
```

:::::::::::::::::::::::: solution 

## Output
 
```{r polymod_uk, echo = FALSE}
polymod <- socialmixr::polymod
contact_data <- socialmixr::contact_matrix(
  polymod,
  countries = "United Kingdom",
  age.limits = c(0, 20, 40),
  symmetric = TRUE
)
contact_data
```


:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::


## Section header

Lesson content

::::::::::::::::::::::::::::::::::::: callout
## Explainer
Add additional maths (or epi) content for novice learners

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: challenge 

## Challenge 2 : edit code/answer a question

Load contact and population data for Poland from socialmixr::polymod using the following age bins:

+ [0,15)
+ [15, 50)
+ 50 +

:::::::::::::::::::::::: solution 

```{r polymod_poland}
polymod <- socialmixr::polymod
contact_data <- socialmixr::contact_matrix(
  polymod,
  countries = "Poland",
  age.limits = c(0, 15, 50),
  symmetric = TRUE
)
contact_data
```
:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::





::::::::::::::::::::::::::::::::::::: keypoints 

- Summarise the key points of the lesson using bullet points


::::::::::::::::::::::::::::::::::::::::::::::::
