require "../spec_helper"

module Tdiff::Core
  describe Comparison do
    describe "#outcome" do
      it "identifies same scalar values as equal" do
        comparison = Comparison.new(as_tree("1"), as_tree("1"))
        comparison.outcome.should eq Outcome::Equal
      end

      it "identifies different scalar values as different" do
        comparison = Comparison.new(as_tree("1"), as_tree("2"))
        comparison.outcome.should eq Outcome::Different
      end

      it "identifies different scalar types as different" do
        comparison = Comparison.new(as_tree("\"1\""), as_tree("2"))
        comparison.outcome.should eq Outcome::Different
      end

      it "identifies different types of collection values as different" do
        comparison = Comparison.new(as_tree("[1, 2]"), as_tree("{\"a\": 1}"))
        comparison.outcome.should eq Outcome::Different
      end

      it "identifies two hashes as inconclusive hash" do
        comparison = Comparison.new(as_tree("{\"a\": 1}"), as_tree("{\"b\": 2}"))
        comparison.outcome.should eq Outcome::InconclusiveHash
      end

      it "identifies two arrays as inconclusive array" do
        comparison = Comparison.new(as_tree("[1, 2, 3]"), as_tree("[1, 2, 3]"))
        comparison.outcome.should eq Outcome::InconclusiveArray
      end

      it "identifies a missing value vs a scalar as different" do
        comparison = Comparison.new(nil, as_tree("1"))
        comparison.outcome.should eq Outcome::Different
      end

      it "identifies a missing value vs a collection as different" do
        comparison = Comparison.new(nil, as_tree("[1, 2]"))
        comparison.outcome.should eq Outcome::Different
      end

      it "identifies a nil vs a missing value as different" do
        comparison = Comparison.new(as_tree("nil"), nil)
        comparison.outcome.should eq Outcome::Different
      end
    end

    describe "#difference" do
      it "should indicate when there are different types" do
        comparison = Comparison.new(as_tree("\"1\""), as_tree("1"))
        comparison.difference.left_type.should eq :string
        comparison.difference.right_type.should eq :integer
        comparison.difference.reason.should eq DifferenceReason::ChangedType
      end

      it "should indicate when scalar values are different" do
        comparison = Comparison.new(as_tree("2"), as_tree("1"))
        comparison.difference.left_type.should eq :integer
        comparison.difference.right_type.should eq :integer
        comparison.difference.reason.should eq DifferenceReason::ChangedValue
      end

      it "should indicates when there are more elements to the right" do
        comparison = Comparison.new(nil, as_tree("1"))
        comparison.difference.left_type.should eq :missing
        comparison.difference.right_type.should eq :integer
        comparison.difference.reason.should eq DifferenceReason::ExtraItem
      end

      it "should indicates when there are more elements to the left" do
        comparison = Comparison.new(as_tree("2"), nil)
        comparison.difference.left_type.should eq :integer
        comparison.difference.right_type.should eq :missing
        comparison.difference.reason.should eq DifferenceReason::MissingItem
      end

      it "differentiates between null value and null tree" do
        comparison = Comparison.new(as_tree("null"), nil)
        comparison.difference.left_type.should eq :null
        comparison.difference.right_type.should eq :missing
        comparison.difference.reason.should eq DifferenceReason::MissingItem
      end
    end
  end
end
