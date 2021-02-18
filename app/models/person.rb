class Person < ApplicationRecord
  
  
  belongs_to :locality, validate: false
  validates_inclusion_of :condition, :in => [true, false]
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :dni, presence: true
  validates :dni_sex, presence: true
  validates :birthdate, presence: true
  validates :address_street, presence: true
  validates :address_number, presence: true
  validates_associated :locality
  validates :dni, uniqueness: true

  validate :phone_xor_email

  def to_s
    "(" + dni + ") " + firstname + " " + lastname
  end

  def have_any_pathology?
    return (obesity or diabetes or chronic_kidney_disease or cardiovascular_disease or chronic_lung_disease)
  end

  def code_telephone
    "(" +phone_code.to_s + ") " + phone.to_s
  end

  private

    def phone_xor_email
      if phone_code.blank? or phone.blank?
        if email.blank?
          errors.add(:phone_code, "")
          errors.add(:phone, "")
          errors.add(:email, "Debe especificar un Email y/o un Teléfono de contacto")
        end
      end      
    end
  
end


