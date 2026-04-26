module TrueAndErrorModels

using ArgCheck
using DocStringExtensions
using PrettyTables
using Random
using Subscripts: sub

import Distributions: Multinomial
import Distributions: DiscreteMultivariateDistribution
import Distributions: length
import Distributions: logpdf
import Distributions: loglikelihood
import Distributions: rand

export AbstractTrueErrorModel
export compute_probs
export error_parm_count
export get_n_options
export logpdf
export @make_model
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

include("api.jl")
include("model_maker.jl")
include("ext_functions.jl")
include("utilities.jl")
end
