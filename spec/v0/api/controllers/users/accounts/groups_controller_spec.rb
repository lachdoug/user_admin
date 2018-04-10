describe V0::Api::Controllers::Users::Accounts::GroupsController do

  it 'creates :users :account and :groups includes "Users"' do
    post '/users/accounts/', account: { uid: 'testuser', first_name: 'Test', last_name: 'User', password: '123' }
    expect( response[:groups] ).to include( 'Users' )
  end

  it 'deletes, creates, deletes :users :account :groups' do
    delete '/users/accounts/groups', user_uid: 'testuser', names: ['Users']
    expect( response ).to eq( {} )

    get '/users/accounts/', uid: 'testuser'
    expect( response[:groups] ).to_not include( 'Users' )

    get '/users/accounts/groups/new', user_uid: 'testuser'
    expect( response[:groups] ).to include( 'Users' )
    expect( response[:groups] ).to include( 'data_access' )

    post '/users/accounts/groups', user_uid: 'testuser', groups: [ { name: 'Users' }, { name: "data_access"} ]
    expect( response ).to include( { name: 'Users' } )
    expect( response ).to include( { name: 'data_access' } )

    get '/users/accounts/', uid: 'testuser'
    expect( response[:groups] ).to include( 'Users' )
    expect( response[:groups] ).to include( 'data_access' )

    delete '/users/accounts/groups', user_uid: 'testuser', names: ['Users', 'data_access']
    expect( response ).to eq( {} )

    get '/users/accounts/', uid: 'testuser'
    expect( response[:groups] ).to_not include( 'Users' )
  end

  it 'delete :users :account' do
    delete '/users/accounts/', uid: 'testuser'
    expect( response ).to eq( {} )
  end

end
