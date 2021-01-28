json.set! :data do
  json.array! @pathologies do |pathology|
    json.partial! 'pathologies/pathology', pathology: pathology
    json.url  "
              #{link_to 'Show', pathology }
              #{link_to 'Edit', edit_pathology_path(pathology)}
              #{link_to 'Destroy', pathology, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end