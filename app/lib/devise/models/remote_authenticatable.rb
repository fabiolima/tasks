# require "fakeweb" # used for mocking API calls

module Devise
  module Models
    module RemoteAuthenticatable
      extend ActiveSupport::Concern

      # Return false if not able to authenticate, otherwise return a user.
      def remote_authentication(credentials)
        response = Auth::Authenticator.new(credentials).authenticate

        return false unless response.code.to_i == 200

        payload = JSON.parse(response.body)
        self.email = payload["data"]["user"]["email"]
        self.token = payload["data"]["token"]
        self
      end

      module ClassMethods
        # Build a user from previous serialized session's data
        def serialize_from_session(data, salt)
          resource = self.new
          resource.email = data["email"]
          resource.token = data["token"]
          resource
        end

        # Serialize user into session
        def serialize_into_session(record)
          [ { email: record.email, token: record.token }, nil ]
        end
      end
    end
  end
end
