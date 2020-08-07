## Fix Your Workaround.jl

Have you ever created a work around because of a specific dependency version?
This package is a test utility to ensure you remember to fix your workaround after support for it has been dropped.

Whenever you create a workaround and plan to remove it after you drop version support for a package create a new test like so:

```julia
using FixYourWorkaround

@test package_compatible("Package", "Version")
```

In the future when you remove the version from the `compat` section of your Project.toml this test will fail and remind you to remove your workaround.
