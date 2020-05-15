require "../spec_helper"

def subject
  Tdiff::Arguments::Extractor
end

describe Tdiff::Arguments::Extractor do
  describe "#initialize" do
    it "should fail if source does not exist" do
      expect_raises(Tdiff::Exception, "'missing' is not a file") do
        subject.new("missing", nil)
      end
    end

    it "should fail if source is provided but is not a file" do
      tempfile = File.tempfile
      expect_raises(Tdiff::Exception, /is not a file/) do
        subject.new(File.dirname(tempfile.path), nil)
      end
      tempfile.delete
    end

    it "should fail if target is provided but does not exist" do
      tempfile = File.tempfile
      expect_raises(Tdiff::Exception, "'missing' is not a file") do
        subject.new(tempfile.path, "missing")
      end
      tempfile.delete
    end

    it "should fail if target is provided but is not a file" do
      tempfile = File.tempfile
      expect_raises(Tdiff::Exception, /is not a file/) do
        subject.new(tempfile.path, File.dirname(tempfile.path))
      end
      tempfile.delete
    end

    it "should fail if target is not provided and STDIN is tty" do
      tempfile = File.tempfile
      expect_raises(Tdiff::Exception, "no target to compare") do
        my_stdin = DummyIO.new
        subject.new(tempfile.path, nil, my_stdin)
      end
      tempfile.delete
    end

    it "should fail if source is not readable" do
      source = File.tempfile
      target = File.tempfile
      File.chmod(source.path, 0)
      expect_raises(Tdiff::Exception, /not readable/) do
        subject.new(source.path, target.path)
      end
      source.delete
      target.delete
    end

    it "should fail if target is not readable" do
      source = File.tempfile
      target = File.tempfile
      File.chmod(target.path, 0)
      expect_raises(Tdiff::Exception, /not readable/) do
        subject.new(source.path, target.path)
      end
      source.delete
      target.delete
    end
  end

  describe "#source" do
    it "should return a file input" do
      source = File.tempfile
      target = File.tempfile
      handler = subject.new(source.path, target.path)
      handler.source.location.should eq source.path
      source.delete
      target.delete
    end
  end

  describe "#target" do
    it "should return a file input if provided" do
      source = File.tempfile
      target = File.tempfile
      handler = subject.new(source.path, target.path)
      handler.target.location.should eq target.path
      source.delete
      target.delete
    end

    it "should return default target if target name not provided" do
      source = File.tempfile
      my_stdin = DummyIO.new
      my_stdin.is_tty = false
      handler = subject.new(source.path, nil, my_stdin)
      handler.target.location.should be my_stdin
      source.delete
    end
  end
end
