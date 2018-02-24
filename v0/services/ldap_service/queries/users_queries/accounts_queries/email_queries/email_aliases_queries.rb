class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries
          module AccountsQueries
            module EmailQueries
              module EmailAliasesQueries

                def create_users_account_email_alias_query( ldap, user_uid, email_address )
                  entry = find_user_entry_helper ldap, user_uid
                  add_attribute_value_to_entry_helper( ldap, entry, :mailacceptinggeneralid, email_address )
                end

                def delete_users_account_email_alias_query( ldap, user_uid, email_address )
                  entry = find_user_entry_helper ldap, user_uid
                  delete_attribute_value_from_entry_helper( ldap, entry, :mailacceptinggeneralid, email_address )
                end

                # def index_users_email_aliases_query(ldap, user_uid)
                #
                # end

              end
            end
          end
        end
      end
    end
  end
end
