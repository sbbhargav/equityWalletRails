require 'rails_helper'

RSpec.describe Stock, type: :model do
  

  subject(:user) {
    User.new(id: 1,username: "xyz", email: "x123@gmail.com", password: "1234", password_confirmation: "1234")
  }
  subject(:stock) {
   user.stocks.build(id: 1,companyname: "zzz",stockprice: 12000)
  }

  before do
    user.save
    stock.save
  end

  context "associations" do
		it "stock has many transactions" do
      should have_many(:transactions)
    end

    it "stock should belongs to perticular user" do
      should belong_to(:user)
    end
	end

  context "validations" do

    it "create stocks for user" do
      expect(stock.valid?).to be(true)
    end

    it "company name can't be blank" do
      stock.companyname = nil
      expect(stock).to_not be_valid
    end

    it "stockprice can't be blank" do
      stock.stockprice = nil
      expect(stock).to_not be_valid
    end

    it "stockprice should be integer" do
      stock.stockprice = "a"
      expect(stock).to_not be_valid
    end
    
    it "companyname can't be too short" do
      stock.companyname = "a"
      expect(stock).to_not be_valid
    end

    it "companyname can't be too long" do
      stock.companyname = "a" * 51
      expect(stock).to_not be_valid
    end
    
    it "companyname should be unique" do
      stock2  = user.stocks.build(companyname: "z",stockprice: 2000)
      expect(stock2.valid?).to be(false)
    end

    it "stockprice should be integer" do
      stock.stockprice = "c"
      expect(stock.valid?).to be(false)
    end

    it "stockprice should be in between 900...10000000" do
      stock.stockprice = 20
      expect(stock.valid?).to be(false)

      stock.stockprice = 4000
      expect(stock.valid?).to be(true)
    end

  end


  context "scope tests" do

    let(:transaction1) {
      Transaction.new(no_of_stocks: 3000,status: "purchased",stock_id: stock.id)
    }
    let(:transaction2) {
      Transaction.new(no_of_stocks: 1000,status: "purchased",stock_id: stock.id)
    }
    let(:transaction3) {
      Transaction.new(no_of_stocks: 3000,status: "sold",stock_id: stock.id)
    }
    let(:transaction4) {
      Transaction.new(no_of_stocks: 1000,status: "sold",stock_id: stock.id)
    }

    before do
      transaction1.save
      transaction2.save
      transaction3.save
      transaction4.save
    end
    it "should return correct total purchased stocks" do
      expect(Stock.total_purchased_stocks(stock.user_id)).to eql(4000)
    end

    it "should return correct total invested  amount by user" do
      expect(Stock.total_invested_amount(stock.user_id)).to eql(48000000)
    end
    
    it "should return correct total purchased amount by stock" do
      expect(Stock.total_purchased_amount(stock.id)).to eql(48000000)
    end
    
    it "should return correct total sold stocks" do
      expect(Stock.total_sold_stocks(stock.user_id)).to eql(4000)
    end
    
    it "should return correct total redeemed amount by user" do
      expect(Stock.total_invested_amount(stock.user_id)).to eql(48000000)
    end

    it "should return correct total sold amount by particular stock" do
      expect(Stock.total_sold_amount(stock.id)).to eql(48000000)
    end

  end

end
