json.set! :data do
  json.array! @localities do |locality|
    json.partial! 'localities/locality', locality: locality
    json.url  "
              #{link_to 'Show', locality }
              #{link_to 'Edit', edit_locality_path(locality)}
              #{link_to 'Destroy', locality, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end