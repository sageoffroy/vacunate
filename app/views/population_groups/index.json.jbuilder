json.set! :data do
  json.array! @population_groups do |population_group|
    json.partial! 'population_groups/population_group', population_group: population_group
    json.url  "
              #{link_to 'Show', population_group }
              #{link_to 'Edit', edit_population_group_path(population_group)}
              #{link_to 'Destroy', population_group, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end