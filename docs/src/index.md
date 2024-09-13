```@raw html
<img src="https://raw.githubusercontent.com/itsdfish/TrueAndErrorModels.jl/gh-pages/dev/assets/logo_readme.png" alt="drawing" width="900"/>
```

# Overview 

The purpose of this package is to provide an implementation of True and Error Theory (TET; Birnbaum,  & Quispe-Torreblanca, 2018) in the Julia programming language. TET provides a mathematical framework for distinguishing between true preferences and errors in option evaluation and selection. For example, a person who selects risky option $\mathcal{R}$ over safe option $\mathcal{S}$ may have selected $\mathcal{R}$ because he or she truely prefers $\mathcal{R}$, or may truely prefer $\mathcal{S}$, but committed an error during the evaluation process. For more details, see the *Model Overview* section for more details. 

## Key Features

One of the most valuable benefits of TrueAndErrorModels.jl is its seemless integration with the Julia ecosystem. Key examples include

- [Distributions.jl](https://juliastats.org/Distributions.jl/latest/): a common interface for probability distributions, including probability density functions, cumulative distribution functions, means etc. 
- [Turing.jl](https://turinglang.org/docs/tutorials/docs-00-getting-started/index.html): an ecosystem for Bayesian parameter estimation, maximum likelihood estimation, variational inference and more.
- [Pigeons.jl](https://pigeons.run/dev/): a package for Bayes factors and Bayesian parameter estimation, specializing with intractible, multimodal posterior distributions. Pigeons.jl is compatible with Turing.jl.

# References

Birnbaum, M. H., & Quispe-Torreblanca, E. G. (2018). TEMAP2. R: True and error model analysis program in R. Judgment and Decision Making, 13(5), 428-440.

Lee, M. D. (2018). Bayesian methods for analyzing true-and-error models. Judgment and Decision Making, 13(6), 622-635.