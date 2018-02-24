class V0
  module Services
    class LdapService
      module Helpers
        module FindHelpers

          def find_entry_by_dn_helper(ldap, dn)
            ( ldap.search( base: dn ) || entry_missing_error )[0]
          end

          def find_children_entries_of_dn_helper( ldap, dn )
            result = []
            ldap.search( base: dn ) do |entry|
              result << entry unless entry.dn == dn
            end
            result
          end

          def find_singleton_child_entry_of_dn_helper( ldap, dn )
            find_children_entries_of_dn_helper( ldap, dn )[0] || entry_missing_error
          end

        end
      end
    end
  end
end
