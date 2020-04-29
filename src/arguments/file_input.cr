require "./input"

class Tdiff::Arguments::FileInput < Tdiff::Arguments::Input
  def open(&block : IO ->)
    File.open(location.as(String)) do |file|
      block.call(file)
    end
  end
end
