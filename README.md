## Fix Your Workaround.jl

[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![Coverage Status](https://coveralls.io/repos/github/mattBrzezinski/FixYourWorkaround.jl/badge.svg?branch=MB/travis)](https://coveralls.io/github/mattBrzezinski/FixYourWorkaround.jl?branch=MB/travis)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)

Have you ever created a work around because of a specific dependency version?
This package is a test utility to ensure you remember to fix your workaround after support for it has been dropped.

Whenever you create a workaround and plan to remove it after you drop version support for a package create a new test like so:

```julia
using FixYourWorkaround

@test package_compatible("Package", "Version")
```

In the future when you remove the version from the `compat` section of your Project.toml this test will fail and remind you to remove your workaround.
