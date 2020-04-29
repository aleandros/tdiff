require "../spec_helper"

def io_input
  Tdiff::Arguments::IOInput
end

describe Tdiff::Arguments::IOInput do
  describe "#open" do
    it "should yield the location object" do
      my_io = DummyIO.new
      input = io_input.new(my_io)
      input.open do |io|
        io.should be my_io
      end
    end
  end
end
