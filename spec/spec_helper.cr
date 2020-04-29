require "spec"
require "../src/arguments/*"
require "../src/tree"
require "../src/exception"

class DummyIO < IO::Memory
  property is_tty : Bool = true

  def tty?
    is_tty
  end
end
