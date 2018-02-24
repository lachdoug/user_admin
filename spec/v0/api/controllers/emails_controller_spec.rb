describe V0::Api::Controllers::EmailsController do

  it 'shows :email' do
    get '/email'
    expect( response ).to be_a( Hash )
    expect( response[:default_domain] ).to eq( "" )
    expect( response[:domains ] ).to eq( [] )
  end

end
