module TransactionsConcern 
	extend ActiveSupport::Concern

	def enough_stocks(s_id,transaction)
		if transaction.status == "purchased"
			true
		else
			pur_stocks = Transaction.purchased_trans(s_id)
			sold_stocks = Transaction.sold_trans(s_id)
			pur_stocks >= (sold_stocks+transaction.no_of_stocks)
		end
	end
end