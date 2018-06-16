RSpec.describe Blockchain do
  before do
    @bc = Blockchain.new
    @bc2 = Blockchain.new
  end

  it "should start with the genesis block" do
    expect(@bc.chain.first.to_json).to eq(Block.genesis.to_json)
  end

  it "should add a new block" do
    data = 'foo'
    @bc.add_block(data)
    expect(@bc.chain.last.payload).to eq(data)
  end

  it "should validate a valid chain" do
    @bc2.add_block('foo')
    expect(@bc.is_valid_chain(@bc2.chain)).to eq(true)
  end

  it "should invalidate a chain with a corrupt genesis block" do
    @bc2.chain[0].payload = 'invalid data'
    expect(@bc.is_valid_chain(@bc2.chain)).to be_falsey
  end

  it "should invalidate a corrupt chain" do
    @bc2.add_block('foo')
    @bc2.chain[1].payload = 'invalid data'
    expect(@bc.is_valid_chain(@bc2.chain)).to be_falsey
  end

  it "should replace the chain with a valid chain" do
    @bc2.add_block('goo')
    @bc.replace_chain(@bc2.chain)
    expect(@bc.chain).to eq(@bc2.chain)
  end

  it "should not replace the chain with one of less than or equal length" do
    @bc.add_block('foo')
    @bc.replace_chain(@bc2.chain)
    expect(@bc.chain).not_to eq(@bc2.chain)
  end

end