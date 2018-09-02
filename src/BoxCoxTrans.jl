module BoxCoxTrans

export transform

using Optim: optimize, minimizer
using Statistics: mean

"""
Transform an array using Box-Cox method.  The lambda parameter is derived
using a maximum likelihood estimator.  
"""
transform(𝐱) = transform(𝐱, lambda(𝐱))

"""
Transform an array using Box-Cox method with the provided λ parameter. 
"""
transform(𝐱, λ) = @. λ ≈ 0 ? log(𝐱) : (𝐱 ^ λ - 1) / λ

"""
Calculate lambda parameter
"""
function lambda(𝐱; interval = (-2.0, 2.0))
    i1, i2 = interval
    res = optimize(λ -> -mle(𝐱, λ), i1, i2)
    return minimizer(res)
end

"""
Maximum Likelihood Estimator
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
