class Area < ApplicationRecord
	
	has_many :localities

	def to_s 
		name
	end

	def abbreviation
		
	end
end
