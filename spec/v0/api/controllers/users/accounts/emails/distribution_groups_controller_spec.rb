describe V0::Api::Controllers::Users::Accounts::Emails::DistributionGroupsController do

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

  it 'Shows :email :distribution_group does not yet have :user :mailbox' do
    get '/email/distribution_groups/', name: "testdistribution@testdomain.fake"
    expect( response[:email_addresses] ).to_not include( "testuser@testdomain.fake" )
  end

  it 'Creates :users :account :email :distribution_group' do
    get '/users/accounts/email/distribution_groups/new', user_uid: 'testuser'
    expect( response[:distribution_groups] ).to include( 'testdistribution@testdomain.fake' )

    post '/users/accounts/email/distribution_groups/', user_uid: 'testuser', distribution_group: { name: 'testdistribution@testdomain.fake' }
    expect( response[:name] ).to eq( 'testdistribution@testdomain.fake' )
    get '/users/accounts/', uid: 'testuser'
    expect( response[:email][:distribution_groups] ).to include({
      name: 'testdistribution@testdomain.fake', email_address: "testuser@testdomain.fake"
    })
  end

  it 'Deletes :distribution_group :email_address' do
    get '/email/distribution_groups/', name: "testdistribution@testdomain.fake"
    expect( response[:email_addresses] ).to include( "testuser@testdomain.fake" )

    delete '/email/distribution_groups/email_addresses/',
    distribution_group_name: "testdistribution@testdomain.fake",
    address: "testuser@testdomain.fake"
    expect( response ).to eq( {} )

    get '/users/accounts/', uid: 'testuser'
    expect( response[:email][:distribution_groups] ).to_not include({
      name: 'testdistribution@testdomain.fake', email_address: "testuser@testdomain.fake"
    })
  end

  it 'Cleans up after tests' do
    delete '/email/default_domain'
    delete '/email/domains/', name: 'testdomain.fake'
    delete '/users/accounts/email', user_uid: 'testuser'
    delete '/users/accounts/groups', user_uid: 'testuser', group_dns: ["cn=Users,ou=Groups,dc=engines,dc=internal"]
    delete '/users/accounts/', uid: 'testuser'
  end

end
