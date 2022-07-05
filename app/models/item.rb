class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
    
  enum genre_status: { sale: true, stop: false }
  
end
