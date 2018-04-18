class V0
  module Services
    class LdapService

      require 'net/ldap'

      # Redefine MODIFY_OPERATIONS to include :increment
      class Net::LDAP::Connection
        MODIFY_OPERATIONS =
            { :add => 0,
              :delete => 1,
              :replace => 2,
              :increment => 3
            }
      end

      require_relative 'ldap_service/helpers'
      # require_relative 'ldap_service/reset'
      require_relative 'ldap_service/resources'
      require_relative 'ldap_service/queries'

      include Helpers
      include Queries
      include Resources
      # include Reset

      def initialize(settings)
        @settings = settings
      end

      def net_ldap
        auth = {
          :method => :simple,
          :username => @settings.ldap_username,
          :password => @settings.ldap_password
        }

        # auth = {
        #   :method => :simple,
        #   :username => "cn=admin,dc=engines,dc=internal",
        #   :password => "password"
        # }

        begin
          Net::LDAP.open(host: "ldap", auth: auth) do |connection|
            yield connection
          end
        rescue Net::LDAP::ConnectionRefusedError => e
          raise Error.new "Failed to connect to LDAP service."
        end

      end


      class Error < StandardError
      end

      class Error::Operation < Error
      end

      class Error::EntryMissing < Error
      end


      def ldap_op_error(ldap, prepend_message)
        raise Error::Operation.new ( [
          prepend_message,
          ldap.get_operation_result.message,
          ldap.get_operation_result.error_message
        ] - [ "Success", "" ] ).compact.join ' '
      end

      def entry_missing_error
        raise Error::EntryMissing.new "Entry does not exist."
      end

    end
  end
end
