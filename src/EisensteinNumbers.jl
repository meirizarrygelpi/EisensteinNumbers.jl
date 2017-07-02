__precompile__()

module EisensteinNumbers

import Base: +, -, *, /, \, real, imag, complex, Complex, isreal, conj, inv, abs2, show, zero, one, iszero

"Error when finding the inverse of zero."
const ZeroInverse = "inverse of zero"

"Error when the denominator in a quotient is zero."
const ZeroDenominator = "denominator is zero"

# Half of the square root of 3
Base.@irrational halfsqrt3 0.86602540378443864676 (sqrt(big(3)) / 2)

include("Eisenstein.jl")

export Eisenstein, Eisenstein16, Eisenstein32, Eisenstein64, Eisenstein128, Eisenstein256, EisensteinBigInt
export unreal, random, associates, ω, omega, asarray, halfsqrt3

end
