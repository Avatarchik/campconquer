require 'rails_helper'

RSpec.describe "team_outcomes/edit", type: :view do
  before(:each) do
    @team_outcome = assign(:team_outcome, TeamOutcome.create!(
      :team => "blue",
      :takedowns => 1,
      :throws => 1,
      :pickups => 1
    ))
  end

  it "renders the edit team_outcome form" do
    render

    assert_select "form[action=?][method=?]", team_outcome_path(@team_outcome), "post" do

      assert_select "input#team_outcome_team[name=?]", "team_outcome[team]"

      assert_select "input#team_outcome_takedowns[name=?]", "team_outcome[takedowns]"

      assert_select "input#team_outcome_throws[name=?]", "team_outcome[throws]"

      assert_select "input#team_outcome_pickups[name=?]", "team_outcome[pickups]"
    end
  end
end
