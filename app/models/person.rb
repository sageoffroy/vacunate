class Person < ApplicationRecord
  belongs_to :population_group
  belongs_to :locality
  belongs_to :state
end
