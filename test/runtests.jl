using FixYourWorkaround
using Test

package_name = "package"
dir = mktempdir()
toml_path = joinpath(dir, "Project.toml")

@testset "Exceptions" begin
    @testset "CompatNotFound" begin
        write(toml_path, "")

        @test_throws CompatNotFound test_package_version(package_name, "0.0"; toml_path=toml_path)
    end

    @testset "PackageNotInCompat" begin
        write(toml_path, "[compat]")

        @test_throws PackageNotInCompat test_package_version(package_name, "0.0"; toml_path=toml_path)
    end 
end

@testset "Package outside of Versions" begin
    write(
        toml_path,
        """
        [compat]
        $package_name = "1"
        """
    )

    @test_throws VersionNotCompatible test_package_version(package_name, "0.0"; toml_path=toml_path)
end

@testset "Package in Versions" begin
    write(
        toml_path,
        """
        [compat]
        $package_name = "1"
        """
    )

    @test test_package_version(package_name, "1.1"; toml_path=toml_path)
end

@testset "Version::Int64" begin
    write(
        toml_path,
        """
        [compat]
        $package_name = "1"
        """
    )

    @test test_package_version(package_name, 1; toml_path=toml_path)
end

@testset "Version::Float64" begin
    write(
        toml_path,
        """
        [compat]
        $package_name = "1"
        """
    )

    @test test_package_version(package_name, 1.0; toml_path=toml_path)
end

@testset "Version::VersionNumber" begin
    write(
        toml_path,
        """
        [compat]
        $package_name = "1"
        """
    )

    @test test_package_version(package_name, v"1"; toml_path=toml_path)
end
