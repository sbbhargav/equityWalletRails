require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "sign_in page for user" do
      get login_url
      expect(response.status).to eq(200)
    end
  end
  

end
