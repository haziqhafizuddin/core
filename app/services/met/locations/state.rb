module Met
  module Locations
    class State
      include Serviceable

      SUCCESS_CODE = 200

      def call
        if response.status.eql?(SUCCESS_CODE)
          success(JSON.parse(response.body)['results'])
        else
          fail(JSON.parse(response.body))
        end
      end

      private

      def response
        @response ||= Faraday.get(url, {}, headers)
      end

      def url
        # NOTE: The creds URL is general URL, to get specific URL append correct endpoint.
        @url ||= "#{Rails.application.credentials.met[:url]}/locations?locationcategoryid=STATE"
      end

      def token
        @token ||= Rails.application.credentials.met[:token]
      end

      def headers
        {
          'Authorization' => "METToken #{token}"
        }
      end
    end
  end
end
