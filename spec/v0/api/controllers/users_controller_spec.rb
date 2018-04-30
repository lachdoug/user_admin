describe V0::Api::Controllers::UsersController do

  it 'index :users includes :user' do

    get '/users'
    expect( response ).to be_a( Hash )
    expect( response[:accounts] ).to be_a( Array )
    expect( response[:groups] ).to be_a( Array )

    @user = response[:accounts].first
    expect( @user[:name] ).to be_a( String )
    expect( @user[:uid] ).to be_a( String )

    expect( response[:groups].first ).to be_a( Hash )
    expect( response[:groups].first[:name] ).to be_a( String )
    expect( response[:groups].first[:dn] ).to be_a( String )

  end

end
