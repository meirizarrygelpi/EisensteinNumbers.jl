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