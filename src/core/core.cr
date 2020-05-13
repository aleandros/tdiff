# The core module is in charge of comparing already parsed `Tdiff::Tree` objects
# and returning an array of `Tdiff::Core::Result`.
#
# The way it works, in general, is the following:
#
# A `Tdiff::Core::Comparator` receives two trees. Navigates them recursively, and
# whenever it encounters a scalar value on either side, it uses a `Tdiff::Core::Comparison`,
# and if there's a difference it is stored for later use.
#
# Note that the reason of the determined difference is also stored  on the `Tdiff::Core::Result`
# object, by way of the enumeration `Tdiff::Core::DifferenceReason`
#
# There's still no way to add custom or different algorithms for the tree comparison
# (which for example, could benefit of a non-recursive approach or even a parallel one
# for VERY large files).
module Tdiff::Core
end
