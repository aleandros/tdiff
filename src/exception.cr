# Represents a general exception for the application.
#
# An exception of this type must usually mean that there's a problem
# with the user's environment that prevents the program from completing
# (think of something like a file you cannot read). Think of 4XX errors
# in HTTP.
#
# Any other unexpected exception is better to let it bubble to the user since
# that likely means there's a bug in the program. Think of 5XX errors in HTTP.
#
# It is encouraged that any exception defined in the program extends
# from this one.
class Tdiff::Exception < Exception
end
