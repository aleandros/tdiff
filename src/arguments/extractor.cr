require "./file_input"
require "./io_input"

class Tdiff::Arguments::Extractor
  getter source_name : String
  getter target_name : String | Nil
  getter default_target : IO

  def initialize(@source_name, @target_name, @default_target = STDIN)
    validate_file(source_name)

    if target_name
      validate_file(target_name.as(String))
    elsif default_target.tty?
      raise Tdiff::Exception.new("no target to compare")
    end
  end

  def source
    FileInput.new(source_name)
  end

  def target
    if target_name
      FileInput.new(target_name.as(String))
    else
      IOInput.new(default_target)
    end
  end

  private def validate_file(name : String)
    if !File.file? name
      raise Tdiff::Exception.new("'#{name}' is not a file")
    elsif !File.readable? name
      raise Tdiff::Exception.new("'#{name}' is not readable")
    end
  end
end
