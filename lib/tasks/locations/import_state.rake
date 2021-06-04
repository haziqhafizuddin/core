# NOTE: only run this once to get all Source from MET

namespace :locations do
  task import_state: :environment do
    puts 'start importing...'
    states = Met::Locations::State.call

    if states.success?
      states.response.each do |state|
        location = Location.find_or_create_by(external_id: state['id'], category: Location.categories[:state])
        location.name = state['name']
        location.external_root_id = state['locationrootid']
        location.latitude = state['latitude']
        location.longitude = state['longitude']
        location.save
        puts "Location id: #{location.id}"
      end
    else
      puts 'Failed to import'
    end

    puts 'successfully completed'
  end
end
