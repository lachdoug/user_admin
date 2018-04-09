describe V0::Api::Controllers::Users::Accounts::Emails::DistributionGroupsController do

  it 'Sets up for tests' do
    post '/email/default_domain', default_domain: { name: 'testdomain.fake' }
    post '/users/accounts/', account: { uid: 'testuser', first_name: 'Test', last_name: 'User' }
    post '/users/accounts/email', user_uid: 'testuser', email: { domain_name: 'testdomain.fake' }
    post '/email/distribution_groups/', distribution_group: {
      local_part: 'testdistribution',
      domain: 'testdomain.fake',
      description: "fake stuff"
    }
  end

  it 'Creates :users :account :email :distribution_group' do
    post '/users/accounts/email/distribution_groups/', user_uid: 'testuser', distribution_group: { name: 'testdistribution@testdomain.fake' }
    expect( response[:name] ).to eq( 'testdistribution@testdomain.fake' )
    get '/users/accounts/', uid: 'testuser'
    expect( response[:email][:distribution_groups] ).to include({
      group: 'testdistribution@testdomain.fake', email_address: "testuser@testdomain.fake"
    })
  end

  it 'Deletes :email :distribution_group' do
    delete '/email/distribution_groups/email_addresses/',
      distribution_group_name: 'testdistribution@testdomain.fake',
      address: "testuser@testdomain.fake"
    expect( response ).to eq( {} )
  end


  it 'Cleans up after tests' do
    delete! '/email/default_domain'
    delete! '/email/domains/', name: 'testdomain.fake'
    delete! '/users/accounts/email', user_uid: 'testuser'
    delete! '/users/accounts/groups', user_uid: 'testuser', names: ['Users']
    delete! '/users/accounts/', uid: 'testuser'
  end

end
