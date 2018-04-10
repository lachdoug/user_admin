class V0
  module Services
    class LdapService
      module Queries
        module EmailQueries
          module EmailAddressesQueries

            def index_email_email_addresses_query(ldap)
              index_email_mailboxes_email_addresses_query(ldap) +
              index_email_aliases_email_addresses_query(ldap) +
              index_email_distribution_groups_email_addresses_query(ldap)
            end


            def index_email_aliases_email_addresses_query(ldap)
              result = []
              filter =
                Net::LDAP::Filter.eq( "objectclass", "posixAccount" ) &
                Net::LDAP::Filter.eq( "mailacceptinggeneralid", "*" )
              base = "dc=engines,dc=internal"
              ldap.search(:base => base, :filter => filter ) do |entry|
                # byebug
                entry.mailacceptinggeneralid.each do |email_address|
                  result << {
                    source_type: :alias,
                    user_uid: entry.uid[0],
                    email_address: email_address
                  }
                end
              end
              result
            end

            def index_email_mailboxes_email_addresses_query(ldap)
              result = []
              filter =
                Net::LDAP::Filter.eq( "objectclass", "posixAccount" ) &
                Net::LDAP::Filter.eq( "maildrop", "*" )
              base = "dc=engines,dc=internal"
              ldap.search(:base => base, :filter => filter ) do |entry|
                # byebug
                result << {
                  source_type: :mailbox,
                  user_uid: entry.uid[0],
                  email_address: entry.maildrop[0]
                }
              end
              result
            end

            def index_email_distribution_groups_email_addresses_query(ldap)
              index_email_distribution_groups_query(ldap).map do |distribution_list|
                {
                  source_type: :list,
                  distribution_list_name: distribution_list[:name],
                  email_address: distribution_list[:name]
                }
              end
            end

            # def show_email_email_address_query(ldap, email_address)
            #   result = nil
            #   filter =
            #     Net::LDAP::Filter.eq( "objectclass", "posixAccount" ) &
            #     Net::LDAP::Filter.eq( "mailacceptinggeneralid", email_address )
            #   base = "dc=engines,dc=internal"
            #   ldap.search(:base => base, :filter => filter ) do |entry|
            #     entry.mailacceptinggeneralid.each do |entry_email_address|
            #       if email_address == entry_email_address
            #         result = {
            #           email_address: email_address,
            #           maildrop: entry.maildrop[0],
            #           user_uid: entry.uid[0],
            #           user_cn: entry.cn.join(' ')
            #         }
            #       end
            #     end
            #   end
            #   byebug
            #   result
            # end

          end
        end
      end
    end
  end
end
