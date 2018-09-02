module BoxCoxTrans

export transform

using Optim: optimize, minimizer

function log_likelihood_function(𝐱, λ)
    𝐲 = boxcox(float.(𝐱), λ)
    μ = mean(𝐲)
    N = length(𝐱)
    llf = (λ - 1) * sum(log.(𝐱))
    llf -= N / 2.0 * log(sum((𝐲 .- μ) .^ 2) / N)
    return llf
end

boxcox(𝐱, λ) = λ ≈ 0 ? log.(𝐱) : (𝐱 .^ λ .- 1) ./ λ

function transform(𝐱; interval = (-0.2, 0.2))
    i1, i2 = interval
    λ = optimize(λ -> -log_likelihood_function(𝐱, λ), i1, i2)
    return boxcox(𝐱, λ)
end

end # module
