require "../tree"
require "./difference"
require "./difference_reason"
require "./outcome"

module Tdiff::Core
  class Comparison
    getter left : Tdiff::Tree
    getter right : Tdiff::Tree
    @outcome : Outcome | Nil
    @difference : Difference | Nil

    def initialize(@left, @right)
    end

    def outcome
      @outcome ||= if both_hashes?
                     Outcome::InconclusiveHash
                   elsif both_arrays?
                     Outcome::InconclusiveArray
                   elsif left == right
                     Outcome::Equal
                   else
                     Outcome::Different
                   end
    end

    def difference
      @difference ||= Difference.new(
        difference_reason, left, right,
        type(left), type(right)
      )
    end

    private def both_hashes?
      is_hash?(left) && is_hash?(right)
    end

    private def both_arrays?
      is_array?(left) && is_array?(right)
    end

    private def is_hash?(tree)
      !tree.nil? && !tree.as_h?.nil?
    end

    private def is_array?(tree)
      !tree.nil? && !tree.as_a?.nil?
    end

    private def difference_reason : DifferenceReason
      if left.nil?
        DifferenceReason::ExtraItem
      elsif right.nil?
        DifferenceReason::MissingItem
      elsif type(left) != type(right)
        DifferenceReason::ChangedType
      else
        DifferenceReason::ChangedValue
      end
    end

    private def type(tree)
      # TODO: This should be an Enum
      case tree
      when .nil?
        :missing
      when .as_h?
        :hash
      when .as_a?
        :array
      when .as_bool?
        :bool
      when .as_f?
        :float
      when .as_i?
        :integer
      when .as_s?
        :string
      else
        :null
      end
    end
  end
end
