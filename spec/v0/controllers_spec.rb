describe V0::Api::Controllers do

  it 'Remove artifacts that may remain from previous failed tests.' do
      delete! '/users/accounts/groups', user_uid: 'testuser', names: ['Users']
      delete! '/users/accounts/groups', user_uid: 'testuser', names: ['data_access']
      delete! '/users/accounts/email', user_uid: 'testuser'
      delete! '/users/accounts/', uid: 'testuser'

      get '/email'
      domains = response[:domains]
      default_domain = response[:default_domain]
      non_default_domains = domains - [ default_domain ]
      non_default_domains.each do |domain|
        delete! '/email/domains/', name: domain
      end
      delete! '/email/domains/', name: default_domain

      delete! '/email/distribution_groups/email_addresses/',
        distribution_group_name: "testdistribution@testdomain.fake",
        email_address: { address: "testuser@testdomain.fake" }
      delete! '/email/distribution_groups/', name: "testdistribution@testdomain.fake"
      delete! '/email/distribution_groups/', name: "testdistribution1@testdomain.fake"
  end

end
