require 'rails_helper'

RSpec.describe "Categorys", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/categorys/show"
      expect(response).to have_http_status(:success)
    end
  end

end
