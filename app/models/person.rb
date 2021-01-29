class Person < ApplicationRecord
  belongs_to :locality, validate: false

  validates_associated :locality

  validates_inclusion_of :condition, :in => [true, false]
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :dni, presence: true
  validates :dni_sex, presence: true
  validates :self_perceived_sex, presence: true
  validates :birthdate, presence: true
  validates :address_street, presence: true
  validates :address_number, presence: true
  

end


