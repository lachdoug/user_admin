describe V0::Api::Controllers::DnLookupsController do

  it 'shows :dn for :account' do
    post '/users/accounts/', account: {
      uid: 'testuser',
      first_name: 'Test',
      last_name: 'User',
      password: '123' }

    get '/dn_lookup', user_auth: { uid: "testuser", password: "123" }
    expect( response ).to be_a( Hash )
    expect( response[:dn] ).to be_a( String )

    expect {
    get '/dn_lookup', user_auth: { uid: "testuser", password: "111" }
     }.to raise_error V0::Services::LdapService::Error

    delete '/users/accounts/groups', user_uid: 'testuser', names: ['Users']
    delete '/users/accounts/', uid: 'testuser'
  end

end
