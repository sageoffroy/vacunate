class Locality < ApplicationRecord

	has_many :people
	belongs_to :area

	def to_s
		name
	end

	
end
