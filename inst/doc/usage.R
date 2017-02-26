## ----prepare_sample_environement, eval=FALSE-----------------------------
#  library(dplyr)     # piping
#  library(readr)     # better CSV handling
#  library(evaluator) # core evaluator toolkit
#  
#  # create default directories
#  if (!dir.exists("data")) dir.create("data")
#  if (!dir.exists("results")) dir.create("results")
#  
#  # copy sample files
#  file.copy(system.file("extdata", "domains.csv", package="evaluator"),
#            "data/")
#  file.copy(system.file("extdata", "qualitative_mappings.csv",
#                        package="evaluator"),
#            "data/")
#  file.copy(system.file("extdata", "risk_tolerances.csv", package="evaluator"),
#            "data/")
#  file.copy(system.file("survey", "survey.xlsx", package = "evaluator"),
#            "data/")

## ----import, eval=FALSE--------------------------------------------------
#  domains <-  readr::read_csv("data/domains.csv")
#  system.file("survey", "survey.xlsx", package = "evaluator") %>%
#    import_spreadsheet(., domains)

## ----validate, eval=FALSE------------------------------------------------
#  mappings <-  readr::read_csv("data/qualitative_mappings.csv")
#  qualitative_scenarios <- readr::read_csv("./data/qualitative_scenarios.csv")
#  capabilities <- readr::read_csv("./data/capabilities.csv")
#  validate_scenarios(qualitative_scenarios, capabilities, domains, mappings)

## ----encode, eval = FALSE------------------------------------------------
#  quantitative_scenarios <- encode_scenarios(qualitative_scenarios,
#                                             capabilities, mappings)

## ----simulate, eval = FALSE----------------------------------------------
#  simulation_results <- run_simulations(quantitative_scenarios,
#                                        simulation_count = 1000L)

## ----data_files, eval = FALSE, echo=FALSE--------------------------------
#  pacman::p_load(tidyr)
#  tibble::tribble(
#      ~`Data File`, ~Purpose,
#      'simulation_results.rda', 'Full details of each simulated scenario',
#      'scenario_summary.rda', 'Simulation results, summarized at the scenario level'
#      'domain_summary.rda', 'Simulation results, summarized at the domain level'
#  ) %>% pander::pander(., justify = "left")

## ----analyze, eval=FALSE-------------------------------------------------
#  # summarize
#  scenario_summary <- summarize_scenarios(results)
#  domain_summary <- summarize_domains(results, domains)
#  
#  # or to save the summary files directly to disk
#  summarize_all(simulation_results = simulation_results, domains = domains)
#  
#  # define risk tolerances
#  risk_tolerances <- system.file("extdata", "risk_tolerances.csv",
#                                 package="evaluator") %>% read_csv()
#  
#  # Explorer
#  explore_scenarios()
#  
#  # Sample Report
#  generate_report(input_directory, results_directory) %>% rstudio::viewer()

