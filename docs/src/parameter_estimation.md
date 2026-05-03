```@raw html
<img src="https://raw.githubusercontent.com/itsdfish/TrueAndErrorModels.jl/gh-pages/dev/assets/logo_readme.png" alt="drawing" width="900"/>
```
# Bayesian Parameter Estimation

The purpose of this tutorial is to demonstrate how to perform Bayesian parameter estimation of the True and Error model (TET; Birnbaum & Quispe-Torreblanca, 2018) using the [Turing.jl](https://turinglang.org/) package. 

## Full Code 

You can reveal copy-and-pastable version of the full code by clicking the ▶ below.

```@raw html
<details>
<summary><b>Show Full Code</b></summary>
```
```julia
using Random
using StatsPlots
using TrueAndErrorModels
using Turing
using TuringUtilities
Random.seed!(6632)

n_options = [2, 2]
n_reps = 2
@make_model MyCoolModel n_options n_reps

dist = MyCoolModel(; p = [0.65, 0.00, 0.0, 0.35], ϵ = fill(0.10, 4))
data = rand(dist, 200)

@model function tet1_model(data::Vector{<:Integer})
    p ~ Dirichlet(fill(1, 4))
    ϵ ~ Uniform(0, 0.5)
    ϵ′ = fill(ϵ, 4)
    data ~ MyCoolModel(; p, ϵ = ϵ′)
    return (; p, ϵ = ϵ′)
end

# Estimate parameters
chains = sample(tet1_model(data), NUTS(1000, 0.65), MCMCThreads(), 1000, 4)

name_map = Dict(
    "p[1]" => "pᵣᵣ",
    "p[2]" => "pᵣₛ",
    "p[3]" => "pₛᵣ",
    "p[4]" => "pₛₛ"
)
chains = replacenames(chains, name_map)

post_plot = plot(chains, grid = false)
vline!(
    post_plot,
    [missing 0.65 missing 0.15 missing 0.15 missing 0.05 missing 0.10],
    color = :black,
    linestyle = :dash
)
```
```@raw html
</details>
```

## Load Packages

The first step is to load the required packages. You will need to install each package in your local
environment in order to run the code locally. We will also set a random number generator so that the results are reproducible.

```@example estimate
using Random
using StatsPlots
using TrueAndErrorModels
using Turing
using TuringUtilities
Random.seed!(6632)
```

## Generate Model

### Experimental Design

As a simple example, we will consider an experiment designed to test expected utility theory (EUT), which commonly known as the Allias paradox. In this experiment, there are two choice sets, each containing two gambles. The choice sets are denoted as follows: 

``\mathcal{C}_1 = \{\mathcal{G}_1,\mathcal{G}_2\}``

and 

 ``\mathcal{C}_2 = \{\mathcal{G}_{1}^{\prime},\mathcal{G}_{2}^{\prime}\}``,

A gamble is denoted as a set of outcome and corresponding probability pairs: 

``\mathcal{G} = (x_{1}, p_{1}; \dots; x_{n}, p_{n})``.

The gambles are constructed such that EUT predicts people will select the corresponding gamble in 
each choice set. Formally, EUT predicts the following preference relationship for ``i,j \in \{1,2\}``, with ``i \ne j``:

``\mathcal{G}_i \succ \mathcal{G}_j \Longleftrightarrow \mathcal{G}_{i}^{\prime} \succ \mathcal{G}_{j}^{\prime}``

To estimate the parameters of a TEM, both choice sets must be presented in at least separate blocks. Filler choice sets are interspersed within each block to ensure that the errors are independent. Below, we create a model matching this experimental design: two choice sets, each with two options, which are repeated twice. We will name this model `MyCoolModel` to highlight the fact that it is indeed cool.

```@example estimate
n_options = [2, 2]
n_reps = 2
@make_model MyCoolModel n_options n_reps
```

### Response Patterns

In this experiment, there are $2^4 = 16$ response patterns formed from two choice sets with two options each, and two repetitions of the choice sets. We can generate the response patterns with the function `get_response_labels`.

Response patterns are coded as follows: responses within the same block are grouped by inner parentheses, numbers correspond to the index of the selected option, and position of the number within the parentheses indicates the choice set.
For example, `((1,1), (1,2))` indicates the first option was chosen in all cases except in the second choice set of the second block where the second option was selected.
    
### Parameters

Most TEMs consist of two types of parameters: true preference parameters and error paramaters. These parameters are organized into corresponding vectors. The true preference vector is defined as:

``\mathbf{p} = \left[p_{11},p_{21},p_{12},p_{22} \right],``

where ``\sum_{i \in \mathcal{I}} p_i = 1`` and ``p_i \geq 0, \forall i``. Subscripts $ij$ indicate preference for option $i$ in the first choice set and preference for option $j$ in the second choice set.

Similarly, the error parameters are defined as:

``\boldsymbol{\epsilon} = \left[\epsilon_{21},\epsilon_{11},\epsilon_{22},\epsilon_{12} \right],``

where ``\epsilon_{ka}`` is the probability of erroneously selecting option $k$ from the $a$th choice set. 

### Model Equations

You can view the model equations by calling `get_equations` and passing `MyCoolModel` or a model object of that type. The model equations are organized according to the response patterns above. The corresponding response pattern is shown above each equation.

```@example estimate
show_equations(MyCoolModel)
```

## Model 

In this section, we will encode the predictions of EUT into the TEM. Recall from above that EUT predictions a person will prefer first option in both choice sets $\mathcal{C}_1$ and $\mathcal{C}_2$ or the second option in both. This means $p_{12} = p_{21} = 0$, and the probability of prefering the first options is ``\lambda \in [0,1]`` and the probabilty of prefering the second options is ``1-\lambda``:

- ``p_{11} = \lambda``
- ``p_{12} = 0``
- ``p_{21} = 0``
- ``p_{22} = 1 - \lambda``


## Generate Data



- ``p_{11} = .40``
- ``p_{21} = .10``
- ``p_{12} = .10``
- ``p_{22} = .40``

In addition, our model assumes the error probabilities are constrained to be equal:

``\epsilon_{21} = \epsilon_{12} = \epsilon_{21} =\epsilon_{22} = .10``

```@example estimate
dist = MyCoolModel(; p = [0.40, 0.10, 0.10, 0.40], ϵ = fill(0.10, 4))
n_sim = 200
data = rand(dist, 200)
```
 

## The Turing Model

The TET1 model is automatically loaded when Turing is loaded into your Julia session. The `tet1_model` function accepts a vector of response frequencies. The prior distributions are as follows:

``
\mathbf{p} \sim \mathrm{Dirichlet}([1,1,1,1])
``

``
\epsilon \sim \mathrm{Uniform}(0, .5)
``

where $\mathbf{p}$ is a vector of four preference state parameters, and $\epsilon$ is a scalar. In the TET1 model, we assume `` \epsilon = \epsilon_{21} = \epsilon_{12} = \epsilon_{21} =\epsilon_{22}``. 

```@example estimate
@model function tem1_model(data::Vector{<:Integer})
    p ~ Dirichlet(fill(1, 4))
    ϵ ~ Uniform(0, 0.5)
    ϵ′ = fill(ϵ, 4)
    data ~ MyCoolModel(; p, ϵ = ϵ′)
    return (; p, ϵ = ϵ′)
end
```

## Estimate the Parameters

Now that the Turing model has been specified, we can perform Bayesian parameter estimation with the function `sample`. We will use the No U-Turn Sampler (NUTS) to sample from the posterior distribution. The inputs into the `sample` function below are summarized as follows:

1. `model(data)`: the Turing model with data passed
2. `NUTS(1000, .65)`: a sampler object for the No U-Turn Sampler for 1000 warmup samples.
3. `MCMCThreads()`: instructs Turing to run each chain on a separate thread
4. `n_iterations`: the number of iterations performed after warmup
5. `n_chains`: the number of chains

For ease of intepretation, we will convert the numerical indices of preference vector $\mathbf{p}$ to more informative labeled indices. 

```@example estimate
model = tem1_model(data)
chains = sample(model, NUTS(1000, 0.65), MCMCThreads(), 1000, 4)
name_map = Dict("p[$i]" => v for (i,v) ∈ enumerate(get_true_parm_labels(MyCoolModel)))
_chains = replacenames(chains, name_map)
```

The output below shows the mean, standard deviation, effective sample size, and rhat for each of the five parameters. The pannel below shows the quantiles of the marginal distributions.  We see that the chains converged according to $\hat{r} \leq 1.05$,
```@example estimate
describe(_chains)
```

## Evaluation

It is important to verify visually that the chains converged. The trace plots below show that the chains look like "hairy caterpillars", which indicates the chains did not get stuck. 

```@example estimate
post_plot = plot(_chains, grid = false)
vline!(
    post_plot,
    [missing 0.40 missing 0.10 missing 0.10 missing 0.40 missing 0.10],
    color = :black,
    linestyle = :dash
)
```

The data-generating parameters are represented as black vertical lines in the density plots. As expected, the posterior distributions are centered near the data-generating parameters. Given that the data-generating and estimated model are the same, we would expect the posterior distributions to be near the data-generating parameters. 

# Posterior Predictive Distributions 

```@example estimate
pred_model = predict_distribution(;
    simulator = Θ -> rand(MyCoolModel(; Θ...), n_sim),
    model,
    func = x -> x ./ sum(x)
)
```

```@example estimate
post_preds = generated_quantities(pred_model, chains)
post_preds = stack(post_preds, dims = 1)
```

```@example estimate
labels = get_response_labels(dist)
violin(
    post_preds,
    xticks = (1:length(labels), labels),
    ylabel = "Response Probability",
    leg = false,
    grid = false,
    xrotation = 45
)
scatter!(1:16, data ./ sum(data), color = :black)
```

# References

Birnbaum, M. H., & Quispe-Torreblanca, E. G. (2018). TEMAP2. R: True and error model analysis program in R. Judgment and Decision Making, 13(5), 428-440.

Lee, M. D. (2018). Bayesian methods for analyzing true-and-error models. Judgment and Decision Making, 13(6), 622-635.
