require "./difference"

module Tdiff::Core
  alias Segment = String | Int32 | Float64 | Bool

  struct Result
    getter path : Array(Segment)
    getter difference : Difference

    def initialize(@path, @difference)
    end
  end
end
