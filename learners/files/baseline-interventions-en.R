# nolint start

# load packages
library(epidemics)
library(socialmixr)
library(contactsurveys)
library(tidyverse)

# load survey data
survey_files <- contactsurveys::download_survey(
  survey = "https://doi.org/10.5281/zenodo.3874557",
  verbose = FALSE
)
survey_load <- socialmixr::load_survey(files = survey_files)

data(popAge1dt, package = "wpp2024")

uk_pop <- popAge1dt %>%
  dplyr::filter(name == "United Kingdom", year == max(year)) %>%
  dplyr::select(lower.age.limit = age, population = pop) %>%
  dplyr::mutate(population = population * 1000)

# generate contact matrix
cm_results <- socialmixr::contact_matrix(
  survey = survey_load,
  countries = "United Kingdom",
  age_limits = c(0, 15, 65),
  symmetric = TRUE,
  survey_pop = uk_pop
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
