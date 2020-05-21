require "../tree"

class Tdiff::Arguments::InputParser
  getter input : Input

  def initialize(@input)
  end

  def parse : Tdiff::Tree
    tree : Tdiff::Tree | Nil = nil

    begin
      input.open do |io|
        tree = JSON.parse io
      end
    rescue JSON::ParseException
      begin
        input.open do |io|
          tree = YAML.parse io
        end
      rescue YAML::ParseException
        raise Tdiff::Exception.new("cannot parse input '#{input.location}'")
      end
    end

    tree.as(Tdiff::Tree)
  end
end
