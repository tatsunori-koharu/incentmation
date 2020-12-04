require 'rails_helper'

RSpec.describe "Donkeykings", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/donkeykings/new"
      expect(response).to have_http_status(:success)
    end
  end

end
