require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "sign_in page for user" do
      get login_url
      expect(response.status).to eq(200)
    end
  end
  describe "POST /create" do
    it "redirects to root_path if user exists" do
      post sessions_path, params: {
        user: {
          
        }
      }
    end
  end

end
