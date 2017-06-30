"""
    Eisenstein{T <: Real} <: Number

An immutable pair of real numbers describing an Eisenstein number.
"""
struct Eisenstein{T <: Real} <: Number
    l::T
    r::T

    Eisenstein{T}(l::T, r::T) where {T <: Real} = new(l, r)
end

# Floats
const EisensteinFloat32 = Eisenstein{Float16}
const EisensteinFloat64 = Eisenstein{Float32}
const EisensteinFloat128 = Eisenstein{Float64}

# Ints
const EisensteinInt16 = Eisenstein{Int8}
const EisensteinInt32 = Eisenstein{Int16}
const EisensteinInt64 = Eisenstein{Int32}
const EisensteinInt128 = Eisenstein{Int64}
const EisensteinInt256 = Eisenstein{Int128}

# Constructors
function Eisenstein(a::T, b::T) where T <: Real
    Eisenstein{T}(a, b)
end

function Eisenstein(a::T) where T <: Real
    Eisenstein{T}(a, zero(T))
end

function Eisenstein(a::Real, b::Real)
    Eisenstein(promote(a, b)...)
end

# Eisenstein unit
const ω = Eisenstein(false, true)

# Real part
function real(z::Eisenstein)
    z.l
end

# Unreal part
function unreal(z::Eisenstein)
    z.r
end

function unreal(a::Real)
    zero(a)
end

function isreal(z::Eisenstein)
    iszero(unreal(z))
end

function asarray(z::Eisenstein)
    vcat(real(z), unreal(z))
end

function iszero(z::Eisenstein)
    iszero(asarray(z))
end

function zero(::Type{Eisenstein{T}}) where T <: Real
    Eisenstein{T}(zero(T), zero(T))
end

function zero(::Eisenstein{T}) where T <: Real
    zero(Eisenstein{T})
end

function one(::Type{Eisenstein{T}}) where T <: Real
    Eisenstein{T}(one(T), zero(T))
end

function one(::Eisenstein{T}) where T <: Real
    one(Eisenstein{T})
end

function omega(::Type{Eisenstein{T}}) where T <: Real
    Eisenstein{T}(zero(T), one(T))
end

function omega(::Eisenstein{T}) where T <: Real
    omega(Eisenstein{T})
end

function show(io::IO, z::Eisenstein)
    print(io, "[1: ")
    print(io, real(z))
    print(io, ", ω: ")
    print(io, unreal(z))
    print(io, "]")
end

function conj(z::Eisenstein)
    Eisenstein(real(z) - unreal(z), -(unreal(z)))
end

function (+)(z::Eisenstein)
    z
end

function (+)(x::Eisenstein, y::Eisenstein)
    Eisenstein(real(x) + real(y), unreal(x) + unreal(y))
end

function (+)(a::Real, z::Eisenstein)
    Eisenstein(a + real(z), unreal(z))
end

function (+)(z::Eisenstein, a::Real)
    Eisenstein(real(z) + a, unreal(z))
end

function (-)(z::Eisenstein)
    Eisenstein(-(real(z)), -(unreal(z)))
end

function (-)(x::Eisenstein, y::Eisenstein)
    Eisenstein(real(x) - real(y), unreal(x) - unreal(y))
end

function (-)(a::Real, z::Eisenstein)
    Eisenstein(a - real(z), -(unreal(z)))
end

function (-)(z::Eisenstein, a::Real)
    Eisenstein(real(z) - a, unreal(z))
end

function (*)(x::Eisenstein, y::Eisenstein)
    Eisenstein(
        (real(x) * real(y)) - (unreal(x) * unreal(y)),
        (real(x) * unreal(y)) + (unreal(x) * real(y)) - (unreal(x) * unreal(y)),
    )
end

function (*)(a::Real, z::Eisenstein)
    Eisenstein(a * real(z), a * unreal(z))
end

function (*)(z::Eisenstein, a::Real)
    Eisenstein(real(z) * a, unreal(z) * a)
end

function abs2(z::Eisenstein)
    (real(z))^(2) + (unreal(z))^(2) - (real(z) * unreal(z))
end

function inv(z::Eisenstein)
    if iszero(z)
        error(ZeroInverse)
    end
    
    conj(z) / abs2(z)
end

function (/)(x::Eisenstein, y::Eisenstein)
    x * inv(y)
end

function (\)(y::Eisenstein, x::Eisenstein)
    inv(y) * x
end

function (/)(a::Real, z::Eisenstein)
    a * inv(z)
end

function (\)(z::Eisenstein, a::Real)
    inv(z) * a
end

function (/)(z::Eisenstein, a::Real)
    if iszero(a)
        error(ZeroDenominator)
    end
    
    Eisenstein(real(z) / a, unreal(z) / a)
end

function (\)(a::Real, z::Eisenstein)
    if iszero(a)
        error(ZeroDenominator)
    end
    
    Eisenstein(a \ real(z), a \ unreal(z))
end

function associates(z::Eisenstein{T}) where T <: Real
    a = z
    b = -(z)
    u = omega(Eisenstein{T})
    c = z * u
    u = -(u)
    d = z * u
    u = u * u
    f = z * u
    u = -(u)
    g = z * u
    a, b, c, d, f, g
end

function random(::Type{Eisenstein{T}}) where T <: Real
    Eisenstein{T}(rand(T), rand(T))
end