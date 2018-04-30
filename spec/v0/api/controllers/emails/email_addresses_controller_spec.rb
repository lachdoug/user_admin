describe V0::Api::Controllers::Emails::EmailAddressesController do

  it 'setup for tests' do
    post '/email/default_domain', default_domain: { name: 'testdomain.fake' }
    post '/users/accounts/', account: {
      uid: 'testuser', first_name: 'Test', last_name: 'User', password: '123' }
    post '/users/accounts/email', user_uid: 'testuser', email: {
      domain_name: 'testdomain.fake' }
    post '/email/distribution_groups/', distribution_group: {
      local_part: 'testdistribution',
      domain: 'testdomain.fake',
      description: "fake stuff"
    }
  end

  it 'index :email_addresses' do
    get '/email/email_addresses'
    expect( response ).to include( {
      source_type: "distribution_group",
      distribution_group_name: "testdistribution@testdomain.fake",
      email_address: "testdistribution@testdomain.fake" } )
    expect( response ).to include( {
      source_type: "mailbox",
      user_uid: "testuser",
      email_address: "testuser@testdomain.fake" } )
  end

  # it 'show :email_address' do
  #   get '/email/email_addresses/', email_address: "testdistribution@testdomain.fake"
  #   expect( response[:name] ).to eq( "testdistribution@testdomain.fake" )
  #   expect( response[:description] ).to eq( "fake stuff" )
  # end

  it 'cleanup after tests' do
    delete '/email/distribution_groups/', name: "testdistribution@testdomain.fake"
    delete '/users/accounts/groups', user_uid: 'testuser', group_dns: ["cn=Users,ou=Groups,dc=engines,dc=internal"]
    delete '/users/accounts/email', user_uid: 'testuser'
    delete '/users/accounts/', uid: 'testuser'
    delete '/email/domains/', name: 'testdomain.fake'
  end

end
