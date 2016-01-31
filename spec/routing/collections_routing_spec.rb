require 'spec_helper'

describe 'routes for collections' do
  it { expect(get: collections_path(1)).to be_routable }
  it { expect(get: collection_path(1)).to be_routable }
end
