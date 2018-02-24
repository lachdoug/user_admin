describe V0::Api::Controllers::Users::AccountsController do

  it 'create :users :account' do
    post '/users/accounts/', account: { uid: 'testuser', first_name: 'Test', last_name: 'User' }
    expect( response[:uid] ).to eq( 'testuser' )
    expect( response[:name] ).to eq( 'Test User' )
    expect( response[:first_name] ).to eq( 'Test' )
    expect( response[:last_name] ).to eq( 'User' )
  end

  it 'index :users :accounts includes :user' do
    get '/users'
    @user = response[:accounts].find{ |user| user[:uid] == 'testuser' }
    expect( @user[:name] ).to eq( 'Test User' )
  end

  it 'show :users :account' do
    get '/users/accounts/', uid: 'testuser'
    expect( response[:uid] ).to eq( 'testuser' )
    expect( response[:name] ).to eq( 'Test User' )
    expect( response[:first_name] ).to eq( 'Test' )
    expect( response[:last_name] ).to eq( 'User' )
    expect( response[:groups] ).to eq( ['Users'] )
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
    delete '/users/accounts/', uid: 'testuser'
    expect( response ).to eq( {} )
  end

end
