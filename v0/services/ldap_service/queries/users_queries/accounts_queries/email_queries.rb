class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries
          module AccountsQueries
            module EmailQueries

              require_relative 'email_queries/email_aliases_queries'
              require_relative 'email_queries/distribution_groups_queries'

              include EmailAliasesQueries
              include DistributionGroupsQueries

              def show_users_account_email_query( ldap, user_uid )
                entry = find_user_entry_helper ldap, user_uid
                if entry.objectClass.include? "postfixUser"
                  mailbox = user_mailbox_helper ldap, entry
                  email_aliases = user_email_aliases_helper ldap, entry
                  distribution_groups =
                    email_distribution_groups_for_email_addresses_helper(
                      ldap, [ mailbox ] + email_aliases )
                  {
                    mailbox: mailbox,
                    aliases: email_aliases,
                    distribution_groups: distribution_groups
                  }
                else
                  {}
                end
              end

              def create_users_account_email_query( ldap, user_uid, email )
                entry = find_user_entry_helper ldap, user_uid
                email_address = "#{user_uid}@#{email[:domain_name]}"
                add_class_to_entry_helper ldap, entry, "postfixUser"
                add_attribute_value_to_entry_helper ldap, entry, "maildrop", email_address
              end

              def edit_users_account_email_query( ldap, user_uid )
                entry = find_user_entry_helper ldap, user_uid
                mailbox = user_mailbox_helper ldap, entry
                email_domain = mailbox.split('@')[1]
                email_domains = index_email_domains_query ldap
                {
                  domain_name: domain,
                  email_domains: domains
                }
              end

              def update_users_account_email_query ( ldap, user_uid, email )
                entry = find_user_entry_helper ldap, user_uid
                email_address = "#{user_uid}@#{email[:domain_name]}"
                replace_attribute_value_on_entry_helper ldap, entry, "maildrop", email_address
              end

              def delete_users_account_email_query( ldap, user_uid )
                entry = find_user_entry_helper ldap, user_uid
                delete_attribute_from_entry_helper ldap, entry, "maildrop"
                remove_class_from_entry_helper ldap, entry, "postfixUser"
              end

            end
          end
        end
      end
    end
  end
end
