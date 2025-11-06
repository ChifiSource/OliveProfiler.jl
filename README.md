- [documentation](https://chifidocs.com/olive/OliveAutoProfiler)
- [olive](https://github.com/ChifiSource/Olive.jl)

<div align="center">
<img src="https://github.com/ChifiSource/image_dump/raw/main/olive/0.1/extensions/olivememoryprogress.png" width="150"></img>
</div>

A resource and statistic profiler for `Olive`. As of right now, this will only provide a (detailed) memory usage indicator in the top right. More might eventually come to this project.

`OliveProfiler` is loaded like any other `Olive` extension, by loading the `Module` in your `olive.jl` file or **before** starting `Olive`.
```julia
using OliveProfiler; using Olive; Olive.start()
```
For more information on installing, check out [installing extensions](https://chifidocs.com/olive/Olive/installing-extensions).
