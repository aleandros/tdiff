require "./input"

class Tdiff::Arguments::IOInput < Tdiff::Arguments::Input
  def open(&block : IO ->)
    block.call(location.as(IO))
  end
end
