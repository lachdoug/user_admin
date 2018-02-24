class V0
  module Services
    class LdapService
      module Helpers

        require_relative 'helpers/entries_helpers'
        require_relative 'helpers/find_helpers'
        require_relative 'helpers/gid_numbers_helpers'
        require_relative 'helpers/uid_numbers_helpers'
        require_relative 'helpers/users_helpers'

        include EntriesHelpers
        include FindHelpers
        include GidNumbersHelpers
        include UidNumbersHelpers
        include UsersHelpers

      end
    end
  end
end
