describe V0::Api::Controllers::Users::Accounts::Emails::AliasesController do

  it 'Sets up for tests' do
    post '/email/default_domain', default_domain: { name: 'testdomain.fake' }
    post '/users/accounts/', account: { uid: 'testuser', first_name: 'Test', last_name: 'User', password: '123' }
    post '/users/accounts/email', user_uid: 'testuser', email: { domain_name: 'testdomain.fake' }
  end

  it 'Creates :users :account :email :alias' do
    post '/users/accounts/email/aliases/', user_uid: 'testuser', alias: { address: 'testuser@testdomain.fake' }
    expect( response[:address] ).to eq( 'testuser@testdomain.fake' )
    get '/users/accounts/', uid: 'testuser'
    expect( response[:email][:aliases] ).to include( 'testuser@testdomain.fake' )
  end

  it 'Deletes :users :account :email :alias' do
    delete '/users/accounts/email/aliases/', user_uid: 'testuser', address: 'testuser@testdomain.fake'
    expect( response ).to eq( {} )
  end

  it 'Cleans up after tests' do
    delete '/email/default_domain'
    delete '/email/domains/', name: 'testdomain.fake'
    delete '/users/accounts/email', user_uid: 'testuser'
    delete '/users/accounts/groups', user_uid: 'testuser', group_dns: ["cn=Users,ou=Groups,dc=engines,dc=internal"]
    delete '/users/accounts/', uid: 'testuser'
  end

end
