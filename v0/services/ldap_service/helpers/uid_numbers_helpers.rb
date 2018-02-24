class V0
  module Services
    class LdapService
      module Helpers
        module UidNumbersHelpers

          def next_available_uidnumber_helper(ldap)
            uidnumber = nil
            loop do
              uidnumber = next_uidnumber ldap
              break unless uidnumber_in_use?(ldap, uidnumber)
              increment_next_uidnumber(ldap)
            end
            uidnumber
          end

          private

          def increment_next_uidnumber(ldap)
            ldap.modify(
              dn: "cn=uidNext,ou=System,ou=Engines,dc=engines,dc=internal",
              operations: [ [:increment, :uidNumber, '1' ] ] )
          end

          def uidnumber_in_use?(ldap, uidnumber)
            ldap.search(
              filter: Net::LDAP::Filter.eq( "uidnumber", uidnumber ),
              base: "ou=People,dc=engines,dc=internal").any?
          end

          def next_uidnumber(ldap)
            result = nil
            ldap.search(
              base: "cn=uidNext,ou=System,ou=Engines,dc=engines,dc=internal",
              attributes: [ 'uidnumber' ] ) do |entry|
              entry.each do |k,v|
                result = v[0] if k == :uidnumber
              end
            end
            result
          end

        end
      end
    end
  end
end
