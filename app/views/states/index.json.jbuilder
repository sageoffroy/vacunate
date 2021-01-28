json.set! :data do
  json.array! @states do |state|
    json.partial! 'states/state', state: state
    json.url  "
              #{link_to 'Show', state }
              #{link_to 'Edit', edit_state_path(state)}
              #{link_to 'Destroy', state, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end