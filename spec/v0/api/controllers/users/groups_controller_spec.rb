describe V0::Api::Controllers::Users::GroupsController do

  it 'index :users :groups' do
    get '/users/groups'
    expect( response.first ).to be_a( String )
  end

  it 'show :users :group "Users"' do
    get '/users/groups'
    name = response.first
    get '/users/groups/', name: name
    expect( response[:name] ).to eq( "Users" )
    expect( response[:members] ).to be_a( Array )
  end

end
