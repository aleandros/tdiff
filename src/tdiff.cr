require "yaml"
require "json"
require "option_parser"

require "./exception"
require "./arguments/extractor"
require "./core/comparator"

# Tdiff is a CLI utility for comparing tree-like files (json/yaml).
module Tdiff
  VERSION = "0.1.0"

  def self.fail_with_help(message : String, parser : OptionParser)
    STDERR.puts "ERROR: #{message}"
    STDERR.puts ""
    STDERR.puts parser
    exit(1)
  end

  OptionParser.parse do |parser|
    parser.banner = "Usage: tdiff [OPTION]... [SOURCE] <TARGET>"
    parser.separator <<-TEXT
    Identifies the differences between two tree-like file structures.

    If <TARGET> is not present, input is assumed to come from STDIN.
    At this moment, only JSON and YAML are supported.

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
          comparator = Core::Comparator.new
          comparator.compare(extractor.source.tree, extractor.target.tree)
          comparator.results.each do |result|
            puts result
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
