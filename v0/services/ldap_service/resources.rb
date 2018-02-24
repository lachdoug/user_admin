class V0
  module Services
    class LdapService
      module Resources

        require_relative 'resources/email'
        require_relative 'resources/users'

        include Email
        include Users

      end
    end
  end
end
