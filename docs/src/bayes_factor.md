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
Random.seed!(541)
dist = TrueErrorModel(; p = [0.60, .30, .05, .05], ϵ = fill(.10, 4))
data = rand(dist, 200)
```

## Define Models 
The following code blocks define the models along with their prior distributions using [Turing.jl](https://turinglang.org/stable/). Notice that the models are identical except for the log likelihood function.

### RDM

```julia
@model function te4_model(data)
    p ~ Dirichlet(fill(1, 4))
    ϵ ~ filldist(Uniform(0, .5), 4)
    data ~ TrueErrorModel(p, ϵ)
end
```

## LBA 

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
        2       3.25      -52.7    0.00244      0.639          1          1 
        4       2.19      -38.7      0.152      0.757          1          1 
        8       2.71      -42.3    0.00281      0.698          1          1 
       16       3.81      -40.4      0.262      0.576          1          1 
       32       3.41      -40.8      0.464      0.621          1          1 
       64       3.76      -40.9      0.247      0.582          1          1 
      128       3.77      -40.4      0.489      0.581          1          1 
      256       3.66      -40.6      0.519      0.594          1          1 
      512       3.52      -40.4      0.559      0.609          1          1 
 1.02e+03        3.6      -40.6      0.572        0.6          1          1 
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

         pᵣᵣ    0.5154    0.0709    0.0032   517.0050   691.9324    0.9991       missing
         pᵣₛ    0.2974    0.0583    0.0028   439.8920   630.1510    1.0065       missing
         pₛᵣ    0.1325    0.0495    0.0021   553.5050   793.0310    1.0001       missing
         pₛₛ    0.0547    0.0330    0.0014   574.1878   814.2801    0.9994       missing
        ϵᵣₛ₁    0.0524    0.0283    0.0013   494.4657   784.5909    1.0016       missing
        ϵᵣₛ₂    0.0711    0.0378    0.0017   483.4845   751.6983    1.0031       missing
        ϵₛᵣ₁    0.2656    0.1333    0.0058   555.4617   964.3257    0.9996       missing
        ϵₛᵣ₂    0.1222    0.0707    0.0032   544.5935   788.4338    0.9999       missing

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5% 
      Symbol   Float64   Float64   Float64   Float64   Float64 

         pᵣᵣ    0.3873    0.4639    0.5116    0.5646    0.6550
         pᵣₛ    0.1927    0.2561    0.2955    0.3364    0.4127
         pₛᵣ    0.0570    0.0922    0.1271    0.1650    0.2401
         pₛₛ    0.0090    0.0288    0.0494    0.0753    0.1312
        ϵᵣₛ₁    0.0035    0.0300    0.0535    0.0732    0.1044
        ϵᵣₛ₂    0.0052    0.0415    0.0712    0.0994    0.1430
        ϵₛᵣ₁    0.0178    0.1585    0.2810    0.3754    0.4787
        ϵₛᵣ₂    0.0081    0.0602    0.1223    0.1762    0.2554
```

### TE1
```julia
pt_te1 = pigeons(target=TuringLogPotential(te1_model(data)), record=[traces])
```

```julia
────────────────────────────────────────────────────────────────────────────
  scans        Λ      log(Z₁/Z₀)   min(α)     mean(α)    min(αₑ)   mean(αₑ) 
────────── ────────── ────────── ────────── ────────── ────────── ──────────
        2          5      -64.5   1.25e-15      0.444          1          1 
        4       2.66      -43.1   1.83e-05      0.704          1          1 
        8       4.18      -37.1      0.293      0.536          1          1 
       16        3.2      -38.2      0.395      0.645          1          1 
       32        3.1      -37.6      0.523      0.656          1          1 
       64        3.4      -38.2      0.421      0.623          1          1 
      128       3.39      -38.2      0.539      0.623          1          1 
      256       3.22      -38.2      0.542      0.643          1          1 
      512       3.39      -38.3      0.571      0.624          1          1 
 1.02e+03       3.44      -38.4      0.575      0.617          1          1 
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
  parameters      mean       std      mcse    ess_bulk   ess_tail      rhat   ess_per_sec 
      Symbol   Float64   Float64   Float64     Float64    Float64   Float64       Missing 

         pᵣᵣ    0.5839    0.0387    0.0013    893.7920   857.1908    1.0015       missing
         pᵣₛ    0.3035    0.0341    0.0012    866.3328   818.7203    1.0042       missing
         pₛᵣ    0.0884    0.0223    0.0007    886.3091   967.7621    0.9998       missing
         pₛₛ    0.0241    0.0135    0.0004   1056.1839   962.0659    1.0000       missing
           ϵ    0.0838    0.0108    0.0004    967.7828   974.2063    0.9992       missing

Quantiles
  parameters      2.5%     25.0%     50.0%     75.0%     97.5% 
      Symbol   Float64   Float64   Float64   Float64   Float64 

         pᵣᵣ    0.5081    0.5581    0.5851    0.6097    0.6611
         pᵣₛ    0.2399    0.2821    0.3048    0.3262    0.3730
         pₛᵣ    0.0489    0.0727    0.0873    0.1026    0.1350
         pₛₛ    0.0054    0.0143    0.0215    0.0314    0.0571
           ϵ    0.0644    0.0763    0.0831    0.0902    0.1065
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
9.096485357929172
```
# References

Syed, S., Bouchard-Côté, A., Deligiannidis, G., & Doucet, A. (2022). Non-reversible parallel tempering: a scalable highly parallel MCMC scheme. Journal of the Royal Statistical Society Series B: Statistical Methodology, 84(2), 321-350.