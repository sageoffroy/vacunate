# app/commands/download_books.rb
require 'csv'
class DownloadPeople
  class << self
    def call
      column_names = %w{dni firstname lastname}

      CSV.generate({:col_sep => ";"}) do |csv|
        csv << column_names
        Person.all.each do |person|
          csv << person.attributes.values_at(*column_names)
        end
      end
    end
  end
end
