# class V0
#   module Services
#     class LdapService
#       module Reset
#
#         def reset_ldap
#           net_ldap do |ldap|
#
#             # Delete all :distribution_groups
#             ldap.search(
#             filter: Net::LDAP::Filter.eq( "objectClass", "posixGroup" ),
#             base: "ou=Distribution Groups,dc=engines,dc=internal" ) do |entry|
#               entry.respond_to?(:memberuid) && entry.memberuid.each do |value|
#                 delete_attribute_value_from_entry_helper( ldap, entry, "memberUid", value )
#               end
#               delete_entry_helper(ldap, entry)
#             end
#
#             # Delete :default_domain
#             begin
#               delete_email_default_domain_query ldap
#             rescue V0::Services::LdapService::Error::EntryMissing
#             end
#
#             # Delete all :email_domains
#             ldap.search(
#             filter: Net::LDAP::Filter.eq( "objectClass", "dNSDomain" ),
#             base: "ou=domains,ou=email,ou=Services,ou=Containers,ou=Engines,dc=engines,dc=internal" ) do |entry|
#               delete_entry_helper(ldap, entry)
#             end
#
#             # # Delete test :email_domains
#             # begin
#             #   delete_email_domain_query ldap, 'testdomain.fake'
#             # rescue EntryMissing
#             #   delete_email_domain_query ldap, 'testdomain1.fake'
#             # rescue EntryMissing
#             #   delete_email_domain_query ldap, 'testdomain2.fake'
#             # end
#
#             # Delete test :user
#             begin
#               delete_users_account_group_query ldap, 'testuser', 'Users'
#             rescue V0::Services::LdapService::Error::EntryMissing
#             end
#             begin
#               delete_users_account_query ldap, 'testuser'
#             rescue V0::Services::LdapService::Error::EntryMissing
#             end
# 
#           end
#         end
#
#       end
#     end
#   end
# end
