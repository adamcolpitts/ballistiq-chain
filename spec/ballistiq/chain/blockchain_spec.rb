RSpec.describe Blockchain do
  before do
    @bc = Blockchain.new
  end

  it "should start with the genesis block" do
    expect(@bc.chain.first.to_json).to eq(Block.genesis.to_json)
  end

  it "should add a new block" do
    data = 'foo'
    @bc.add_block(data)
    expect(@bc.chain.last.payload).to eq(data)
  end
end