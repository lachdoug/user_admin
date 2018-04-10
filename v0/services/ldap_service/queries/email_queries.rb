class V0
  module Services
    class LdapService
      module Queries
        module EmailQueries

          require_relative 'email_queries/default_domain_queries'
          require_relative 'email_queries/distribution_groups_queries'
          require_relative 'email_queries/domains_queries'
          require_relative 'email_queries/email_addresses_queries'

          include DefaultDomainQueries
          include DistributionGroupsQueries
          include DomainsQueries
          include EmailAddressesQueries

          def show_email_query( ldap )
            {
              default_domain: show_email_default_domain_query( ldap ),
              domains: index_email_domains_query( ldap ),
              distribution_groups: index_email_distribution_groups_query( ldap )
            }
          end

        end
      end
    end
  end
end
