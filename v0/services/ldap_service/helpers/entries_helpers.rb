class V0
  module Services
    class LdapService
      module Helpers
        module EntriesHelpers

          def add_entry_helper( ldap, dn, attributes )
            ldap.add(dn: dn, attributes: attributes )
          end

          def delete_entry_helper(ldap, entry)
            ldap.delete dn: entry.dn
          end

          def add_class_to_entry_helper( ldap, entry, klass )
            # unless entry.objectClass.include? klass
              ldap.modify(
                dn: entry.dn,
                operations: [ [:add, :objectClass, klass ] ]
              )
            # end
          end

          def remove_class_from_entry_helper( ldap, entry, klass )
            # if entry.objectClass.include? klass
              ldap.modify(
                dn: entry.dn,
                operations: [ [:delete, :objectClass, klass ] ]
              )
            # end
          end

          def update_entry_rdn_helper( ldap, entry, newrdn )
            ldap.rename({
                olddn: entry.dn,
                newrdn: newrdn,
                delete_attributes: true
              })
          end

          def add_attribute_value_to_entry_helper( ldap, entry, attribute, value )
            # if entry.respond_to?(attribute)
            #   ldap.modify(
            #     dn: entry.dn,
            #     operations: [ [:add, attribute, value ] ]
            #   )
            # else
              ldap.add_attribute( entry.dn, attribute, value )
            # end
          end

          def delete_attribute_value_from_entry_helper( ldap, entry, attribute, value )
            ldap.modify(dn: entry.dn, operations: [ [:delete, attribute, value ] ] )
          end

          def delete_attribute_from_entry_helper( ldap, entry, attribute )
            # if entry.respond_to?(attribute)
              ldap.modify(dn: entry.dn, operations: [ [:delete, attribute, nil ] ] )
            # end
          end

          def replace_attribute_value_on_entry_helper( ldap, entry, attribute, value )
            ldap.replace_attribute entry.dn, attribute, value
          end

        end
      end
    end
  end
end
