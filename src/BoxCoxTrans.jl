module BoxCoxTrans

using Optim: optimize, minimizer
using Statistics: mean, var
using StatsBase: geomean

"""
    transform(𝐱; α = 0)

Transform an array using Box-Cox method.  The lambda parameter is derived
using a log-likelihood estimator. 

If the array contains any non-positive values then a DomainError is thrown.
"""
transform(𝐱; kwargs...) = transform(𝐱, lambda(𝐱); kwargs...)

"""
    transform(𝐱, λ; α = 0)

Transform an array using Box-Cox method with the provided λ parameter. 
If the array contains any non-positive values then a DomainError is thrown.
"""
function transform(𝐱, λ; α = 0) 
    𝐱 .+= α
    any(𝐱 .<= 0) && throw(DomainError("Data must be positive"))
    @. λ ≈ 0 ? log(𝐱) : (𝐱 ^ λ - 1) / λ
end

"""
    lambda(𝐱; interval = (-2.0, 2.0))

Calculate lambda parameter from an array using a log-likelihood estimator.
"""
function lambda(𝐱; interval = (-2.0, 2.0))
    i1, i2 = interval
    res = optimize(λ -> -log_likelihood(𝐱, λ), i1, i2)
    return minimizer(res)
end

"""
    log_likelihood(𝐱, λ)

Return log-likelihood for the given array and lambda parameter.
"""
function log_likelihood(𝐱, λ)
    N = length(𝐱)
    𝐲 = transform(float.(𝐱), λ)
    σ² = var(𝐲, corrected = false)
    gm = geomean(𝐱)
    return -N / 2.0 * log(2 * π * σ² / gm ^ (2 * (λ - 1)) + 1)
end

end # module
