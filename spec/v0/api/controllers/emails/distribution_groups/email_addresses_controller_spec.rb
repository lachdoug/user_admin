describe V0::Api::Controllers::Emails::DistributionGroups::EmailAddressesController do

  it 'Sets up for tests' do
    post '/email/default_domain', default_domain: { name: 'testdomain.fake' }
    post '/users/accounts/', account: { uid: 'testuser', first_name: 'Test', last_name: 'User', password: '123' }
    post '/users/accounts/email', user_uid: 'testuser', email: { domain_name: 'testdomain.fake' }
    post '/email/distribution_groups/', distribution_group: {
      local_part: 'testdistribution',
      domain: 'testdomain.fake',
      description: "fake stuff"
    }
  end

  it 'create :distribution_group :email_address' do
    get '/email/distribution_groups/email_addresses/new',
    distribution_group_name: "testdistribution@testdomain.fake"
    expect( response[:email_addresses] ).to be_a( Array )
    expect( response[:email_addresses] ).to include( "testuser@testdomain.fake" )

    post '/email/distribution_groups/email_addresses/',
    distribution_group_name: "testdistribution@testdomain.fake",
    email_address: { address: "testuser@testdomain.fake" }
    expect( response[:address] ).to eq( "testuser@testdomain.fake" )

    get '/email/distribution_groups/email_addresses/new',
    distribution_group_name: "testdistribution@testdomain.fake"
    expect( response[:email_addresses] ).to be_a( Array )
    expect( response[:email_addresses] ).to_not include( "testuser@testdomain.fake" )

    post '/email/distribution_groups/email_addresses/',
    distribution_group_name: "testdistribution@testdomain.fake",
    email_address: { address: "dude@testdomain.fake" }
    expect( response[:address] ).to eq( "dude@testdomain.fake" )

    get '/email/distribution_groups/', name: "testdistribution@testdomain.fake"
    expect( response[:email_addresses] ).to include( "testuser@testdomain.fake" )
    expect( response[:email_addresses] ).to include( "dude@testdomain.fake" )
  end

  it 'delete :distribution_group :email_address' do
    delete '/email/distribution_groups/email_addresses/',
    distribution_group_name: "testdistribution@testdomain.fake",
    address: "dude@testdomain.fake"
    expect( response ).to eq( {} )

    get '/email/distribution_groups/', name: "testdistribution@testdomain.fake"
    expect( response[:email_addresses] ).to include( "testuser@testdomain.fake" )
    expect( response[:email_addresses] ).to_not include( "dude@testdomain.fake" )
  end

  it 'Cleans up after tests' do
    delete '/email/distribution_groups/', name: "testdistribution@testdomain.fake"
    delete '/email/domains/', name: 'testdomain.fake'
    delete '/users/accounts/email', user_uid: 'testuser'
    delete '/users/accounts/groups', user_uid: 'testuser', dns: ["cn=Users,ou=Groups,dc=engines,dc=internal"]
    delete '/users/accounts/', uid: 'testuser'
  end

end
