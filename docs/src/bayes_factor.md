# Computing the Bayes Factor

## Overview

In this tutorial, we will use the Bayes factor to compare the evidence for one model relative to another reference model. Computing the Bayes factor is challenging because it requires integrating the log likelihood over the model parameters. One method for approximating this complex integral is non-reversible parallel tempering (Bouchard-Côté et al., 2022) using 
[Pigeons.jl](https://julia-tempering.github.io/Pigeons.jl/dev/). 

In the tutorial below, we will compare two models which differ only in terms of assumptions about drift rate variability: the LBA and the RDM. The LBA assumes that the drift rate varies across trials and is otherwise deterministic, whereas the RDM assumes the drift rate varies within a trial as Gaussian noise, but not across trials. The difference between the models can be visualized with Plots.jl:

## Load Packages

Before proceeding, we will load the required packages.
```julia
using MCMCChains
using Pigeons
using Random
using TrueAndErrorModels
using Turing
```

## Data-Generating Model

The next step is to generate simulated data for comparing the models. Here, we will assume that the LBA is the
true data generating model:
```julia
Random.seed!(258)
dist = TrueErrorModel(; p = [0.65, .15, .15, .05], ϵ = fill(.10, 4))
data = rand(dist, 200)
```

## Define Models 
The following code blocks define the models along with their prior distributions using [Turing.jl](https://turinglang.org/stable/). Notice that the models are identical except for the log likelihood function.

### TE4 Model

```julia
@model function te4_model(data)
    p ~ Dirichlet(fill(1, 4))
    ϵ ~ filldist(Uniform(0, .5), 4)
    data ~ TrueErrorModel(p, ϵ)
end
```

## TE1 Model 

```julia
@model function te1_model(data)
    p ~ Dirichlet(fill(1, 4))
    ϵ ~ Uniform(0, .5)
    data ~ TrueErrorModel(p, fill(ϵ, 4))
end
```
## Estimate Marginal Log Likelihood
The next step is to run the `pigeons` function to estimate the marginal log likelihood for each model. 

### TE4
```julia
pt_te4 = pigeons(target=TuringLogPotential(te4_model(data)), record=[traces])
```
```julia
────────────────────────────────────────────────────────────────────────────
  scans        Λ      log(Z₁/Z₀)   min(α)     mean(α)    min(αₑ)   mean(αₑ) 
────────── ────────── ────────── ────────── ────────── ────────── ──────────
        2       3.22      -47.6   0.000923      0.643          1          1 
        4       1.86      -39.9      0.265      0.793          1          1 
        8        3.6      -38.2      0.255        0.6          1          1 
       16        3.2      -39.2      0.403      0.645          1          1 
       32       3.51      -38.8       0.36       0.61          1          1 
       64       3.56      -39.6      0.441      0.605          1          1 
      128       3.78      -40.1      0.488       0.58          1          1 
      256       3.63      -39.4      0.482      0.596          1          1 
      512       3.61      -39.5      0.556      0.599          1          1 
 1.02e+03       3.56      -39.2      0.577      0.604          1          1 
────────────────────────────────────────────────────────────────────────────
```


```julia
name_map = Dict(
    "p[1]" => "pᵣᵣ",
    "p[2]" => "pᵣₛ",
    "p[3]" => "pₛᵣ",
    "p[4]" => "pₛₛ",
    "ϵ[1]" => "ϵᵣₛ₁",
    "ϵ[2]" => "ϵᵣₛ₂",
    "ϵ[3]" => "ϵₛᵣ₁",
    "ϵ[4]" => "ϵₛᵣ₂",
)
chain_te4 = Chains(pt_te4)
chain_te4 = replacenames(chain_te4, name_map)
```

```julia 
Chains MCMC chain (1024×9×1 Array{Float64, 3}):

Iterations        = 1:1:1024
Number of chains  = 1
Samples per chain = 1024
parameters        = pᵣᵣ, pᵣₛ, pₛᵣ, pₛₛ, ϵᵣₛ₁, ϵᵣₛ₂, ϵₛᵣ₁, ϵₛᵣ₂
internals         = log_density

Summary Statistics
  parameters      mean       std      mcse   ess_bulk   ess_tail      rhat   ess_per_sec 
      Symbol   Float64   Float64   Float64    Float64    Float64   Float64       Missing 

         pᵣᵣ    0.5768    0.0824    0.0039   449.2267   570.8385    1.0027       missing
         pᵣₛ    0.1820    0.0662    0.0033   391.3331   750.0271    1.0000       missing
         pₛᵣ    0.1787    0.0579    0.0026   523.1174   740.9073    1.0002       missing
         pₛₛ    0.0625    0.0297    0.0012   618.7097   755.8075    0.9995       missing
        ϵᵣₛ₁    0.0517    0.0314    0.0014   529.0317   866.9172    0.9995       missing
        ϵᵣₛ₂    0.0571    0.0342    0.0017   418.1905   657.3602    1.0010       missing
        ϵₛᵣ₁    0.1995    0.1077    0.0048   514.3591   868.8844    1.0006       missing
        ϵₛᵣ₂    0.2706    0.1235    0.0065   372.7194   763.7186    1.0005       missing

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5% 
      Symbol   Float64   Float64   Float64   Float64   Float64 

         pᵣᵣ    0.4293    0.5165    0.5762    0.6383    0.7335
         pᵣₛ    0.0712    0.1317    0.1765    0.2275    0.3180
         pₛᵣ    0.0820    0.1335    0.1760    0.2202    0.2987
         pₛₛ    0.0179    0.0411    0.0576    0.0808    0.1294
        ϵᵣₛ₁    0.0033    0.0245    0.0511    0.0754    0.1104
        ϵᵣₛ₂    0.0033    0.0282    0.0566    0.0840    0.1238
        ϵₛᵣ₁    0.0162    0.1078    0.2056    0.2830    0.3887
        ϵₛᵣ₂    0.0232    0.1705    0.2894    0.3699    0.4639
```

### TE1
```julia
pt_te1 = pigeons(target=TuringLogPotential(te1_model(data)), record=[traces])
```

```julia
────────────────────────────────────────────────────────────────────────────
  scans        Λ      log(Z₁/Z₀)   min(α)     mean(α)    min(αₑ)   mean(αₑ) 
────────── ────────── ────────── ────────── ────────── ────────── ──────────
        2       3.18      -69.3   1.04e-16      0.647          1          1 
        4       2.11      -41.9    0.00298      0.766          1          1 
        8       3.41      -39.2      0.226      0.621          1          1 
       16       2.96      -38.6      0.364      0.671          1          1 
       32       3.71      -37.6      0.459      0.588          1          1 
       64       3.55      -38.3      0.505      0.605          1          1 
      128       3.42        -38      0.487       0.62          1          1 
      256       3.48      -38.1      0.556      0.613          1          1 
      512       3.28      -37.7      0.593      0.635          1          1 
 1.02e+03       3.41        -38      0.578      0.621          1          1 
────────────────────────────────────────────────────────────────────────────
```
```julia
name_map = Dict(
    "p[1]" => "pᵣᵣ",
    "p[2]" => "pᵣₛ",
    "p[3]" => "pₛᵣ",
    "p[4]" => "pₛₛ",
)
chain_te1 = Chains(pt_te1)
chain_te1 = replacenames(chain_te1, name_map)
```

```julia 
Chains MCMC chain (1024×6×1 Array{Float64, 3}):

Iterations        = 1:1:1024
Number of chains  = 1
Samples per chain = 1024
parameters        = pᵣᵣ, pᵣₛ, pₛᵣ, pₛₛ, ϵ
internals         = log_density

Summary Statistics
  parameters      mean       std      mcse    ess_bulk    ess_tail      rhat   ess_per_sec 
      Symbol   Float64   Float64   Float64     Float64     Float64   Float64       Missing 

         pᵣᵣ    0.7077    0.0351    0.0011   1106.2442   1055.5828    1.0000       missing
         pᵣₛ    0.1178    0.0261    0.0009    908.2753    965.3276    1.0009       missing
         pₛᵣ    0.1408    0.0268    0.0008   1036.7903    867.0191    0.9992       missing
         pₛₛ    0.0338    0.0140    0.0005    891.6153   1059.1575    1.0031       missing
           ϵ    0.0874    0.0115    0.0004    952.5670    803.6060    0.9995       missing

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5% 
      Symbol   Float64   Float64   Float64   Float64   Float64 

         pᵣᵣ    0.6364    0.6843    0.7065    0.7329    0.7712
         pᵣₛ    0.0717    0.0993    0.1165    0.1344    0.1746
         pₛᵣ    0.0923    0.1213    0.1402    0.1589    0.1964
         pₛₛ    0.0120    0.0235    0.0318    0.0422    0.0662
           ϵ    0.0668    0.0795    0.0867    0.0947    0.1114
```

## Extract marginal log likelihood
In the following code block, the function `stepping_stone` extracts that marginal log likelihood:
```julia
mll_te1 = stepping_stone(pt_te1)
mll_te4 = stepping_stone(pt_te4)
```

## Compute the Bayes Factor
The bayes factor is obtained by exponentiating the difference between marginal log likelihoods. The value of `1.21` indicates that the LBA is `1.21` times more likely to have generated the data. 
```julia
bf = exp(mll_te1 - mll_te4)
```
```julia 
3.3948019100884617
```
# References

Syed, S., Bouchard-Côté, A., Deligiannidis, G., & Doucet, A. (2022). Non-reversible parallel tempering: a scalable highly parallel MCMC scheme. Journal of the Royal Statistical Society Series B: Statistical Methodology, 84(2), 321-350.