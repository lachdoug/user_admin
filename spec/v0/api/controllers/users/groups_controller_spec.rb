describe V0::Api::Controllers::Users::GroupsController do

  it 'index :users :groups' do
    get '/users/groups'
    expect( response.first ).to be_a( Hash )
    expect( response.first[:name] ).to be_a( String )
    expect( response.first[:dn] ).to be_a( String )
  end

  it 'show :users :group "Users"' do
    get '/users/groups'
    dn = response.first[:dn]
    get '/users/groups/', dn: dn
    expect( response[:name] ).to be_a( String )
    expect( response[:dn] ).to eq( dn )
    expect( response[:members] ).to be_a( Array )
  end

end
