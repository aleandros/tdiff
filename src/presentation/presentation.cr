# The presentation layer is in charge of showing the results to the
# user in a way that makes sense and is easy to understand visually.
#
# While at this moment is perfectly subjective if the results are clear enough,
# the interface of the module remains relatively simple. It just exposes a
# `Tdiff::Presentation::ResultsPresenter` object, but anthing can substitute
# this class as long as it responds to the `#to_s(io)` method.
#
# Maybe after adding more presentation styles, or after allowing parts of the
# presentation to be tweaked at runtime by the user a factory that returns the appropriate
# presenter will make more sense.
module Tdiff::Presentation
end
