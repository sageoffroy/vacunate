class PersonDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :content_tag
  def_delegator :@view, :fa_icon
  def_delegator :@view, :edit_person_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end


  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      locality: { source: "Person.locality_id", cond: :like, searchable: true, orderable: true },
      population_group: { source: "Person.population_group", searchable: true, orderable: true },
      dni: { source: "Person.dni", searchable: true, orderable: true },
      firstname: { source: "Person.firstname", searchable: true, orderable: true },
      lastname: { source: "Person.lastname", searchable: true, orderable: true },
      birthdate: { source: "Person.birthdate", searchable: false, orderable: false },
      email: { source: "Person.email", searchable: true, orderable: false },
      telephone: {searchable: false, orderable: false},
      options: {searchable: false, orderable: false}
    }
  end

  def data
    records.map do |record|
      {
        locality: record.locality.name,
        population_group: record.population_group,
        dni: record.dni,
        firstname: record.firstname,
        lastname: record.lastname,
        birthdate: record.birthdate,
        email: record.email,
        telephone: record.phone_code.to_s + " - " + record.phone.to_s,
        options: (link_to((fa_icon "eye"), record) + link_to((fa_icon "pencil"), edit_person_path(record)) + link_to((fa_icon "trash-o"), record, method: :delete, data: { confirm: '¿Esta seguro que desea eliminar?' }))
      }
    end
  end

  def get_raw_records
    Person.all
  end

end
