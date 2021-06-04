module Met
  module Forecast
    class General
      include Serviceable

      def initialize(location_id, options = {})
        current_date ||= I18n.l(Date.current, format: :short_date)

        @location_id = location_id
        @start_date = options[:start_date] || current_date
        @end_date = options[:end_date] || current_date
      end

      SUCCESS_CODE = 200

      def call
        if response.status.eql?(SUCCESS_CODE)
          success(JSON.parse(response.body)['results'])
        else
          fail(JSON.parse(response.body))
        end
      end

      private

      attr_reader :location_id, :start_date, :end_date

      def response
        # NOTE: Since we're not storing it into DB, might as well cache it everyday.
        Rails.cache.fetch(cache_key, expires_in: Time.current.end_of_day) do
          Faraday.get(url, params, headers)
        end
      end

      def params
        {
          datasetid: 'FORECAST',
          datacategoryid: 'GENERAL',
          locationid: location_id,
          start_date: start_date,
          end_date: end_date
        }
      end

      def url
        # NOTE: The creds URL is general URL, to get specific URL append correct endpoint.
        @url ||= "#{Rails.application.credentials.met[:url]}/data"
      end

      def token
        @token ||= Rails.application.credentials.met[:token]
      end

      def headers
        {
          'Authorization' => "METToken #{token}"
        }
      end

      def cache_key
        Location.find_by(external_id: location_id).name.downcase
      end
    end
  end
end
