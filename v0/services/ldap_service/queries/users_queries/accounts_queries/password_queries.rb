class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries
          module AccountsQueries
            module PasswordQueries

              def update_users_account_password_query ( ldap, user_uid, password )
                entry = find_user_entry_helper ldap, user_uid
                # current_sha_password = entry.userpassword
                sha_password = '{SHA}' + Base64.encode64(Digest::SHA1.digest( password[:new] )).chomp!
                # byebug
                replace_attribute_value_on_entry_helper( ldap, entry, :userpassword, sha_password )
              end

            end
          end
        end
      end
    end
  end
end
