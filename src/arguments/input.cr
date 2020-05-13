require "../tree"
require "./input_parser"

abstract class Tdiff::Arguments::Input
  property location : String | IO
  @tree : Tdiff::Tree

  def initialize(@location)
  end

  abstract def open(&block : IO ->)

  def tree : Tdiff::Tree
    if @tree.nil?
      @tree = InputParser.new(self).parse
    else
      @tree
    end.as(Tdiff::Tree)
  end
end
