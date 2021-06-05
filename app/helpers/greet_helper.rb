module GreetHelper
  def greeting
    current_time = Time.current.to_i

    # Morning
    morning = Time.current.change(hour: 5, min: 00).to_i
    late_morning = Time.current.change(hour: 11, min: 59).to_i

    # Afternoon
    noon = Time.current.middle_of_day.to_i
    late_noon = Time.current.change(hour: 16, min: 59).to_i

    # Evening
    evening = Time.current.change(hour: 17, min: 00).to_i
    late_evening = Time.current.change(hour: 4, min: 59).to_i

    return 'Good Morning' if morning.upto(late_morning).include?(current_time)
    return 'Good Afternoon' if noon.upto(late_noon).include?(current_time)
    return 'Good Evening' if evening.upto(late_evening).include?(current_time)
  end
end
