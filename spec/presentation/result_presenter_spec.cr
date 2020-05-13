require "../spec_helper"

module Tdiff::Presentation
  describe ResultPresenter do
    # TODO: fix this since progress dots for `crystal spec` are not showin for these tests
    around_each do |example|
      Colorize.enabled = false
      example.run
      Colorize.enabled = true
    end

    it "renders new item result" do
      path = ["a".as(Tdiff::Core::Segment), "b".as(Tdiff::Core::Segment)]
      result = Tdiff::Core::Result.new(
        path,
        Tdiff::Core::Difference.new(
          Tdiff::Core::DifferenceReason::ExtraItem,
          left: nil, right: as_tree("1"),
          left_type: :missing, right_type: :integer
        )
      )
      ResultPresenter.new(result).to_s.should match(/^\+ a\/b.*1/)
    end

    it "renders missing item result" do
      path = ["a".as(Tdiff::Core::Segment), "b".as(Tdiff::Core::Segment)]
      result = Tdiff::Core::Result.new(
        path,
        Tdiff::Core::Difference.new(
          Tdiff::Core::DifferenceReason::MissingItem,
          left: as_tree("1"), right: nil,
          left_type: :integer, right_type: :missing
        )
      )
      ResultPresenter.new(result).to_s.should match(/^\- a\/b.*1/)
    end

    it "renders changed type result" do
      path = ["a".as(Tdiff::Core::Segment), "b".as(Tdiff::Core::Segment)]
      result = Tdiff::Core::Result.new(
        path,
        Tdiff::Core::Difference.new(
          Tdiff::Core::DifferenceReason::ChangedType,
          left: as_tree("1"), right: as_tree("true"),
          left_type: :integer, right_type: :bool
        )
      )
      ResultPresenter.new(result).to_s.should match(/^\* a\/b.*type.*integer.*bool/)
    end

    it "renders changed value result" do
      path = ["a".as(Tdiff::Core::Segment), "b".as(Tdiff::Core::Segment)]
      result = Tdiff::Core::Result.new(
        path,
        Tdiff::Core::Difference.new(
          Tdiff::Core::DifferenceReason::ChangedValue,
          left: as_tree("1"), right: as_tree("2"),
          left_type: :integer, right_type: :integer
        )
      )
      ResultPresenter.new(result).to_s.should match(/^\* a\/b.*1.*2/)
    end
  end
end
