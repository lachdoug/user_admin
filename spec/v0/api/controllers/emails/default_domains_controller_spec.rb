describe V0::Api::Controllers::Emails::DefaultDomainsController do

  it 'initially shows :email with nil value for :default_domain' do
    get '/email'
    expect( response[:default_domain] ).to eq( "" )
    expect( response[:domains] ).to eq( [] )
  end

  it 'create :email :default_domain' do
    post '/email/default_domain', default_domain: { name: 'testdomain.fake' }
    expect( response[:name] ).to eq( 'testdomain.fake' )

    get '/email'
    expect( response[:domains] ).to include( "testdomain.fake" )
    expect( response[:default_domain] ).to eq( "testdomain.fake" )
  end

  it 'update :email :default_domain' do
    post '/email/domains/', domain: { name: 'testdomain1.fake' }
    expect( response[:name] ).to eq( 'testdomain1.fake' )

    put '/email/default_domain', default_domain: { name: 'testdomain1.fake' }
    expect( response[:name] ).to eq( 'testdomain1.fake' )

    get '/email'
    expect( response[:default_domain] ).to eq( 'testdomain1.fake' )
  end

  it 'delete all :domains will delete :email :default_domain' do
    delete '/email/domains/', name: 'testdomain.fake'
    expect( response ).to eq( {} )
    delete '/email/domains/', name: 'testdomain1.fake'
    expect( response ).to eq( {} )

    get '/email'
    expect( response[:default_domain] ).to eq("")
  end

  it 'delete :email :default_domain' do
    post '/email/default_domain', default_domain: { name: 'testdomain.fake' }
    expect( response[:name] ).to eq( 'testdomain.fake' )

    get '/email'
    expect( response[:domains] ).to include( "testdomain.fake" )
    expect( response[:default_domain] ).to eq( "testdomain.fake" )

    delete '/email/default_domain'
    expect( response ).to eq( {} )

    delete '/email/domains/', name: 'testdomain.fake'
    expect( response ).to eq( {} )
  end

end
