using Documenter
using TrueAndErrorModels
using Turing

makedocs(
    warnonly = true,
    sitename = "TrueAndErrorModels",
    format = Documenter.HTML(
        assets = [
            asset(
            "https://fonts.googleapis.com/css?family=Montserrat|Source+Code+Pro&display=swap",
            class = :css
        )
        ],
        collapselevel = 1
    ),
    modules = [
        TrueAndErrorModels
    #.get_extension(TrueAndErrorModels, :TuringExt),
    ],
    pages = [
        "Home" => "index.md",
        "Bayesian Parameter Estimation" => "parameter_estimation.md",
        "Bayesian Model Comparison" => "bayes_factor.md"
    ]
)

deploydocs(repo = "github.com/itsdfish/TrueAndErrorModels.jl.git")
