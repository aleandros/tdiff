require "colorize"
require "../core/result"
require "./result_presenter"

module Tdiff::Presentation
  class ResultsPresenter
    getter results : Array(Tdiff::Core::Result)

    def initialize(@results)
      Colorize.on_tty_only!
    end

    def to_s(io)
      results[..-2].each do |result|
        ResultPresenter.new(result).to_s(io)
        io << "\n"
      end
      ResultPresenter.new(results[-1]).to_s(io)
    end
  end
end
