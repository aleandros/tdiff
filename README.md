# tdiff

A tool for comparing Tree like files, specifically JSON and YAML

## Installation

TODO: Write installation instructions here

## Usage

Usage: `tdiff [OPTION]... [SOURCE] <TARGET>`

Identifies the differences between two tree-like file structures.

If `<TARGET>` is not present, input is assumed to come from STDIN.
At this moment, only JSON and YAML are supported.

## Development

TODO: Write development instructions here

## TODO
- [x] Compare file to STDIN
- [x] Compare yamls
- [x] Compare json
- [ ] Presentation layer
- [ ] Support more array comparison algorithms
- [ ] Add auto-publish via github actions and installation instructions
- [ ] Fix file permission testing in CI

## Contributing

1. Fork it (<https://github.com/aleandros/tdiff/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Edgar Cabrera](https://github.com/aleandros) - creator and maintainer
