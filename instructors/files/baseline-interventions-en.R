# nolint start

# load packages
library(epidemics)
library(socialmixr)
library(tidyverse)

# load survey data
survey_data <- socialmixr::polymod

# generate contact matrix
cm_results <- socialmixr::contact_matrix(
  survey = survey_data,
  countries = "United Kingdom",
  age.limits = c(0, 15, 65),
  symmetric = TRUE
)

# transpose contact matrix
cm_matrix <- t(cm_results$matrix)

# prepare the demography vector
demography_vector <- cm_results$demography$population
names(demography_vector) <- rownames(cm_matrix)

# initial conditions: one in every 1 million is infected
initial_i <- 1e-6
initial_conditions <- c(
  S = 1 - initial_i,
  E = 0,
  I = initial_i,
  R = 0,
  V = 0
)

# build for all age groups
initial_conditions <- base::rbind(
  initial_conditions,
  initial_conditions,
  initial_conditions
)
rownames(initial_conditions) <- rownames(cm_matrix)

# prepare the population to model as affected by the epidemic
uk_population <- epidemics::population(
  name = "UK",
  contact_matrix = cm_matrix,
  demography_vector = demography_vector,
  initial_conditions = initial_conditions
)

# time periods
preinfectious_period <- 4.0
infectious_period <- 5.5
basic_reproduction <- 2.7

# rates
infectiousness_rate <- 1.0 / preinfectious_period
recovery_rate <- 1.0 / infectious_period
transmission_rate <- basic_reproduction * recovery_rate

# run baseline simulation with no intervention
output_baseline <- epidemics::model_default(
  population = uk_population,
  transmission_rate = transmission_rate,
  infectiousness_rate = infectiousness_rate,
  recovery_rate = recovery_rate,
  time_end = 300, increment = 1.0
)

output_baseline

# challenge ------------------------

# Run this visualization of the baseline model using ggplot2
# Then share with the tutor

output_baseline %>%
  filter(compartment == "infectious") %>%
  ggplot(aes(
    x = time,
    y = value,
    linetype = demography_group,
    colour = compartment
  )) +
  geom_line()

# ----------------------------------

# nolint end
