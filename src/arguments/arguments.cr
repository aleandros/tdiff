# The input layer of application.
#
# While not in charge of validating correct argument usage from the
# command line, it is in charge of verifying that the given file arguments
# are correct, and return them parsed and validated to the next layer.
#
# Another inmportant aspect that is handled by this layer is the type of
# input provided by the user, since STDIN is a valid stream to use for
# comparing against a file.
#
# Stuff like file existence and readability is also handled at this stage.
#
# If you are still confused of what validations are done here and which ones
# are done during arugment parsing, think of the following:
#
# * OptionParser validates the syntax of the arguments, but gives no meaning to them
# * `Tdiff::Arguments` verifies that the provided arguments are correct and
#   parses them into trees, if possible.
module Tdiff::Arguments
end
