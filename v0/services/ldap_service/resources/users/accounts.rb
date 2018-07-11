class V0
  module Services
    class LdapService
      module Resources
        module Users
          module Accounts

            require_relative 'accounts/email'
            require_relative 'accounts/groups'
            require_relative 'accounts/password'
            require_relative 'accounts/signins'

            include Email
            include Groups
            include Password
            include Signins

            def index_users_accounts
              net_ldap do |ldap|
                index_users_accounts_query ldap
              end
            end

            def show_users_account(uid)
              net_ldap do |ldap|
                show_users_account_query ldap, uid
              end
            end

            def create_users_account( account )
              net_ldap do |ldap|
                begin
                  $stderr.puts "Account: #{account}"
                  raise Error unless create_users_account_query( ldap, account )
                  return account
                rescue Error => e
                  ldap_op_error( ldap, "Failed to create user account." )
                end
              end
            end

            def update_users_account( uid, account )
              net_ldap do |ldap|
                begin
                  raise Error unless update_users_account_query( ldap, uid, account )
                  return account
                rescue Error => e
                  ldap_op_error( ldap, "Failed to update user account." )
                end
              end
            end

            def delete_users_account(uid)
              net_ldap do |ldap|
                begin
                  raise Error unless index_users_account_groups_query(ldap, uid).empty?
                  raise Error unless show_users_account_email_query( ldap, uid ).empty?
                  raise Error unless delete_users_account_query( ldap, uid )
                  return {}
                rescue Error => e
                  ldap_op_error( ldap, "Failed to delete user account." )
                end
              end
            end

          end
        end
      end
    end
  end
end
