describe V0::Api::Controllers::Emails::DistributionGroups::EmailAddressesController do

  it 'setup for tests' do
    post '/email/default_domain', default_domain: { name: 'testdomain.fake' }
    post '/email/distribution_groups/', distribution_group: {
      local_part: 'testdistribution',
      domain: 'testdomain.fake',
      description: "fake stuff"
    }
  end

  it 'create :distribution_group :email_address' do
    post '/email/distribution_groups/email_addresses/',
    distribution_group_name: "testdistribution@testdomain.fake",
    email_address: { address: "dude@testdomain.fake" }
    expect( response[:address] ).to eq( "dude@testdomain.fake" )
  end

  it 'delete :distribution_group :email_address' do
    delete '/email/distribution_groups/email_addresses/',
    distribution_group_name: "testdistribution@testdomain.fake",
    address: "dude@testdomain.fake"
    expect( response ).to eq( {} )
  end

  it 'clean up after tests' do
    delete! '/email/distribution_groups/', name: "testdistribution@testdomain.fake"
    delete! '/email/domains/', name: 'testdomain.fake'
    delete! '/email/default_domain'
  end

end
