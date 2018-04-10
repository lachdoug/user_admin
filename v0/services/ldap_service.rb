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

      # def initialize(settings)
      #   @settings = settings
      # end

      def net_ldap
        auth = {
          :method => :simple,
          :username => "cn=admin,dc=engines,dc=internal",
          :password => "password"
        }

        Net::LDAP.open(host: "ldap", auth: auth) do |conn|
          begin
            yield conn
          rescue => e
            log e
            raise Error.new e.to_s
          end
        end
      end
      #
      # def debug(output)
      #   puts output.to_s if Sinatra::Base.development?
      # end


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
