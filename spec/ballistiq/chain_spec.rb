RSpec.describe Ballistiq::Chain do
  it "should have a version number" do
    expect(VERSION).not_to be nil
  end

  it "should include a Blockchain class" do
    expect(Blockchain).not_to be nil
  end

  it "should inlcude a Block class" do
    expect(Block).not_to be nil
  end
end
