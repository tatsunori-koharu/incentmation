require 'rails_helper'

RSpec.describe "ChatMessages", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/chat_messages/new"
      expect(response).to have_http_status(:success)
    end
  end

end
