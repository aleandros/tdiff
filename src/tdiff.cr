require "yaml"
require "json"
require "option_parser"

require "./exception"
require "./arguments/extractor"
require "./presentation/results_presenter"

require "./core/*"
require "./tree"

# Tdiff is a CLI utility for comparing tree-like files (json/yaml).
#
# You can check out the source code at github: https://github.com/aleandros/tdiff
#
# There are three main layers to the structure of the application:
#
# * `Tdiff::Arguments` is in charge of handling user input and properly parse
#   the given input files. The resulting data structure that's of interest is
#   `Tdiff::Tree`, which is a general representation of a tree input source that
#   ultimately feeds the core of the comparison algorithm.
#
# * `Tdiff::Core` handles the output from the Arguments layer and executes the
#   appropriate comparisons, ultimately returning an `Array(Tdiff::Core::Result)`.
#   An individual `Tdiff::Core::Result` object contains the difference between the two
#   leafs and the path that lead to them.
#
# * `Tdiff::Presentation` uses the array of result objects for presenting the data to
#   the user, depending on the desired format.
#
# This file serves as an entrypoint for the application, and essentially handles the
# arguments with OptionParser and connects the aforementioned layers.
module Tdiff
  VERSION = "0.2.1"

  # This is the main entrypoint for using Tdiff as a library. It just requires a couple of IO
  # objects, containing the YAML or JSON data, and returns a list of `Tdiff:Core::Result` objects.
  #
  # ```
  # require 'tdiff'
  #
  # comparator = Tdiff.compare(File.open('target_1.yml'), File.open('target_2.yml'))
  # comparator.compare
  # comparator.results.each do |result|
  #   puts "#{result.path.join(".")}: #{result.difference.reason}"
  # end
  # ```
  #
  # If any of the inputs cannot be parsed, this method will raise a `Tdiff::Exception` error.
  def self.compare(source : IO, target : IO)
    tree_1 = Arguments::InputParser.new(source).tree
    tree_2 = Arguments::InputParser.new(source).tree
    comparator = Core::Comparator.new(tree_1, tree_2)
    comparator.results
  end

  # Prints usage error in the program arguments and terminates the program.
  #
  # A utility function that simply prints an error to STDERR and the program's help
  # (since this should be used for indicating an error by the user in the provided)
  # parameters.
  def self.fail_with_help(message : String, parser : OptionParser)
    STDERR.puts "ERROR: #{message}"
    STDERR.puts ""
    STDERR.puts parser
    exit(1)
  end

  # This method is intended to be used for the CLI program.
  # The reason is that by encapsulating it, tdiff can be required as a library,
  # and the `main.cr` file actually calls this function.
  def self.main
    OptionParser.parse do |parser|
      parser.banner = "Usage: tdiff [OPTION]... [SOURCE] <TARGET>"
      parser.separator <<-TEXT
      Identifies the differences between two tree-like file structures.

      If <TARGET> is not present, input is assumed to come from STDIN.
      At this moment, only JSON and YAML are supported.

      An exit status of 1 indicates an error in the program.
      An exit status of 127 indicates that there are differences between source
      and target.
      An exit status of 0 indicates no changes

      TEXT

      parser.on("-v", "--version", "Shows current version") do
        puts VERSION
        exit
      end
      parser.on("-h", "--help", "Show this help") do
        puts parser
        exit
      end
      parser.missing_option do |option_flag|
        Tdiff.fail_with_help("#{option_flag} expected an argument", parser)
      end
      parser.invalid_option do |option_flag|
        Tdiff.fail_with_help("unreconized option #{option_flag}", parser)
      end
      parser.unknown_args do |args|
        if args.empty?
          Tdiff.fail_with_help("at least one argument is required", parser)
        elsif args.size > 2
          Tdiff.fail_with_help("too many arguments given", parser)
        else
          begin
            extractor = Arguments::Extractor.new(args[0], args[1]?)
            comparator = Core::Comparator.new(extractor.source.tree, extractor.target.tree)
            comparator.compare
            if comparator.results.size == 0
              exit(0)
            else
              puts Presentation::ResultsPresenter.new(comparator.results)
              exit(127)
            end
          rescue ex : Tdiff::Exception
            STDERR.puts "ERROR: #{ex.message}"
            exit 1
          rescue ex
            STDERR.puts "UNEXPECTED APPLICATION ERROR: #{ex.message}"
            exit 1
          end
        end
      end
    end
  end
end
