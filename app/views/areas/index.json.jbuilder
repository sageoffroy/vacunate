json.set! :data do
  json.array! @areas do |area|
    json.partial! 'areas/area', area: area
    json.url  "
              #{link_to 'Show', area }
              #{link_to 'Edit', edit_area_path(area)}
              #{link_to 'Destroy', area, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end