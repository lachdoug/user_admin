describe V0::Api::Controllers do

  it 'Remove artifacts that may remain from previous failed tests.' do
      delete! '/users/accounts/groups', user_uid: 'testuser', names: ['Users']
      delete! '/users/accounts/', uid: 'testuser'
      delete! '/email/domains/', name: 'testdomain.fake'
      delete! '/email/domains/', name: 'testdomain1.fake'
      delete! '/email/default_domain'
      delete! '/email/distribution_groups/email_addresses/',
        distribution_group_name: "testdistribution@testdomain.fake",
        email_address: { address: "testuser@testdomain.fake" }
      delete! '/email/distribution_groups/', name: "testdistribution@testdomain.fake"
      delete! '/email/distribution_groups/', name: "testdistribution1@testdomain.fake"
  end

end
