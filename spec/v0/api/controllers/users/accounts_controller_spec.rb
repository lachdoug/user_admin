describe V0::Api::Controllers::Users::AccountsController do

  it 'index :users :accounts does not include "testuser"' do
    get '/users/accounts'
    expect( response ).to be_a( Array )
    @account = response.find{ |user| user[:uid] == 'testuser' }
    expect( @account ).to eq( nil )
  end

  it 'create :users :account' do
    post '/users/accounts/', account: {
      uid: 'testuser',
      first_name: 'Test',
      last_name: 'User',
      password: '123' }
    expect( response[:uid] ).to eq( 'testuser' )
    expect( response[:name] ).to eq( 'Test User' )
    expect( response[:first_name] ).to eq( 'Test' )
    expect( response[:last_name] ).to eq( 'User' )
    expect( response[:password] ).to eq( nil )
  end

  it 'index :users :accounts includes "testuser"' do
    get '/users/accounts'
    @account = response.find{ |user| user[:uid] == 'testuser' }
    expect( @account[:name] ).to eq( 'Test User' )
  end

  it 'show :users includes :accounts "testuser"' do
    get '/users'
    @account = response[:accounts].find{ |user| user[:uid] == 'testuser' }
    expect( @account[:name] ).to eq( 'Test User' )
  end

  it 'show :users :account' do
    get '/users/accounts/', uid: 'testuser'
    expect( response[:uid] ).to eq( 'testuser' )
    expect( response[:name] ).to eq( 'Test User' )
    expect( response[:first_name] ).to eq( 'Test' )
    expect( response[:last_name] ).to eq( 'User' )
    expect( response[:groups] ).to eq( [ { name: 'Users',
      dn: "cn=Users,ou=Groups,dc=engines,dc=internal" } ] )
    expect( response[:email] ).to eq( {} )
  end

  it 'update :users :account' do
    put '/users/accounts/', uid: 'testuser', account: { first_name: 'Testy', last_name: 'Users' }
    expect( response[:uid] ).to eq( 'testuser' )
    expect( response[:name] ).to eq( 'Testy Users' )
    expect( response[:first_name] ).to eq( 'Testy' )
    expect( response[:last_name] ).to eq( 'Users' )
  end

  it 'delete :users :account' do
    delete '/users/accounts/groups', user_uid: 'testuser', group_dns: ["cn=Users,ou=Groups,dc=engines,dc=internal"]
    delete '/users/accounts/', uid: 'testuser'
    expect( response ).to eq( {} )
  end

end
