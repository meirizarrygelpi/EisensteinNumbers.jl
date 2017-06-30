using EisensteinNumbers
using Base.Test: @test, @test_throws

# Eisenstein: same type arguments
@test begin
    l = Eisenstein(1, 2)
    r = Eisenstein{Int}(1, 2)
    l == r
end

# Eisenstein: mixed type arguments
@test begin
    l = Eisenstein(1, 1.2)
    r = Eisenstein{Float64}(1.0, 1.2)
    l == r
end

# Eisenstein: single argument
@test begin
    l = Eisenstein(3)
    r = Eisenstein(3, 0)
    l == r
end

# real
@test begin
    l = real(Eisenstein(1, 2))
    r = 1
    l == r
end

# unreal: Eisenstein
@test begin
    l = unreal(Eisenstein(1.2, 3.4))
    r = 3.4
    l == r
end

# unreal: Real
@test begin
    l = unreal(10)
    r = 0
    l == r
end

# isreal: false case
@test begin
    l = isreal(Eisenstein(3, 4))
    r = false
    l == r
end

# isreal: true case
@test begin
    l = isreal(2 + 0ω)
    r = true
    l == r
end

# asarray
@test begin
    l = asarray(Eisenstein(5, 6))
    r = [5, 6]
    l == r
end

# iszero: false case
@test begin
    l = iszero(ω)
    r = false
    l == r
end

# iszero: true case
@test begin
    l = iszero(Eisenstein(0, 0))
    r = true
    l == r
end

# zero: type argument
@test begin
    l = zero(Eisenstein{Int})
    r = Eisenstein{Int}(0, 0)
    l == r
end

# zero: Eisenstein argument
@test begin
    l = zero(Eisenstein(1.2, 3.4))
    r = Eisenstein{Float64}(0.0, 0.0)
    l == r
end

# one: type argument
@test begin
    l = one(Eisenstein{Int})
    r = Eisenstein{Int}(1, 0)
    l == r
end

# one: Eisenstein argument
@test begin
    l = one(Eisenstein(1.2, 3.4))
    r = Eisenstein{Float64}(1.0, 0.0)
    l == r
end

# omega: type argument
@test begin
    l = omega(Eisenstein{Int})
    r = Eisenstein{Int}(0, 1)
    l == r
end

# omega: Eisenstein argument
@test begin
    l = omega(Eisenstein(1.2, 3.4))
    r = Eisenstein{Float64}(0.0, 1.0)
    l == r
end

# show
@test begin
    io = IOBuffer()
    show(io, Eisenstein(1, 2))
    l = String(take!(io))
    r = "[1: 1, ω: 2]"
    l == r
end

# conj
@test begin
    l = conj(Eisenstein(3, 4))
    r = Eisenstein(-1, -4)
    l == r
end

# Involutivity of conj
@test begin
    z = Eisenstein(2, 5)
    l = conj(conj(z))
    r = z
    l == r
end

# +: unary
@test begin
    l = +(Eisenstein(1, 2))
    r = Eisenstein(1, 2)
    l == r
end

# +: two Eisenstein numbers
@test begin
    x = Eisenstein(1, 2)
    y = Eisenstein(3, 4)
    l = x + y
    r = Eisenstein(4, 6)
    l == r
end

# +: add Eisenstein and Real
@test begin
    l = 2 + Eisenstein(5, 6)
    r = Eisenstein(7, 6)
    l == r
end

@test begin
    l = Eisenstein(7, 8) + 3
    r = Eisenstein(10, 8)
    l == r
end

# -: unary
@test begin
    l = -(Eisenstein(1.2, 3.4))
    r = Eisenstein(-1.2, -3.4)
    l == r
end

# -: two Eisenstein numbers
@test begin
    x = Eisenstein(1, 2)
    y = Eisenstein(3, 4)
    l = x - y
    r = Eisenstein(-2, -2)
    l == r
end

# -: add Eisenstein and Real
@test begin
    l = 2 - Eisenstein(5, 6)
    r = Eisenstein(-3, -6)
    l == r
end

@test begin
    l = Eisenstein(7, 8) - 3
    r = Eisenstein(4, 8)
    l == r
end

# ω is cubic root of unity
@test begin
    l = ω * ω * ω
    r = one(Eisenstein{Int})
    l == r
end

# *: multiply two Eisenstein numbers
@test begin
    l = Eisenstein(3, 1) * Eisenstein(2, -1)
    r = Eisenstein(7, 0)
    l == r
end

# *: commutativity
@test begin
    a = Eisenstein(1, 3)
    b = Eisenstein(2, 4)
    l = a * b
    r = b * a
    l == r
end

# *: multiply Eisenstein and Real
@test begin
    l = 2 * Eisenstein(3, 4)
    r = Eisenstein(6, 8)
    l == r
end

@test begin
    l = Eisenstein(3, 4) * 23
    r = Eisenstein(69, 92)
    l == r
end

# Positivity of abs2
@test begin
    l = abs2(Eisenstein(1, 2)) > 0
    r = true
    l == r
end

@test_throws ErrorException begin
    inv(zero(Eisenstein{Int}))
end

# /
@test begin
    x = Eisenstein(-50 // 9, -19 // 91)
    y = Eisenstein(-1 // 55, 91 // 8)
    z = x * y
    l = z / y
    r = x
    l == r
end

# \
@test begin
    x = Eisenstein(-50 // 9, -19 // 91)
    y = Eisenstein(-1 // 55, 91 // 8)
    z = x * y
    l = x \ z
    r = y
    l == r
end

# /: Eisenstein and Real
@test begin
    a = 69 // 47
    z = Eisenstein(33 // 28, 13 // 35)
    l = a / z
    r = a * inv(z)
    l == r
end

@test begin
    a = 6 // 19
    b = -25 // 71
    c = 34 // 1
    l = Eisenstein(b, c) / a
    r = Eisenstein(b / a, c / a)
    l == r
end

@test_throws ErrorException begin
    Eisenstein(3.1, 4.2) / 0.0
end

# \: Eisenstein and Real
@test begin
    a = 69 // 47
    z = Eisenstein(33 // 28, 13 // 35)
    l = z \ a
    r = inv(z) * a
    l == r
end

@test begin
    a = 6 // 19
    b = -25 // 71
    c = 34 // 1
    l = a \ Eisenstein(b, c)
    r = Eisenstein(a \ b, a \ c)
    l == r
end

@test_throws ErrorException begin
    0.0 \ Eisenstein(3.1, 4.2)
end

# associates
@test begin
    a, b, c, d, f, g = associates(Eisenstein(3, 7))
    abs2(a) == abs2(b) == abs2(c) == abs2(d) == abs2(f) == abs2(g)
end

# random
@test begin
    l = random(Eisenstein{Int64})
    r = random(Eisenstein{Int64})
    l != r
end
