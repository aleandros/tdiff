# tdiff

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
- [ ] Add portable binaries for OSX and Windows
- [ ] Support more array comparison algorithms
- [ ] Fix file permission testing in CI
- [ ] Allow presentation-level customizations at runtime

## Contributing

1. Fork it (<https://github.com/aleandros/tdiff/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Edgar Cabrera](https://github.com/aleandros) - creator and maintainer
