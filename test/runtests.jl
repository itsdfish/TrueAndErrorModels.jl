using SafeTestsets

files = filter(f -> occursin("tests.jl", f) && f ≠ "runtests.jl", readdir())
include.(files)
