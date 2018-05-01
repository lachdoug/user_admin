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
                result << {
                  source_type: :mailbox,
                  user_uid: entry.uid[0],
                  email_address: entry.maildrop[0]
                }
              end
              result
            end

            def index_email_distribution_groups_email_addresses_query(ldap)
              index_email_distribution_groups_query(ldap).map do |distribution_group|
                {
                  source_type: :distribution_group,
                  distribution_group_name: distribution_group[:name],
                  email_address: distribution_group[:name]
                }
              end
            end

          end
        end
      end
    end
  end
end
