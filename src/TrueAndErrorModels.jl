module TrueAndErrorModels

import Distributions: Multinomial
import Distributions: DiscreteMultivariateDistribution
import Distributions: logpdf
import Distributions: loglikelihood
import Distributions: rand

export AbstractTrueErrorModel
export compute_probs
export logpdf
export rand
export TrueErrorModel

include("structs.jl")
include("functions.jl")
end
