class PagesController < ApplicationController
  DEFAULT_FALLBACK_CITY = 'KUALA LUMPUR'

  def index
    city = request.location.present? ? request.location.city.upcase : DEFAULT_FALLBACK_CITY
    external_id = Location.state.find_by(name: city).external_id

    @forecast = Met::Forecast::General.call(external_id).response
    @max_celcius = @forecast.map { |a| a if a['datatype'].eql?('FMAXT') }.compact.last['value']
    @min_celcius = @forecast.map { |a| a if a['datatype'].eql?('FMINT') }.compact.last['value']
    @condition = condition
  end

  private

  def condition
    current_time = Time.current.to_i

    # Morning
    morning = Time.current.change(hour: 5, min: 00).to_i
    late_morning = Time.current.change(hour: 11, min: 59).to_i

    # Afternoon
    noon = Time.current.middle_of_day.to_i
    late_noon = Time.current.change(hour: 16, min: 59).to_i

    # Evening
    evening = Time.current.change(hour: 17, min: 00).to_i
    late_evening = 1.day.from_now.change(hour: 4, min: 59).to_i

    return @forecast.map { |a| a if a['datatype'].eql?('FGM') }.compact.last if morning.upto(late_morning).include?(current_time)
    return @forecast.map { |a| a if a['datatype'].eql?('FGA') }.compact.last if noon.upto(late_noon).include?(current_time)
    return @forecast.map { |a| a if a['datatype'].eql?('FGN') }.compact.last if evening.upto(late_evening).include?(current_time)
  end
end
