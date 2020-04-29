require "../spec_helper"

def file_input
  Tdiff::Arguments::FileInput
end

describe Tdiff::Arguments::FileInput do
  describe "#open" do
    it "should yield the location object" do
      tmp = File.tempfile
      File.write(tmp.path, "test")
      input = file_input.new(tmp.path)
      input.open do |io|
        io.read_string(4).should eq "test"
      end
      tmp.delete
    end
  end
end
