require 'rails_helper'

RSpec.describe User, type: :model do
  
	subject { User.new(username: "xyz", email: "x123@gmail.com", password: "1234", password_confirmation: "1234") }

	before do
		subject.save
	end
	context "associations" do
		it { should have_many(:stocks) }
	end

  context "validation tests" do
		
		it "username should not be null" do
			subject.username = nil
			expect(subject).to_not be_valid
		end

		it "email should not be null" do
			subject.email = nil
			expect(subject).to_not be_valid
		end

		it "password should not be null" do
			subject.password = nil
			expect(subject).to_not be_valid
		end

		it "password and password-confirmation should match" do
			expect(subject.password_confirmation).to eql(subject.password)
		end

		it "is valid with valid-attributes" do
			expect(subject).to be_valid
		end

		it "username should not be too short" do
			subject.username = "z"
			expect(subject).to_not be_valid
		end

		it "username should not be too long" do
			subject.username = "z" * 51
			expect(subject).to_not be_valid
		end

		it "email should be unique" do
			user2 = User.new(username: "z", email: "123@gmail.com", password: "1234", password_confirmation: "1234")
			expect(subject.email).to_not eql(user2.email)
		end

	end

	context "scope tests" do
	end

end
