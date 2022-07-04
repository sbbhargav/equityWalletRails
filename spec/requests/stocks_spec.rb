require 'rails_helper'

RSpec.describe "Stocks", type: :request do
  let(:user) {
    User.create(username: 'helloguru', email: 'ss@gmail.com', password: '1234', password_confirmation: '1234')
  }
  describe "GET /index" do
    it "current_user stocks are displayed" do
      session[:user_id] = 1
      get stocks_url
      expect(response.status).to eq(200)
    end
  end
end
