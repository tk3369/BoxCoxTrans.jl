module BoxCoxTrans

export transform

using Optim: optimize, minimizer
using Statistics: mean

"""
    transform(𝐱)

Transform an array using Box-Cox method.  The lambda parameter is derived
using a log-likelihood estimator.  
If the array contains any non-positive values then a DomainError is thrown.
"""
transform(𝐱) = transform(𝐱, lambda(𝐱))

"""
    transform(𝐱, λ)

Transform an array using Box-Cox method with the provided λ parameter. 
If the array contains any non-positive values then a DomainError is thrown.
"""
function transform(𝐱, λ)
    any(𝐱 .<= 0) && throw(DomainError("Array must be positive"))
    @. λ ≈ 0 ? log(𝐱) : (𝐱 ^ λ - 1) / λ
end

"""
    lambda(𝐱; interval = (-2.0, 2.0))

Calculate lambda parameter from an array using a log-likelihood estimator.
"""
function lambda(𝐱; interval = (-2.0, 2.0))
    i1, i2 = interval
    res = optimize(λ -> -mle(𝐱, λ), i1, i2)
    return minimizer(res)
end

"""
    mle(𝐱, λ)

Return log-likelihood for the given array and lambda parameter.
"""
function mle(𝐱, λ)
    𝐲 = transform(float.(𝐱), λ)
    μ = mean(𝐲)
    N = length(𝐱)
    llf = (λ - 1) * sum(log.(𝐱))
    llf -= N / 2.0 * log(sum((𝐲 .- μ) .^ 2) / N)
    return llf
end

end # module
