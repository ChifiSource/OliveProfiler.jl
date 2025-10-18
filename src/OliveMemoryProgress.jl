module OliveMemoryProgress
using Olive
using Olive.Toolips
using Olive.Toolips.Components
import Olive: build, init_user, on_code_evaluate

init_user(user::Olive.OliveUser, oe::Type{Olive.OliveExtension{:memprofile}}) = begin
    if ~(haskey(user.data, "profiler"))
        memdata = Dict{String, Any}("u" => "#eb4034", "a" => "#5bab3e", "d" => 50 => 1.5, "r" => 4, "j" => "#b649b8")
        push!(user.data, "profiler" => memdata)
    end
end

function build_usage_graphic(memdata::Dict{String, <:Any}, u::Number, a::Number, j::Number)
    dimensions::Pair = memdata["d"]
    indicator::Component{:svg} = svg(width =  100percent, 
        height = 100 * percent)
    lessheight = 100percent
    available = Component{:rect}(width = 100percent, height = lessheight)
    used = Component{:rect}("usedmem-indicator", width = (u / a) * 100 * percent, height = lessheight)
    jl_used = Component{:rect}("jlusedmem-indicator", width = (j / a) * 100 * percent, height = lessheight)
    style!(available, "fill" => memdata["a"])
    style!(used, "fill" => memdata["u"], "transition" => 850ms)
    style!(jl_used, "fill" => memdata["j"], "transition" => 850ms)
    style!(indicator, "border-radius" => memdata["r"] * px)
    push!(indicator, available, used, jl_used)
    main_indicator = div("-", children = [indicator])
    style!(main_indicator,
        "width" => dimensions[1] * percent, "height" => dimensions[2] * percent)
    main_indicator::Component{:div}
end

build(c::AbstractConnection, om::Olive.ComponentModifier, oe::Olive.OliveExtension{:memprofile}) = begin
    memdata = c[:OliveCore].users[Olive.getname(c)].data["profiler"]
    free_mem, total_mem, jl_total = (val / 1000000000 for val in (Sys.free_memory(), Sys.total_memory(), Base.summarysize(Main)))
    used = total_mem - free_mem
    indicator = build_usage_graphic(memdata, used, total_mem, jl_total)
    append!(om, "rightmenu", indicator)
end

function on_code_evaluate(c::Connection, cm::Olive.ComponentModifier, oe::Olive.OliveExtension{:profiler}, 
    cell::Olive.Cell{:code}, proj::Olive.Project{<:Any})
    free_mem, total_mem, jl_total = (val / 1000000000 for val in (Sys.free_memory(), Sys.total_memory(), Base.summarysize(Main)))
    used = total_mem - free_mem
    cm["usedmem-indicator"] = "width" => (used / total_mem) * 100 * percent
    cm["jlusedmem-indicator"] = "width" => (jl_total / total_mem) * 100 * percent
end


end # module OliveMemoryProgress
