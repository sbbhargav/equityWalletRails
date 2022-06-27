require 'rails_helper'

RSpec.describe Transaction, type: :model do

  
  subject(:user) {
    User.new(id: 1,username: "xyz", email: "x123@gmail.com", password: "1234", password_confirmation: "1234")
  }
  subject(:stock) {
   user.stocks.build(id: 1,companyname: "zzz",stockprice: 12000)
  }
  subject(:transaction) {
    stock.transactions.build(no_of_stocks: 2000,status: "purchased")
  }

  before do
    user.save
    stock.save
    transaction.save
  end

  context "associations" do
    it "transaction belongs to a perticular stock" do
      should belong_to(:stock)
    end
  end

  context "validation tests" do
    it "no_of_stocks can't be blank" do
      transaction.no_of_stocks = nil
      expect(transaction.valid?).to be(false)
    end
    it "status can't be empty" do
      transaction.status = nil
      expect(transaction.valid?).to be(false)
    end
    it "no_of_stocks should be integer" do
      transaction.no_of_stocks = "ed"
      expect(transaction.valid?).to be(false)

      transaction.no_of_stocks = 12
      expect(transaction.valid?).to be(true)
    end
    it "no_of_stocks in range 1..10000" do
      transaction.no_of_stocks = 0
      expect(transaction.valid?).to be(false)

      transaction.no_of_stocks = 10000
      expect(transaction.valid?).to be(true)

      transaction.no_of_stocks = 10001
      expect(transaction.valid?).to be(false)
    end
    it "has enough stocks to sold" do
      transaction.no_of_stocks = 10000
      transaction.status = "sold"
      expect(transaction.valid?).to be(false)
    end
    
  end

  context "scope tests" do
    
    let(:transaction1) {
      stock.transactions.build(no_of_stocks: 1000,status: "purchased")
    } 
    let(:transaction2) {
      stock.transactions.build(no_of_stocks: 1000,status: "sold")
    }
    before do
      transaction1.save
      transaction2.save
    end

    it "should return correct purchased transactions" do
      expect(Transaction.purchased_trans(transaction.stock_id)).to eql(3000)
    end
    it "should return correct sold transactions" do
      expect(Transaction.sold_trans(transaction.stock_id)).to eql(1000)
    end
  end

end
