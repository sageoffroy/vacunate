class PeopleWithLocalityAndState < ApplicationRecord
  
  acts_as_copy_target
  
  self.primary_key = :dni

  def readonly?
    true
  end

end