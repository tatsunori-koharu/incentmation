require 'rails_helper'

RSpec.describe "ArticleLikes", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/article_likes/create"
      expect(response).to have_http_status(:success)
    end
  end

end
