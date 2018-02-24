describe V0::Api::Controllers::Emails::DomainsController do

  it 'creates :email :domain' do
    post '/email/domains/', domain: { name: 'testdomain.fake' }
    expect( response[:name] ).to eq( 'testdomain.fake' )
  end

  it 'shows :email includes :domain' do
    get '/email'
    expect( response[:domains] ).to include( 'testdomain.fake' )
  end

  it 'deletes :email :domain' do
    delete '/email/domains/', name: 'testdomain.fake'
    expect( response ).to eq( {} )
  end

  it 'shows :email does not include :domain' do
    get '/email'
    expect( response[:domains] ).to_not include( 'testdomain.fake' )
  end

end
