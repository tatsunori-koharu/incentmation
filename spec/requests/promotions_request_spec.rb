require 'rails_helper'

RSpec.describe "Promotions", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/promotions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/promotions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/promotions/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/promotions/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
