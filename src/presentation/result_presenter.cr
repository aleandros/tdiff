require "colorize"
require "../core/result"
require "../core/difference_reason"

module Tdiff::Presentation
  class ResultPresenter
    getter result : Tdiff::Core::Result

    def initialize(@result)
    end

    def to_s(io)
      case result.difference.reason
      when Tdiff::Core::DifferenceReason::ExtraItem
        io << "+ #{path}: ".colorize(:green).to_s
        io << difference.right.colorize(:green).mode(:bold).to_s
      when Tdiff::Core::DifferenceReason::MissingItem
        io << "- #{path}: ".colorize(:red).to_s
        io << difference.left.colorize(:red).mode(:bold).to_s
      when Tdiff::Core::DifferenceReason::ChangedType
        io << "* #{path}: ".colorize(:yellow).to_s
        changed_type(io)
      when Tdiff::Core::DifferenceReason::ChangedValue
        io << "* #{path}: ".colorize(:yellow).to_s
        changed_value(io)
      end
    end

    private def path
      result.path.join("/")
    end

    private def changed_value(io)
      "#{difference.left} -> #{difference.right}".colorize(:yellow).mode(:bold).to_s(io)
    end

    private def changed_type(io)
      "changed type from #{result.difference.left_type} to #{result.difference.right_type}"
        .colorize(:yellow).mode(:bold).to_s(io)
    end

    private def difference
      result.difference
    end
  end
end
