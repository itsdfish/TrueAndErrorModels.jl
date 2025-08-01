module TrueAndErrorModels

using ArgCheck
using Random

import Distributions: Multinomial
import Distributions: DiscreteMultivariateDistribution
import Distributions: length
import Distributions: logpdf
import Distributions: loglikelihood
import Distributions: rand

export AbstractTrueErrorModel
export compute_probs
export logpdf
export rand
export TrueErrorModel

export tet1_model
export tet2_model
export tet4_model
export eut1_model
export eut2_model
export eut4_model

export to_table
export get_response_labels

include("structs.jl")
include("functions.jl")
include("ext_functions.jl")
end
