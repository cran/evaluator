% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{mc_quantitative_scenarios}
\alias{mc_quantitative_scenarios}
\title{Quantified information risk scenarios}
\format{
A dataset of quantified risk scenarios, with parameters
describing the distribution of each input.

\describe{
\item{scenario_id}{id of the scenario, primary key}
\item{scenario_description}{full text description of the risk scenario}
\item{tcomm}{description of the threat community}
\item{domain_id}{domain id}
\item{control_descriptons}{named list of the text description of controls involved}
\item{scenario}{\code{\link{tidyrisk_scenario}} objects}
}
}
\source{
This is hypothetical information. Any similarity to any other
entity is completely coincidental.
}
\usage{
mc_quantitative_scenarios
}
\description{
A sample set of quantified information security risk scenarios for the
demonstration (and artificial) MetroCare information security program.
}
\keyword{datasets}
