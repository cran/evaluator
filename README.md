Evaluator README
================
David F. Severski

-   [Summary](#summary)
-   [Background](#background)
-   [How to Use](#how-to-use)
    -   [Instructions](#instructions)
        -   [Prepare the Environment](#prepare-the-environment)
        -   [Define Your Security Domains](#define-your-security-domains)
        -   [Define Your Controls and Risk Scenarios](#define-your-controls-and-risk-scenarios)
        -   [Import the Scenarios](#import-the-scenarios)
        -   [Run the Simulations](#run-the-simulations)
        -   [Analyze the Results](#analyze-the-results)
    -   [Advanced Customization](#advanced-customization)
-   [Where to Go From Here](#where-to-go-from-here)
-   [Contributing](#contributing)
-   [License](#license)

<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/davidski/evaluator.svg?branch=master)](https://travis-ci.org/davidski/evaluator) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/davidski/evaluator?branch=master&svg=true)](https://ci.appveyor.com/project/davidski/evaluator) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/evaluator)](https://cran.r-project.org/package=evaluator) ![downloads](http://cranlogs.r-pkg.org/badges/grand-total/evaluator)

> NOTE: This README is out of date with the MASTER (development) version of Evaluator. Running the dev version (via `devtools::install_github("davidski/evaluator")` is required for current R installation and highly suggested for a better experience. Please view the usage vignette (`vignette("usage")`) after installation for a walk through guide. Updates to this README are coming!

Summary
=======

<img alt="Evaluator Logo" title="Evaluator" src="inst/rmd/img/evaluator_logo.jpg" width="100" style="float:right;width:100px;"/>

Evaluator is an open source information security strategic risk analysis toolkit. Based on the OpenFAIR [taxonomy](https://www2.opengroup.org/ogsys/catalog/C13K) and risk assessment [standard](https://www2.opengroup.org/ogsys/catalog/C13G), Evaluator empowers an organization to perform a quantifiable, repeatable, and data-driven review of its security program.

Three sample outputs of this toolkit are available:

1.  A detailed risk analysis template, located at [RPubs](http://rpubs.com/davidski/evaluator_risk_analysis)
2.  A one page risk dashboard, also located at [RPubs](http://rpubs.com/davidski/evaluator_risk_dashboard)
3.  A demonstration copy of [Scenario Explorer](https://davidski.shinyapps.io/scenario_explorer)

Background
==========

The first iterations of Evaluator were created as a part of a major healthcare organization's decision to shift its already mature risk assessment program from reliance on qualitative labels to a quantitative model that would support more precise comparison of competing projects. This organization was able to use statistical sampling to gain greater insight into its information risks, to meet HIPAA compliance obligations and to provide manager to board level business leaders with the data needed to drive decision making.

Since its creation, versions of Evaluator have been deployed both inside and outside the healthcare field.

How to Use
==========

The Evaluator toolkit consists of a series of processes implemented in the [R language](https://www.r-project.org/). Starting from an Excel workbook, risk data is imported and run through a simulation model to estimate the expected losses for each scenario. The results of these simulations are used to create a detailed analysis and a formal risk report. A starter analysis report, overview dashboard and sample [Shiny](https://shiny.rstudio.com/) application are all included in the toolkit.

Evaluator takes a domain-driven and framework-independent approach to strategic security risk analysis. It is compatible with ISO, COBIT, HITRUST CSF, PCI-DSS or any other model used for organizing an information security program. If you are able to describe the domains of your program and the controls and threat scenarios applicable to each domain, you will be able to use Evaluator!

Instructions
------------

This README does not define terms commonly used in an OpenFAIR analysis. While not a prerequisite, a review of OpenFAIR methodology and terminology is highly recommended. Familiarity with the R language is also very helpful.

Follow these six steps to running the toolkit:

1.  Prepare the environment
2.  Define your security domains
3.  Define your controls and risk scenarios
4.  Import the scenarios
5.  Run the simulations
6.  Analyze the results

Don't be intimidated by the process. Evaluator is with you at every step!

### Prepare the Environment

A working [R interpreter](https://www.r-project.org/) is required. Evaluator should work on any current version of R (v3.3.2 as of this writing) and on any supported platform (Windows, MacOS, or Linux). This README assumes the use of [RStudio IDE](https://www.rstudio.com/), but it is not strictly required (advanced users may manually `knit` files if they so choose).

Obtain the Evaluator toolkit via `install.packages("evaluator")`. If you'd like to use the development version, you can install the GitHub version via `devtools::install_github("davidski/evaluator")`.

### Define Your Security Domains

Evaluator needs to know the domains of your security program. These are the major buckets into which you subdivide your program, typically including areas such as Physical Security, Strategy, Policy, Business Continuity/Disaster Recovery, Technical Security, etc. Out of the box, Evaluator comes with a demonstration model based upon the [HITRUST CSF](https://hitrustalliance.net/hitrust-csf/). If you have a different domain structure (e.g. ISO2700x, NIST CSF, or COBIT), you will need to edit the `data/domains.csv` file to include the domain names and the domain IDs, and a shorthand abbreviation for the domain (such as POL for the Policy domain).

### Define Your Controls and Risk Scenarios

Indentifying the controls (or capabilities) and key risk scenarios associated with each of your domains is critical to the final analysis. The elements are documented in an Excel workbook. The workbook includes one tab per domain, with each tab named after the domain IDs defined in the previous step. Each tab consists of a controls table and a threats table.

#### Controls Table

The key objectives of each domain are defined in the domain controls table. While the specific controls will be unique to each organization, the sample spreadsheet included in Evaluator may be used as a model. It is best to avoid copying every technical control from, for example, ISO 27001 or COBIT, since most control frameworks are too fine-grained to provide the high level overview that Evaluator delivers. In practice, 50 controls or less will usually be sufficient to describe organizations of up to one to two billion USD in size. Each control must have a unique ID and should be assigned a difficulty (DIFF) score thta ranks the maturity of the control on a CMM scale from Initial (lowest score) to Optimized (best of class).

#### Threats Table

The threats table consists of the potential loss scenarios addressed by each domain of your security program. Each scenario is made up of a descriptive field that describes who did what to whom, the threat community that executed the attack (e.g. external hacktivist, internal workforce member, third party vendor), how often the threat actor acts upon your assets (TEF), the strength with which they act against your assets (TCap), the losses incurred (LM) and a comma-separated list of the control IDs that prevent the scenario.

### Import the Scenarios

To extract the spreadsheet into data files for further analysis, launch RStudio, open the `0-import_survey.Rmd` notebook and click `knit`. The notebook will perform basic data validation on the workbook and extract the data. If there are data validation errors, the process will abort and an error message will be displayed. Correct the spreadsheet and re-knit the notebook to address the data validation errors.

### Run the Simulations

Once the data is ready for the simulations, open the `1-simulate_risk.Rmd` notebook and click `knit`. By default, Evaluator puts each scenario through 10,000 individual simulated years, modelling how often the threat actor will come into contact with your assets, the strength of the threat actor, the strength of your controls, and the losses involved in any situation where the threat strength exceeds your control strength. This simulation process can be computationally intense. The sample data set takes approximately 5-7 minutes on my primary development machines (last generation Windows-based platforms).

### Analyze the Results

A template for a technical risk report is provided in `2-analyze_risk.Rmd`. To use, open the document and click on `Knit to Word`. This will create a pre-populated risk report that identifies key scenarios and generates initial plots for to be used in creating a final analysis report. The `risk_dashboard.Rmd` file builds an executive summary dashboard.

For interactive exploration, open the `explore_scenarios.Rmd` file and click on `Run Document` to launch a local copy of the Scenario Explorer application. The Scenario Explorer app may be used to view information about the individual scenarios and provides a sample overview of the entire program.

For more in depth analysis, the following data files may be used directly from R or from external programs such as Tableau:

<table style="width:79%;">
<colgroup>
<col width="34%" />
<col width="44%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">Data File</th>
<th align="left">Purpose</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">simulation_results.Rds</td>
<td align="left">Full details of each simulated scenario</td>
</tr>
<tr class="even">
<td align="left">scenarios_summary.Rds</td>
<td align="left">Quantitative values of each scenario, as converted from the qualitative spreadsheet</td>
</tr>
</tbody>
</table>

Advanced Customization
----------------------

Evaluator makes several assumptions to get you up and running as quickly as possible. Advanced users may implement several different customizations including:

-   Risk tolerances - Organizational risk tolerances at a "medium" and "high" level are defined in `data/risk_tolerances.csv`. Risk tolerances are the aggregate economic loss thresholds defined by your organization. These are not necessarily the same as the size of potential losses from individual scenarios. A good proxy for risk tolerance is the budget authority implemented in your organization. The size of purchase signoff required at the executive level is generally a good indicator of the minimum floor for high risk tolerance.
-   Qualitative mappings - The translation of qualitative labels such as "Frequent" threat events and "Optimized" controls are defined in `data/qualitative_mappings.csv`. The values in this mapping may be changed but they must use lowercase and agree with the values used in the survey spreadsheet. Changing the number of levels used for any qualitative label (e.g. changing High/Medium/Low to High/Medium/Low/VeryLow) is unsupported.
-   Styling - Look and feel (fonts, colors, etc.) is defined in the `styles/html-styles.css` and `styles/word-styles-reference.docx` files.

Where to Go From Here
=====================

While Evaluator is a powerful tool, it does not explicitly attempt to address complex analysis of security risks, interaction between risk scenarios, rolling up multiple levels of risk into aggregations, modelling secondary losses or other advanced topics. As you become more comfortable with quantitative risk analysis, you may wish to dive deeper into these areas (and I hope you do!).

Commercial Software

-   [RiskLens](http://www.risklens.com/), founded by the original creator of the FAIR methodology

Blogs/Books/Training

-   Russell C. Thomas's excellent and provocative blog post on systemic [Risk Management](http://exploringpossibilityspace.blogspot.com/2013/08/risk-management-out-with-old-in-with-new.html)
-   [Measuring and Managing Information Risk](https://smile.amazon.com/gp/product/0124202314)
-   [OpenFAIR certification](http://www.opengroup.org/certifications/openfair)
-   [Hubbard Decision Research calibration training](https://www.hubbardresearch.com/training/)

Associations

-   [FAIR Institute](http://www.fairinstitute.org/)
-   [Society of Information Risk Analysts (SIRA)](https://www.societyinforisk.org/)

Contributing
============

This project is governed by a [Code of Conduct](./CODE_OF_CONDUCT.md). By participating in this project you agree to abide by these terms.

License
=======

The [MIT License](LICENSE) applies.
