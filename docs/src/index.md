# TrueAndErrorModels.jl

The purpose of this package is to provide an implementation of True and Error Theory (TET; Birnbaum,  & Quispe-Torreblanca, 2018) in the Julia programming language. TET provides a mathematical framework for distinguishing between true preferences and errors in option evaluation and selection. For example, a person who selects risky option $\mathcal{R}$ over safe option $\mathcal{S}$ may have selected $\mathcal{R}$ because he or she truely prefers $\mathcal{R}$, or may truely prefer $\mathcal{S}$, but committed an error during the evaluation process. 

We demonstrate how to perform Bayesian parameter estimation and model comparison (e.g., Lee, 2018) using [Turing.jl](https://turinglang.org/docs/tutorials/docs-00-getting-started/index.html) and [Pigeons.jl](https://pigeons.run/dev/). Use the navigation on the left to learn more about TET and how to perform Bayesian parameter estimation and model comparison.

# References

Birnbaum, M. H., & Quispe-Torreblanca, E. G. (2018). TEMAP2. R: True and error model analysis program in R. Judgment and Decision Making, 13(5), 428-440.

Lee, M. D. (2018). Bayesian methods for analyzing true-and-error models. Judgment and Decision making, 13(6), 622-635.