describe V0::Api::Controllers::Users::Accounts::EmailsController do

  it 'Sets up for tests' do
    post '/email/default_domain', default_domain: { name: 'testdomain.fake' }
    post '/users/accounts/', account: { uid: 'testuser', first_name: 'Test', last_name: 'User', password: '123' }
    expect( response[:email] ).to eq( {} )
  end

  it 'Creates :users :account :email' do
    post '/users/accounts/email', user_uid: 'testuser', email: { domain_name: 'testdomain.fake' }
    expect( response[:domain_name] ).to eq( 'testdomain.fake' )
    get '/users/accounts/', uid: 'testuser'
    expect( response[:email][:mailbox] ).to eq( 'testuser@testdomain.fake' )
  end

  it 'Updates :users :account :email' do
    get '/users/accounts/email/edit', user_uid: 'testuser'
    expect( response[:domain_name] ).to eq( 'testdomain.fake' )
    expect( response[:email_domains] ).to include( 'testdomain.fake' )
    put '/users/accounts/email', user_uid: 'testuser', email: { domain_name: 'testdomain1.fake' }
    expect( response[:domain_name] ).to eq( 'testdomain1.fake' )
    get '/users/accounts/', uid: 'testuser'
    expect( response[:email][:mailbox] ).to eq( 'testuser@testdomain1.fake' )
  end

  it 'Deletes :users :account :email' do
    delete '/users/accounts/email', user_uid: 'testuser'
    expect( response ).to eq( {} )
  end

  it 'Cleans up after tests' do
    delete '/email/default_domain'
    delete '/email/domains/', name: 'testdomain.fake'
    delete '/users/accounts/groups', user_uid: 'testuser', dns: ["cn=Users,ou=Groups,dc=engines,dc=internal"]
    delete '/users/accounts/', uid: 'testuser'
  end

end
