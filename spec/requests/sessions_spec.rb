require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "sign_in page for user" do
      get login_url
      expect(response.status).to eq(200)
    end
  end
  describe "POST /create" do
    let(:user) {
      User.create(username: 'helloguru', email: 'ss@gmail.com', password: '1234', password_confirmation: '1234')
    }
    context "with valid credentials" do
      it "redirects to root path" do
        post sessions_url , params: {
            email: user.email,
            password: user.password
        }
      expect(response).to redirect_to(root_path)
      end
    end
    context "with invalid credentials" do
      it "redirects to sign in page again!!" do
        post sessions_url , params: {
            email: 'x@gmail.com',
            password: '1234'
        }
      expect(response.body).to include('Invalid email or password')
      expect(response).to render_template(:new)
      end
    end
  end
  describe "destroy /delete" do
    it "redirects to login page" do
      delete logout_path
      expect(response).to redirect_to(root_path)
    end
  end

end
