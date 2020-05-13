# tdiff

A tool for comparing Tree like files, specifically JSON and YAML

## Installation

TODO: Write installation instructions here

## Usage

Usage: `tdiff [OPTION]... [SOURCE] <TARGET>`

Identifies the differences between two tree-like file structures.

If `<TARGET>` is not present, input is assumed to come from STDIN.
At this moment, only JSON and YAML are supported.

An exit status of 1 indicates an error in the program.
An exit status of 127 indicates that there are differences between source
and target.
An exit status of 0 indicates no changes

Example output:

```
$ tdiff shard.yml changed.yml
* me: tdiff -> tdiffo
* authors/0: Edgar Cabrera <edgar.cabrera@pm.me> -> Edgar Cobrera <edgar.cabrera@pm.me>
* crystal: changed type from string to float
- license: MIT
* development_dependencies/ameba/github: crystal-ameba/ameba -> crystal-ameba/amoeba
+ rawr: true
```

## Development

TODO: Write development instructions here

## TODO
- [x] Compare file to STDIN
- [x] Compare yamls
- [x] Compare json
- [x] Presentation layer
- [ ] Support more array comparison algorithms
- [ ] Add auto-publish via github actions and installation instructions
- [ ] Fix file permission testing in CI
- [ ] Allow presentation-level customizations

## Contributing

1. Fork it (<https://github.com/aleandros/tdiff/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Edgar Cabrera](https://github.com/aleandros) - creator and maintainer
