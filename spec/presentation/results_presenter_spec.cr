require "../spec_helper"

module Tdiff::Presentation
  describe ResultsPresenter do
    it "correctly adds new lines between results" do
      path_1 = ["a".as(Tdiff::Core::Segment), "b".as(Tdiff::Core::Segment)]
      path_2 = ["a".as(Tdiff::Core::Segment), "c".as(Tdiff::Core::Segment)]
      results = [
        Tdiff::Core::Result.new(
          path_1,
          Tdiff::Core::Difference.new(
            Tdiff::Core::DifferenceReason::ExtraItem,
            left: nil, right: as_tree("1"),
            left_type: :missing, right_type: :integer
          )
        ),
        Tdiff::Core::Result.new(
          path_2,
          Tdiff::Core::Difference.new(
            Tdiff::Core::DifferenceReason::ChangedValue,
            left: as_tree("2"), right: as_tree("1"),
            left_type: :interger, right_type: :integer
          )
        ),
      ]
      ResultsPresenter.new(results).to_s.split("\n").size.should eq 2
    end
  end
end
