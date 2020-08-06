module FYW

using Pkg
using Pkg.Types: VersionSpec, semver_spec
using Test

export test_package_version
export CompatNotFound, PackageNotInCompat, VersionNotCompatible

struct CompatNotFound <: Exception
    message::String
end
show(io::IO, e::CompatNotFound) = println(io, e.message)

struct PackageNotInCompat <: Exception
    message::String
end
show(io::IO, e::PackageNotInCompat) = println(io, e.message)

struct VersionNotCompatible <: Exception
    message::String
end
show(io::IO, e::VersionNotCompatible) = println(io, e.message)

"""
    test_package_version(package_name::String, version::String)

Check to see if package_name@version is inbounds with the compat section in your Project.toml

# Arguments
- `package_name::String`: Name of the package
- `version::String`: Package version to check being inbounds

# Keywords
- `toml_path::String`: Path to the Project.toml file

# Returns
- `Bool`: If the version is in the compat versions

# Throws
- `PackageNotInCompat`: package_name was not found in the compat section
- `CompatNotFound`: Compat section not found in the Project.toml
- `VersionOutsideSpec`: Version is no longer inbounds of the compat versions
"""
function test_package_version(package_name::String, version::String; toml_path=joinpath(@__DIR__, "..", "Project.toml"))
    version = VersionSpec(version)
    toml = Pkg.TOML.parsefile(toml_path)

    if haskey(toml, "compat")
        if haskey(toml["compat"], package_name)
            compat_version = semver_spec(toml["compat"][package_name])

            if !isempty(intersect(version, compat_version))
                return true
            else
                throw(VersionNotCompatible("$package_name@$version is not support"))
            end
        else
            throw(PackageNotInCompat("$package_name not found in compat section"))
        end
    else
        throw(CompatNotFound("Compat section not found in Project.toml"))
    end
end

test_package_version(package_name::String, version::Int64; kwargs...) = test_package_version(package_name, string(version); kwargs...)
test_package_version(package_name::String, version::Float64; kwargs...) = test_package_version(package_name, string(version); kwargs...)
test_package_version(package_name::String, version::VersionNumber; kwargs...) = test_package_version(package_name, string(version); kwargs...)

end  # module
