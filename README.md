# tdiff

[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?style=flat-square)](https://crystal-lang.org/)
[![CI](https://github.com/aleandros/tdiff/workflows/CI/badge.svg)](https://github.com/aleandros/tdiff/actions?query=workflow%3ACI)
[![Latest release](https://img.shields.io/github/release/aleandros/tdiff.svg)](https://github.com/aleandros/tdiff/releases)

A tool for comparing Tree like files, specifically JSON and YAML

## Installation

Right now, simply go to the [releases page](https://github.com/aleandros/tdiff/releases) and download
the latest binary to your prefered directory in your path (like `/usr/local/bin`). 

Right now I'm unable to create a statically linked binary for OSX and Windows (help wanted!).

If you want to build it for your platform, download crystal and compile it. For example, in OSX:

```
$ brew install crystal
$ git clone https://github.com/aleandros/tdiff/
$ cd tdiff && shards build --production --release --no-debug
```

The binary will live in `bin/tdiff`. You can move it to your path after that.

## Usage as a binary

Usage: `tdiff [OPTION]... [SOURCE] <TARGET>`

Identifies the differences between two tree-like file structures.

If `<TARGET>` is not present, input is assumed to come from STDIN.
At this moment, only JSON and YAML are supported.

An exit status of 1 indicates an error in the program.
An exit status of 127 indicates that there are differences between source
and target.
An exit status of 0 indicates no changes

Example output:

```shell
$ tdiff shard.yml changed.yml
* me: tdiff -> tdiffo
* authors/0: Edgar Cabrera <edgar.cabrera@pm.me> -> Edgar Cobrera <edgar.cabrera@pm.me>
* crystal: changed type from string to float
- license: MIT
* development_dependencies/ameba/github: crystal-ameba/ameba -> crystal-ameba/amoeba
+ rawr: true
```

## Usage as a shard

Add it to your application shards:

```yaml
dependencies:
  tdiff:
    github: aleandros/tdiff
```

It just requires a couple of IO objects, containing the YAML or JSON data, 
and returns a list of `Tdiff:Core::Result` objects.

```crystal
require 'tdiff'

comparator = Tdiff.compare(File.open('target_1.yml'), File.open('target_2.yml'))
comparator.compare
comparator.results.each do |result|
  puts "#{result.path.join(".")}: #{result.difference.reason}"
end
```

If any of the inputs cannot be parsed, this method will raise a `Tdiff::Exception` error.

## Development

This is a pretty standard crystal project. So install crystal with your prefered method.

First install dependencies with `shards install`.

Remember to run:

* Tests with `crystal spec`
* Format with `crystal tool format`
* Ameba checks with `bin/ameba`

This will be checked by CI but still save yourself some time.

## TODO
- [x] Compare file to STDIN
- [x] Compare yamls
- [x] Compare json
- [x] Presentation layer
- [x] Add auto-publish via github actions and installation instructions
- [ ] Add portable binaries for OSX (or homebrew package)
- [ ] Publish as snap package
- [x] Add portable binary for Windows
- [ ] Support more array comparison algorithms
- [x] Fix file permission testing in CI
- [ ] Allow presentation-level customizations at runtime
- [x] Allow `Tdiff::Core` to be used as a library

## Contributing

1. Fork it (<https://github.com/aleandros/tdiff/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Edgar Cabrera](https://github.com/aleandros) - creator and maintainer
