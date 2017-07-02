__precompile__()

module EisensteinNumbers

import Base: +, -, *, /, \, real, imag, complex, Complex, isreal, conj, inv, abs2, show, zero, one, iszero

"Error when finding the inverse of zero."
const ZeroInverse = "inverse of zero"

"Error when the denominator in a quotient is zero."
const ZeroDenominator = "denominator is zero"

"The square root of 3, divided by 2."
const sqrtof3div2 = sqrt(3) / 2

include("Eisenstein.jl")

export Eisenstein, EisensteinFloat32, EisensteinFloat64, EisensteinFloat128,
       EisensteinInt16, EisensteinInt32, EisensteinInt64, EisensteinInt128, EisensteinInt256
export unreal, random, associates, ω, omega, asarray

end
