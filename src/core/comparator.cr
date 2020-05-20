require "./result"
require "./outcome"
require "./comparison"

module Tdiff::Core
  class Comparator
    getter results : Array(Result)
    getter left_tree : Tdiff::Tree
    getter right_tree : Tdiff::Tree

    def initialize(@left_tree, @right_tree, @results = [] of Result)
    end

    def compare
      compare(left_tree, right_tree)
    end

    private def compare(left : Tdiff::Tree, right : Tdiff::Tree, path = [] of Segment)
      comparison = Comparison.new(left, right)
      case comparison.outcome
      when Outcome::Equal
      when Outcome::Different
        results << Result.new(path.clone, comparison.difference)
      when Outcome::InconclusiveHash
        if !left.nil? && !right.nil?
          compare(left.as_h, right.as_h, path)
        end
      else
        if !left.nil? && !right.nil?
          compare(left.as_a, right.as_a, path)
        end
      end
    end

    private def compare(left : Hash, right : Hash, path : Array(Segment))
      keys = Set(Segment).new
      left.keys.map do |key|
        keys.add(raw_key(key))
      end
      right.keys.map do |key|
        keys.add(raw_key(key))
      end

      keys.each do |key|
        left_value = left[key]?
        right_value = right[key]?
        new_path = path + [key]
        compare(left_value, right_value, new_path)
      end
    end

    private def compare(left : Array, right : Array, path : Array(Segment))
      size = Math.max(left.size, right.size)

      size.times do |i|
        left_value = left[i]?
        right_value = right[i]?
        new_path = path + [i]
        compare(left_value, right_value, new_path)
      end
    end

    private def raw_key(input : YAML::Any | JSON::Any | Segment) : Segment
      case input
      when YAML::Any
        cast_tree_value(input)
      when JSON::Any
        cast_tree_value(input)
      else
        input
      end
    end

    private def cast_tree_value(input : YAML::Any | JSON::Any) : Segment
      case input
      when .as_f?
        input.as_f
      when .as_i?
        input.as_i
      when .as_bool?
        input.as_bool
      else
        input.as_s
      end
    end
  end
end
