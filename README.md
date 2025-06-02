# Stingray.jl
Julia porting of Stingray

## Requirements

- Julia 1.11 or higher

## Installation

Add Stingray to your Julia environment:

```julia
import Pkg; Pkg.add("Stingray")
```

Or for local development:

```julia
import Pkg; Pkg.develop(path="/path/to/Stingray.jl")
```

## Usage

```julia
using Stingray
gti = load_gtis("path/to/your/event_file.evt")
```

## Testing

Run the test suite:

```bash
julia --project . -e 'using Pkg; Pkg.instantiate(); Pkg.test()'
```

## Documentation

Build the documentation:

```bash
cd docs
julia --project . docs/make.jl
```

Or in one line:

```bash
julia --project=docs -e 'using Pkg; Pkg.instantiate()'; julia --project=docs docs/make.jl
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
