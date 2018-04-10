describe V0::Api::Controllers::Users::AccountsController do

  it 'Sets up for tests' do
    post '/users/accounts/', account: { uid: 'testuser', first_name: 'Test', last_name: 'User', password: '123' }
  end

  it 'update :users :account :password' do
    put '/users/accounts/password', user_uid: 'testuser', password: { current: '123', new: '321' }
    expect( response ).to eq( {} )
  end

  it 'Cleans up after tests' do
    delete '/users/accounts/groups', user_uid: 'testuser', names: ['Users']
    delete '/users/accounts/', uid: 'testuser'
  end

end
