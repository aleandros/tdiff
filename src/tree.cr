require "json"
require "yaml"

# Serves as a way to connect the parsing phase of the application with
# the comparison logic.
#
# It is defined as an alias, due to the (very useful) fact that both
# `JSON::Any` and `YAML::Any` use the same interface at least for the purpose
# of this program.
#
# It can also be `Nil` though, since the lack of a tree still represents the
# absence of a value in a given comparison. This makes it a little bit trickier
# to use since you will need to do nil checks to prevent the compiler from
# complaining, but gives the important advantage of differentiating between
# a lack of value, and an actual null value.
alias Tdiff::Tree = JSON::Any | YAML::Any | Nil
