- [documentation](https://chifidocs.com/olive/OliveAutoProfiler)
- [olive](https://github.com/ChifiSource/Olive.jl)

# OliveProfiler.jl
A resource and statistic profiler for `Olive`. As of right now, this will only provide a (detailed) memory usage indicator in the top right. More might eventually come to this project.

`OliveProfiler` is loaded like any other `Olive` extension, by loading the `Module` in your `olive.jl` file or **before** starting `Olive`.
```julia
using OliveProfiler; using Olive; Olive.start()
```
For more information on installing, check out [installing extensions](https://chifidocs.com/olive/Olive/installing-extensions).
