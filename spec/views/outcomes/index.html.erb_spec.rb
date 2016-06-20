require 'rails_helper'

RSpec.describe "outcomes/index", type: :view do
  before(:each) do
    assign(:outcomes, [
      Outcome.create!(
        :winner => "Winner",
        :team_stats_id => 1,
        :match_length => 2
      ),
      Outcome.create!(
        :winner => "Winner",
        :team_stats_id => 1,
        :match_length => 2
      )
    ])
  end

  it "renders a list of outcomes" do
    render
    assert_select "tr>td", :text => "Winner".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end