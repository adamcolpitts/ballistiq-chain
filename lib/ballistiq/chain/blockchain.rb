require "ballistiq/chain/block"
require "json"

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

      def is_valid_chain(chain)
        if chain[0].to_json != Ballistiq::Chain::Block.genesis.to_json
          return false
        end

        counter = 1
        chain.each do |el, i|
          block = chain[counter]
          last_block = chain[counter-1]

          if block.last_hash != last_block.hash ||
                block.hash != Ballistiq::Chain::Block.block_hash(block)
            return false
          end
          counter += 1 if counter < chain.size - 1
        end

        true
      end
    end
  end
end