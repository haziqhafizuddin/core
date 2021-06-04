# NOTE: only run this once to get all Source from MET

namespace :sources do
  task import: :environment do
    puts 'start importing...'
    data_types = Met::DataTypes.call

    if data_types.success?

      data_types.response.each do |dt|
        source = Source.find_or_create_by(external_id: dt['id'])
        source.name = dt['name']
        source.condition = Source.conditions[dt['datasetid'].downcase.to_sym]
        source.category = Source.categories[dt['datacategoryid'].downcase.to_sym]
        source.save
        puts "Source id: #{source.id}"
      end
    else
      puts 'Failed to import'
    end

    puts 'successfully import'
  end
end
