json.set! :data do
  json.array! @people do |person|
    json.partial! 'people/person', person: person
    json.url  "
              #{link_to 'Show', person }
              #{link_to 'Edit', edit_person_path(person)}
              #{link_to 'Destroy', person, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end