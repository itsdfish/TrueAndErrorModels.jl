# @testitem "tet1_model" begin
#     using TrueAndErrorModels
#     using Test
#     using Turing
#     using TuringUtilities

#     dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
#     data = rand(dist, 200)

#     model = tet1_model(data)
#     chains = sample(model, NUTS(500, 0.65), MCMCThreads(), 500, 4)

#     pred_model = predict_distribution(
#         TrueErrorModel;
#         model,
#         func = x -> x ./ sum(x),
#         n_samples = 200
#     )

#     post_preds = generated_quantities(pred_model, chains)
#     post_preds = stack(post_preds, dims = 1)
#     @test model() ≠ nothing
# end

# @testitem "tet2_model" begin
#     using TrueAndErrorModels
#     using Test
#     using Turing
#     using TuringUtilities

#     dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
#     data = rand(dist, 200)

#     model = tet2_model(data)
#     chains = sample(model, NUTS(500, 0.65), MCMCThreads(), 500, 4)

#     pred_model = predict_distribution(
#         TrueErrorModel;
#         model,
#         func = x -> x ./ sum(x),
#         n_samples = 200
#     )

#     post_preds = generated_quantities(pred_model, chains)
#     post_preds = stack(post_preds, dims = 1)
#     @test tet2_model(data)() ≠ nothing
# end

# @testitem "tet4_model" begin
#     using TrueAndErrorModels
#     using Test
#     using Turing
#     using TuringUtilities

#     dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
#     data = rand(dist, 200)

#     model = tet4_model(data)
#     chains = sample(model, NUTS(500, 0.65), MCMCThreads(), 500, 4)

#     pred_model = predict_distribution(
#         TrueErrorModel;
#         model,
#         func = x -> x ./ sum(x),
#         n_samples = 200
#     )

#     post_preds = generated_quantities(pred_model, chains)
#     post_preds = stack(post_preds, dims = 1)
# end

# @testitem "eut1_model" begin
#     using TrueAndErrorModels
#     using Test
#     using Turing
#     using TuringUtilities

#     dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
#     data = rand(dist, 200)

#     model = eut1_model(data)
#     chains = sample(model, NUTS(500, 0.65), MCMCThreads(), 500, 4)

#     pred_model = predict_distribution(
#         TrueErrorModel;
#         model,
#         func = x -> x ./ sum(x),
#         n_samples = 200
#     )

#     post_preds = generated_quantities(pred_model, chains)
#     post_preds = stack(post_preds, dims = 1)
# end

# @testitem "eut2_model" begin
#     using TrueAndErrorModels
#     using Test
#     using Turing
#     using TuringUtilities

#     dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
#     data = rand(dist, 200)

#     model = eut2_model(data)
#     chains = sample(model, NUTS(500, 0.65), MCMCThreads(), 500, 4)

#     pred_model = predict_distribution(
#         TrueErrorModel;
#         model,
#         func = x -> x ./ sum(x),
#         n_samples = 200
#     )

#     post_preds = generated_quantities(pred_model, chains)
#     post_preds = stack(post_preds, dims = 1)
# end

# @testitem "eut4_model" begin
# using TrueAndErrorModels
# using Test
# using Turing
# using TuringUtilities

# dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
# data = rand(dist, 200)

# model = eut4_model(data)
# chains = sample(model, NUTS(500, 0.65), MCMCThreads(), 500, 4)

# pred_model = predict_distribution(
#     TrueErrorModel;
#     model,
#     func = x -> x ./ sum(x),
#     n_samples = 200
# )

# post_preds = generated_quantities(pred_model, chains)
# post_preds = stack(post_preds, dims = 1)
# end
