class V0
  module Services
    class LdapService
      module Queries
        module UsersQueries
          module AccountsQueries

            require_relative 'accounts_queries/email_queries'
            require_relative 'accounts_queries/groups_queries'

            include EmailQueries
            include GroupsQueries

            def create_users_account_query( ldap, user )
              uid = user[:uid]
              cn = "#{user[:first_name]} #{user[:last_name]}"
              dn = "cn=#{cn},ou=People,dc=engines,dc=internal"
              uidnumber = next_available_uidnumber_helper ldap

              attributes = {
                uidnumber: uidnumber,
                cn: cn,
                gidnumber: "5000",
                givenname: user[:first_name],
                homedirectory: "/home/users/#{uid}",
                loginshell: "/bin/sh",
                objectclass: [
                  "posixAccount",
                  "inetOrgPerson",
                  "top" ],
                sn: user[:last_name],
                uid: uid,
                userpassword: "{SASL}#{uid}@ENGINES.INTERNAL",
              }

              if ldap.add dn: dn, attributes: attributes
                entry = find_user_entry_helper ldap, uid
                create_users_account_group_query( ldap, uid, "Users" )
              end

            end


            def index_users_accounts_query ldap
              result = []
              filter = Net::LDAP::Filter.eq( "objectclass", "posixAccount" )
              base = "ou=People,dc=engines,dc=internal"
              ldap.search(:base => base, :filter => filter ) do |entry|
                result << {
                  uid: entry.uid[0],
                  name: entry.cn.join(' '),
                }
              end
              result
            end


            def show_users_account_query( ldap, uid )
              entry = find_user_entry_helper ldap, uid
              {
                name: entry.cn[0],
                first_name: entry.givenname[0],
                last_name: entry.sn[0],
                uid: uid,
                groups: index_users_account_groups_query( ldap, uid ),
                email: show_users_account_email_query( ldap, uid )
              }

            end


            def update_users_account_query(ldap, uid, data)

              entry = find_user_entry_helper ldap, uid
              newrdn = "cn=#{data[:first_name]} #{data[:last_name]}"

              replace_attribute_value_on_entry_helper( ldap, entry, "givenname", data[:first_name] ) &&
              replace_attribute_value_on_entry_helper( ldap, entry, "sn", data[:last_name] ) &&
              update_entry_rdn_helper( ldap, entry, newrdn )

            end


            def delete_users_account_query( ldap, uid )
              entry = find_user_entry_helper ldap, uid
              delete_entry_helper(ldap, entry)
            end


          end
        end
      end
    end
  end
end