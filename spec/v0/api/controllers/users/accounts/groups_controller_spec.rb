describe V0::Api::Controllers::Users::Accounts::GroupsController do

  it 'creates :users :account and :groups includes "Users"' do
    post '/users/accounts/', account: { uid: 'testuser', first_name: 'Test', last_name: 'User', password: '123' }
    expect( response[:groups] ).to include( {
      name: "Users", dn: "cn=Users,ou=Groups,dc=engines,dc=internal" } )
  end

  it 'deletes, creates, deletes :users :account :groups' do
    delete '/users/accounts/groups', user_uid: 'testuser', group_dns: [
      "cn=Users,ou=Groups,dc=engines,dc=internal" ]
    expect( response ).to eq( {} )

    get '/users/accounts/', uid: 'testuser'
    expect( response[:groups] ).to_not include( {
      name: "Users", dn: "cn=Users,ou=Groups,dc=engines,dc=internal" } )

    get '/users/accounts/groups/new', user_uid: 'testuser'
    expect( response[:groups] ).to include( {
      name: "Users", dn: "cn=Users,ou=Groups,dc=engines,dc=internal" } )
    expect( response[:groups] ).to include( {
      name: "data_access", dn: "cn=data_access,ou=Groups,dc=engines,dc=internal" } )

    post '/users/accounts/groups', user_uid: 'testuser',
      group_dns: [
        "cn=Users,ou=Groups,dc=engines,dc=internal",
        "cn=data_access,ou=Groups,dc=engines,dc=internal"
      ]
    expect( response ).to include( { name: "Users", dn: "cn=Users,ou=Groups,dc=engines,dc=internal" } )
    expect( response ).to include( { name: "data_access", dn: "cn=data_access,ou=Groups,dc=engines,dc=internal" } )

    get '/users/accounts/', uid: 'testuser'
    expect( response[:groups] ).to include( { name: "Users", dn: "cn=Users,ou=Groups,dc=engines,dc=internal" } )
    expect( response[:groups] ).to include( { name: "data_access", dn: "cn=data_access,ou=Groups,dc=engines,dc=internal" } )

    delete '/users/accounts/groups', user_uid: 'testuser', group_dns: [
      "cn=Users,ou=Groups,dc=engines,dc=internal",
      "cn=data_access,ou=Groups,dc=engines,dc=internal" ]
    expect( response ).to eq( {} )

    get '/users/accounts/', uid: 'testuser'
    expect( response[:groups] ).to_not include( {
      name: "Users",
      dn: "cn=Users,ou=Groups,dc=engines,dc=internal" } )
    expect( response[:groups] ).to_not include( {
      name: "data_access",
      dn: "cn=data_access,ou=Groups,dc=engines,dc=internal" } )
  end

  it 'creates, deletes :users :account :administrator_group' do
    get '/users/accounts/', uid: 'testuser'
    expect( response[:groups] ).to_not include( {
      name: "administrators", dn: "cn=administrators,ou=Groups,dc=engines,dc=internal" } )

    get '/users/accounts/groups/new', user_uid: 'testuser'
    expect( response[:groups] ).to include( {
      name: "administrators", dn: "cn=administrators,ou=Groups,dc=engines,dc=internal" } )

    post '/users/accounts/groups', user_uid: 'testuser',
      group_dns: [
        "cn=administrators,ou=Groups,dc=engines,dc=internal",
      ]
    expect( response ).to include( { name: "administrators", dn: "cn=administrators,ou=Groups,dc=engines,dc=internal" } )

    get '/users/accounts/', uid: 'testuser'
    expect( response[:groups] ).to include( { name: "administrators", dn: "cn=administrators,ou=Groups,dc=engines,dc=internal" } )

    delete '/users/accounts/groups', user_uid: 'testuser', group_dns: [
      "cn=administrators,ou=Groups,dc=engines,dc=internal" ]
    expect( response ).to eq( {} )

    get '/users/accounts/', uid: 'testuser'
    expect( response[:groups] ).to_not include( {
      name: "administrators", dn: "cn=administrators,ou=Groups,dc=engines,dc=internal" } )
  end

  it 'delete :users :account' do
    delete '/users/accounts/', uid: 'testuser'
    expect( response ).to eq( {} )
  end

end
