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

  belongs_to :state, optional: true

  validate :phone_xor_email

  def to_s
    "(" + dni + ") " + firstname + " " + lastname
  end

  def have_any_pathology?
    return (obesity or diabetes or chronic_kidney_disease or cardiovascular_disease or chronic_lung_disease)
  end

  def population_group_table
    
    case population_group
    when "Soy personal de salud"
      return "Salud" 
    when "Soy personal de seguridad"
      return "Seguridad"       
    when "Soy personal de educación"
      return "Educación"       
    when "Soy mayor de 60 años"
      return "60 o más" 
    when "Tengo entre 18 y 59 (con factores de riesgo)"
      return "18 a 59 (riesgo)"      
    else
      return "Otro"
    end
  end  

  def show_pathologies

    p_aux = ""

    if (diabetes)
      if (p_aux.eql? "")
        p_aux = p_aux + "DBT"
      else
        p_aux = p_aux + " - DBT"
      end
    end

    if (obesity)
      if (p_aux.eql? "")
        p_aux = p_aux + "O"
      else
        p_aux = p_aux + " - O"
      end
    end

    if (chronic_kidney_disease)
      if (p_aux.eql? "")
        p_aux = p_aux + "ERC"
      else
        p_aux = p_aux + " - ERC"
      end
    end

    if (cardiovascular_disease)
      if (p_aux.eql? "")
        p_aux = p_aux + "ECV"
      else
        p_aux = p_aux + " - ECV"
      end
    end

    if (chronic_lung_disease)
      if (p_aux.eql? "")
        p_aux = p_aux + "RC"
      else
        p_aux = p_aux + " - RC"
      end
    end

    if (p_aux.eql? "")
      p_aux = "N/A"
    end


    return p_aux
  end

  def code_telephone
    "(" +phone_code.to_s + ") " + phone.to_s
  end

  def age
    return ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
  end

  def update_priority

    
    priority_aux = (age * 1.3).round

    if (diabetes)
      priority_aux += 20
    end
    if (obesity)
      priority_aux += 10
    end
    if (chronic_kidney_disease)
      priority_aux += 5
    end
    if (cardiovascular_disease)
      priority_aux += 5
    end
    if (chronic_lung_disease)
      priority_aux += 5
    end

    update_attribute('priority', priority_aux)
    
    
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


