```@raw html
<img src="https://raw.githubusercontent.com/itsdfish/TrueAndErrorModels.jl/gh-pages/dev/assets/logo_readme.png" alt="drawing" width="900"/>
```

# Overview 

The purpose of this package is to automatically generate True and Error Models (TEMs; Birnbaum,  & Quispe-Torreblanca, 2018) based on experimental design parameters. TEMs provide a mathematical framework for distinguishing between true preferences and errors in option evaluation and selection, and are often used to perform critical tests designed to distinguish competing theories. For example, a person who selects risky option $\mathcal{R}$ over safe option $\mathcal{S}$ may truly prefer $\mathcal{R}$, or may truly prefer $\mathcal{S}$, but committed an error during the evaluation process. This package can generate TEMs from a large model class based on experimental design parameters using metaprogramming. See the provided example for details on how to generate TEMs and use the API.

## Key Features

1. Provides macros that generate models and methods based on experimental design.
2. Provides convienence functions for tables and plotting.
3. Integrates with many Julia ecosystems.

## Ecosystem Integration 

One of the most valuable benefits of TrueAndErrorModels.jl is its seemless integration with the Julia ecosystem. Key examples include

- [Distributions.jl](https://juliastats.org/Distributions.jl/latest/): a common interface for probability distributions, including probability density functions, cumulative distribution functions, means etc. 
- [Turing.jl](https://turinglang.org/docs/tutorials/docs-00-getting-started/index.html): an ecosystem for Bayesian parameter estimation, maximum likelihood estimation, variational inference and more.
- [Pigeons.jl](https://pigeons.run/dev/): a package for Bayes factors and Bayesian parameter estimation, specializing with intractible, multimodal posterior distributions. Pigeons.jl is compatible with Turing.jl.

# References

Birnbaum, M. H., & Quispe-Torreblanca, E. G. (2018). TEMAP2. R: True and error model analysis program in R. Judgment and Decision Making, 13(5), 428-440.

Lee, M. D. (2018). Bayesian methods for analyzing true-and-error models. Judgment and Decision Making, 13(6), 622-635.