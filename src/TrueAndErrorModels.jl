module TrueAndErrorModels

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
export get_error_parm_count
export get_error_parm_labels
export get_equation_count
export get_equations
export get_n_options
export get_n_reps
export logpdf
export @make_model
export rand
export get_table_labels
export get_true_parm_labels
export get_true_parm_count
export show_equations

export to_table
export get_response_labels

include("api.jl")
include("model_maker.jl")
include("ext_functions.jl")
include("utilities.jl")
end
