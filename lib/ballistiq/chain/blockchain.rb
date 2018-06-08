require "ballistiq/chain/block"

module Ballistiq
  module Chain
    class Blockchain
      attr_accessor :chain

      def initialize()
        @chain = [Ballistiq::Chain::Block.genesis]
      end

      def add_block(data)
        block = Ballistiq::Chain::Block.mine_block(@chain.last, data)
        @chain << block

        block
      end
    end
  end
end