using Documenter
using TrueAndErrorModels

makedocs(
    sitename = "TrueAndErrorModels",
    format = Documenter.HTML(),
    modules = [TrueAndErrorModels]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
