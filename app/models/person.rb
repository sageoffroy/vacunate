class Person < ApplicationRecord


  belongs_to :locality, validate: false
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :dni, presence: true
  validates :dni, length: { in: 6..8 }
  validates :dni_sex, presence: true
  validates :birthdate, presence: true
  validates :address_street, presence: true
  validates :address_number, presence: true
  validates_associated :locality
  validates :dni, uniqueness: true

  belongs_to :state, optional: true

  validate :phone_xor_email

  acts_as_copy_target

  def to_s
    "(" + dni.to_s + ") " + firstname + " " + lastname
  end

  def have_any_pathology?
    return (obesity or diabetes or chronic_kidney_disease or cardiovascular_disease or chronic_lung_disease or (inmunocompromised.eql? "1"))
  end

  def population_group_table

    case population_group
    when "Soy personal de salud"
      return "Salud"
    when "Soy personal de seguridad"
      return "Seguridad"       
    when "Soy personal docente/auxiliar"
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

    if (inmunocompromised.eql? "1")
      if (p_aux.eql? "")
        p_aux = p_aux + "IC"
      else
        p_aux = p_aux + " - IC"
      end
    end

    if (p_aux.eql? "")
      p_aux = "N/A"
    end


    return p_aux
  end

  def code_telephone
    if self.phone.nil?
      return ""
    else
      if self.phone_code.nil?
        if self.locality.area.abbreviation == "dpape"
          phone_code = 2945
        elsif self.locality.area.abbreviation == "dpapcr"
          self.phone_code = 297
        else
          self.phone_code = 280
        end
      end
      return "549" + self.phone_code.to_s + self.phone.to_s
    end
  end

  def age
    return ((Time.zone.now - birthdate.to_time) / 1.year.seconds).floor
  end

  def address
    address_street + " " + address_number.to_s
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

    if (inmunocompromised.eql? "1")
      priority_aux += 5
    end

    update_attribute('priority', priority_aux)


  end

  def update_state (state)
    update_attribute('state', state)
  end

  def update_birthdate (birthdate)
    update_attribute('birthdate', birthdate)
    update_priority
  end

  private

    def phone_xor_email
      if email.blank?
        if phone_code.blank?
          if phone.blank?
            # Mail vacío, Código vacío y Telefono vacío
            errors.add(:phone_code, "")
            errors.add(:phone, "")
            errors.add(:email, "Debe especificar un Email y/o un Teléfono de contacto")
          else
            # Mail vacío, Código vacío y Telefono con número
            errors.add(:phone_code, "Debe especificar un Código de Área a su Teléfono de contacto")
          end
        else
          if phone.blank?
            # Mail vacío, Código Completo y Telefono vacío
            errors.add(:phone, "Debe ingresar su Número de Teléfono además del Código de Área")

          end
        end
      else
        if phone_code.blank?
          if !phone.blank?
            # Mail correcto, Código vacío y Telefono con número
            errors.add(:phone_code, "Debe especificar un Código de Área a su Teléfono de contacto")
          end
        else
          if phone.blank?
            # Mail correcto, Código Completo y Telefono vacío
            errors.add(:phone, "Debe ingresar su Número de Teléfono además del Código de Área")
          end
        end
      end
    end

end
