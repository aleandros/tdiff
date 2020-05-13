require "../spec_helper"

module Tdiff::Core
  describe Comparator do
    it "obtains the results for comparing two nested hashes" do
      tree_1 = as_tree <<-YAML
      a: 2
      b:
        c: 1
        d: 0
      YAML
      tree_2 = as_tree <<-YAML
      a: 1
      b:
        c: 2
      YAML
      comparator = Comparator.new
      comparator.compare(tree_1, tree_2)
      comparator.results.size.should eq 3
    end

    it "obtains results for comparing hashes with integer and boolean keys" do
      tree_1 = as_tree <<-YAML
      1: 2
      a: 1
      YAML
      tree_2 = as_tree <<-YAML
      1: 3
      true: 1
      YAML
      comparator = Comparator.new
      comparator.compare(tree_1, tree_2)
      comparator.results.size.should eq 3
    end

    it "obtains results for comparing hashes with float keys" do
      tree_1 = as_tree <<-YAML
      0.1: 1
      YAML
      tree_2 = as_tree <<-YAML
      0.1: 2
      YAML
      comparator = Comparator.new
      comparator.compare(tree_1, tree_2)
      comparator.results.size.should eq 1
    end

    it "obtains results for comparing arrays" do
      tree_1 = as_tree <<-YAML
      a:
        - a
        - b
        - c
      YAML
      tree_2 = as_tree <<-YAML
      a:
        - a
        - 1
      YAML
      comparator = Comparator.new
      comparator.compare(tree_1, tree_2)
      comparator.results.size.should eq 2
    end
  end
end
