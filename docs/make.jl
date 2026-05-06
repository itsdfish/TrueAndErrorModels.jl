using Documenter
using NamedArrays
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
        TrueAndErrorModels,
        Base.get_extension(TrueAndErrorModels, :NamedArraysExt)
    ],
    pages = [
        "Home" => "index.md",
        "Example" => "example.md",
        "API" => "api.md"
    ]
)

deploydocs(repo = "github.com/itsdfish/TrueAndErrorModels.jl.git")
