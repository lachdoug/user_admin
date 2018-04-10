class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries
          module AccountsQueries
            module EmailQueries
              module DistributionGroupsQueries

                # def net_ldap_distribution_lists_for_user(ldap, user_uid)
                #
                #   mailbox = net_ldap_user_mailbox(ldap, user_uid)
                #   email_aliases = net_ldap_user_email_addresses(ldap, user_uid)
                #   email_addresses = [ mailbox ] + email_aliases
                #
                #   result = []
                #   email_addresses.each do |email_address|
                #     filter =
                #       Net::LDAP::Filter.eq( "objectclass", "posixGroup" ) &
                #       Net::LDAP::Filter.eq( "memberUid", email_address )
                #     base = "ou=Distribution Groups,dc=engines,dc=internal"
                #     ldap.search(:base => base, :filter => filter ) do |entry|
                #       result << {
                #         distribution_group: entry.cn[0],
                #         email_address: email_address
                #       }
                #     end
                #   end
                #   result
                #
                # end


                # def delete_users_account_email_distribution_group_query(ldap, user_uid)
                #
                #   mailbox = net_ldap_user_mailbox(ldap, user_uid)
                #   email_aliases = net_ldap_user_email_addresses(ldap, user_uid)
                #   email_addresses = [ mailbox ] + email_aliases
                #
                #   result = {
                #     mailbox: mailbox,
                #     distribution_groups: []
                #   }
                #   email_addresses.each do |email_address|
                #     filter =
                #       Net::LDAP::Filter.eq( "objectclass", "posixGroup" ) &
                #       Net::LDAP::Filter.eq( "memberUid", email_address )
                #     base = "ou=Distribution Groups,dc=engines,dc=internal"
                #     ldap.search(:base => base, :filter => filter ) do |entry|
                #       result[:distribution_groups] << {
                #         distribution_group: entry.cn[0],
                #         email_address: email_address
                #       }
                #     end
                #   end
                #   result
                # end

                # def delete_users_account_email_distribution_group_query(ldap, user_uid, name)
                #   delete_email_distribution_group_email_address_query( ldap, user_uid, distribution_list_name, email_address )
                # end

                def new_users_account_email_distribution_group_query( ldap, user_uid )
                  user_distribution_groups =
                    show_users_account_email_query( ldap, user_uid )[:distribution_groups].
                    map { |distribution_group| distribution_group[:name] }
                  distribution_groups =
                    index_email_distribution_groups_query( ldap ).
                    map { |distribution_group| distribution_group[:name] }
                  { distribution_groups: distribution_groups - user_distribution_groups }
                end

                def create_users_account_email_distribution_group_query( ldap, user_uid, distribution_group )
                  user_entry = find_user_entry_helper ldap, user_uid
                  mailbox = user_mailbox_helper(ldap, user_entry)
                  distribution_group_dn = "cn=#{distribution_group},ou=Distribution Groups,dc=engines,dc=internal"
                  distribution_group_entry = find_entry_by_dn_helper(ldap, distribution_group_dn)
                  add_attribute_value_to_entry_helper( ldap, distribution_group_entry, "memberuid", mailbox )
                end


              end
            end
          end
        end
      end
    end
  end
end
