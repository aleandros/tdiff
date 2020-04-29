require "../spec_helper"

def as_input(raw : String)
  Tdiff::Arguments::IOInput.new(IO::Memory.new(raw))
end

def input_parser(raw : String)
  Tdiff::Arguments::InputParser.new(as_input(raw))
end

describe Tdiff::Arguments::InputParser do
  describe "#parse" do
    it "should load json if possible" do
      parser = input_parser <<-JSON
      {"a": 1, "b": [1, 2, 3]}
      JSON
      parser.parse.should be_a JSON::Any
    end

    it "should load yaml if possible" do
      parser = input_parser <<-YAML
      --
      a:
        b: "hola"
      YAML
      parser.parse.should be_a YAML::Any
    end

    it "should raise an error if not able to parse" do
      parser = input_parser <<-YAML
      - bad yaml
      x: ----
      YAML
      expect_raises(Tdiff::Exception, /parse/) do
        parser.parse
      end
    end
  end
end
