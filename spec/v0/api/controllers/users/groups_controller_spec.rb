describe V0::Api::Controllers::Users::GroupsController do

  it 'index :users :groups' do
    get '/users/groups'
    expect( response.first ).to be_a( Hash )
    expect( response.first[:name] ).to be_a( String )
    expect( response.first[:dn] ).to be_a( String )
  end

  it 'show :users :group "Users" posix' do
    get '/users/groups'
    group = response.find { |group| group[:name] == "Users" }
    get '/users/groups/', dn: group[:dn]
    expect( response[:name] ).to be_a( String )
    expect( response[:dn] ).to eq( group[:dn] )
    expect( response[:members] ).to be_a( Array )
  end

  it 'show :users :group "administrators" groupofnames' do
    get '/users/groups'
    group = response.find { |group| group[:name] == "administrators" }
    get '/users/groups/', dn: group[:dn]
    expect( response[:name] ).to be_a( String )
    expect( response[:dn] ).to eq( group[:dn] )
    expect( response[:members] ).to be_a( Array )
  end

  it 'show :users :group add and remove' do
    get '/users/groups'
    user_group = response.find { |group| group[:name] == "Users" }
    administrator_group = response.find { |group| group[:name] == "administrators" }
    get '/users/groups/', dn: user_group[:dn]
    expect( response[:members] ).to_not include( "testuser" )
    get '/users/groups/', dn: administrator_group[:dn]
    expect( response[:members] ).to_not include( "testuser" )

    post '/users/accounts/', account: {
      uid: 'testuser',
      first_name: 'Test',
      last_name: 'User',
      password: '123'
    }
    get '/users/groups/', dn: user_group[:dn]
    expect( response[:members] ).to include( "testuser" )
    get '/users/groups/', dn: administrator_group[:dn]
    expect( response[:members] ).to_not include( "testuser" )

    post '/users/accounts/groups', user_uid: 'testuser',
      group_dns: [ administrator_group[:dn] ]
    get '/users/groups/', dn: administrator_group[:dn]
    expect( response[:members] ).to include( "testuser" )

    delete '/users/accounts/groups', user_uid: 'testuser', group_dns: [ administrator_group[:dn] ]
    delete '/users/accounts/groups', user_uid: 'testuser', group_dns: [ user_group[:dn] ]
    get '/users/groups/', dn: user_group[:dn]
    expect( response[:members] ).to_not include( "testuser" )
    get '/users/groups/', dn: administrator_group[:dn]
    expect( response[:members] ).to_not include( "testuser" )

  end

  it 'delete :users :account' do
    delete '/users/accounts/', uid: 'testuser'
    expect( response ).to eq( {} )
  end

end
