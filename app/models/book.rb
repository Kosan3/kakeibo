class Book < ApplicationRecord
	validates :sale_date, presence: true
	validates :money, presence: true
	validates :name, presence: true
	belongs_to :user
end
