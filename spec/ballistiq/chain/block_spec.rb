RSpec.describe Block do
  before do
    @data = 'bar'
    @lastBlock = Block.genesis
    @block = Block.mine_block(@lastBlock, @data)
  end

  it "should set the `payload` to match the input" do
    expect(@block.payload).to eq(@data)
  end

  it "should set the `last_hash` to match the hash of the last block" do
    expect(@block.last_hash).to eq(@lastBlock.hash)
  end

end