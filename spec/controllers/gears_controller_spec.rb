require 'rails_helper'

describe GearsController, type: :controller do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GamesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:trucker_cap_attrs) {
    {
      name: 'trucker_cap',
      display_name: 'Trucker Cap',
      description: 'good for long rides',
      health_bonus: 1,
      speed_bonus: 4,
      range_bonus: 2,
      gear_type: 'head',
      asset_name: nil,
      icon_name: nil,
      gold: 0,
      gems: 0,
      level: 0
    }
  }

  before do
    request.accept = "application/json"
  end

  describe "GET /gears" do
    let!(:trucker_cap) {
      Gear.create trucker_cap_attrs
    }

    it "returns all gears as json" do
      get :index, {}, valid_session

      expect(response_json).to include({'status' => 'ok'})
      expect(response_json).to include('gears')
      expect(response_json['gears']).to include(trucker_cap_attrs.stringify_keys)
    end

  end
end