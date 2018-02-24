class V0
  module Services
    class LdapService
      module Helpers
        module UsersHelpers

          def find_user_entry_helper(ldap, uid)
            filter =
              Net::LDAP::Filter.eq( "objectclass", "posixAccount" ) &
              Net::LDAP::Filter.eq( "uid", uid )
            base = "ou=People,dc=engines,dc=internal"
            ldap.search(:base => base, :filter => filter )[0].tap do |result|
              entry_missing_error unless result
            end
          end


          def user_email_aliases_helper(ldap, entry)
            entry.respond_to?('mailacceptinggeneralid') ? entry.mailacceptinggeneralid : []
          end

          def email_distribution_groups_for_email_addresses_helper(ldap, email_addresses)
            result = []
            email_addresses.each do |email_address|
              filter =
                Net::LDAP::Filter.eq( "objectclass", "posixGroup" ) &
                Net::LDAP::Filter.eq( "memberUid", email_address )
              base = "ou=Distribution Groups,dc=engines,dc=internal"
              ldap.search(:base => base, :filter => filter ) do |entry|
                result << {
                  group: entry.cn[0],
                  email_address: email_address
                }
              end
            end
            result
          end

          def user_mailbox_helper(ldap, entry)
            entry.maildrop[0]
          end



        end
      end
    end
  end
end
