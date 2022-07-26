class Order < ApplicationRecord
 
 has_many :order_details
 belongs_to :customer
 
 enum payment: { credit_card: 0, transfer: 1 }
 
end
