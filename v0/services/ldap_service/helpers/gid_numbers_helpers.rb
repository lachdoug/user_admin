class V0
  module Services
    class LdapService
      module Helpers
        module GidNumbersHelpers

          def next_available_gidnumber_helper(ldap)
            gidnumber = nil
            loop do
              gidnumber = next_gidnumber ldap
              break unless gidnumber_in_use?(ldap, gidnumber)
              increment_next_gidnumber(ldap)
            end
            gidnumber
          end

          private

          def increment_next_gidnumber(ldap)
            ldap.modify(
              dn: "cn=gidNext,ou=System,ou=Engines,dc=engines,dc=internal",
              operations: [ [:increment, :gidNumber, '1' ] ] )
          end

          def gidnumber_in_use?(ldap, gidnumber)
            ldap.search(
              filter: Net::LDAP::Filter.eq( "gidnumber", gidnumber ),
              base: "ou=Groups,dc=engines,dc=internal").any? ||
            ldap.search(
              filter: Net::LDAP::Filter.eq( "gidnumber", gidnumber ),
              base: "ou=Distribution groups,dc=engines,dc=internal").any?
          end

          def next_gidnumber(ldap)
            result = nil
            ldap.search(
              base: "cn=gidNext,ou=System,ou=Engines,dc=engines,dc=internal",
              attributes: [ 'gidnumber' ] ) do |entry|
              entry.each do |k,v|
                result = v[0] if k == :gidnumber
              end
            end
            result
          end

        end
      end
    end
  end
end
