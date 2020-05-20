require "spec"
require "../src/*"

class DummyIO < IO::Memory
  property is_tty : Bool = true

  def tty?
    is_tty
  end
end

def as_tree(data : String) : Tdiff::Tree
  YAML.parse(data).as(Tdiff::Tree)
end
