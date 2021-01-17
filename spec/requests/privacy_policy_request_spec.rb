require 'rails_helper'

RSpec.describe "PrivacyPolicies", type: :request do

  describe "GET /top" do
    it "returns http success" do
      get "/privacy_policy/top"
      expect(response).to have_http_status(:success)
    end
  end

end
