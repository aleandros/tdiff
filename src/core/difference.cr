require "./difference_reason"

module Tdiff::Core
  struct Difference
    getter reason : DifferenceReason
    getter left : Tdiff::Tree
    getter right : Tdiff::Tree
    getter left_type : Symbol
    getter right_type : Symbol

    def initialize(@reason, @left, @right, @left_type, @right_type)
    end
  end
end
