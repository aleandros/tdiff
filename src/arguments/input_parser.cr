require "../tree"

class Tdiff::Arguments::InputParser
  getter input : Input

  def initialize(@input)
  end

  def parse : Tdiff::Tree
    tree : Tdiff::Tree | Nil = nil

    input.open do |io|
      tree = JSON.parse io
    rescue JSON::ParseException
      begin
        tree = YAML.parse io
      rescue YAML::ParseException
        raise Tdiff::Exception.new("cannot parse input '#{input.location}'")
      end
    end

    tree.as(Tdiff::Tree)
  end
end
