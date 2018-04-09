describe V0::Api::Controllers::Emails::DistributionGroupsController do

  it 'setup for tests' do
    post '/email/default_domain', default_domain: { name: 'testdomain.fake' }
  end

  it 'create :distribution_group' do
    post '/email/distribution_groups/', distribution_group: {
      local_part: 'testdistribution',
      domain: 'testdomain.fake',
      description: "fake stuff"
    }
  end

  it 'index :distribution_groups' do
    get '/email/distribution_groups'
    expect( response ).to include( {
      name: "testdistribution@testdomain.fake",
      description: "fake stuff"
    } )
  end

  it 'show :distribution_group' do
    get '/email/distribution_groups/', name: "testdistribution@testdomain.fake"
    expect( response[:name] ).to eq( "testdistribution@testdomain.fake" )
    expect( response[:description] ).to eq( "fake stuff" )
  end

  it 'update :distribution_group' do
    put '/email/distribution_groups/',
    name: "testdistribution@testdomain.fake",
    distribution_group: {
      local_part: 'testdistribution1',
      domain: 'testdomain.fake',
      description: "fake stuff1"
    }
    expect( response[:name] ).to eq( "testdistribution1@testdomain.fake" )
    expect( response[:description] ).to eq( "fake stuff1" )
  end

  it 'show :distribution_group after update' do
    get '/email/distribution_groups/', name: "testdistribution1@testdomain.fake"
    expect( response[:name] ).to eq( "testdistribution1@testdomain.fake" )
    expect( response[:description] ).to eq( "fake stuff1" )
  end

  it 'delete :distribution_group' do
    delete '/email/distribution_groups/', name: "testdistribution1@testdomain.fake"
    expect( response ).to eq( {} )
  end

  it 'cleanup after tests' do
    delete! '/email/domains/', name: 'testdomain.fake'
    delete! '/email/default_domain'
  end

end
