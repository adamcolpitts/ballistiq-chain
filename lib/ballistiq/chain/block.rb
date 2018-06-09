require 'digest/sha2'

module Ballistiq
  module Chain
    class Block
      attr_accessor :timestamp, :last_hash, :hash, :payload

      def initialize(timestamp, last_hash, hash, payload)
        @timestamp = timestamp
        @last_hash = last_hash
        @hash = hash
        @payload = payload
      end

      def to_s
        "Block -\n"\
        "\tTimestamp: #{@timestamp}\n"\
        "\tLast Hash: #{@last_hash}\n"\
        "\tHash:      #{@hash}\n"\
        "\tPayload:   #{@payload}"
      end

      def self.genesis
        self.new(
          'Genesis time',
          '-----',
          'f1r57-h45h',
          [])
      end

      def self.mine_block(last_block, payload)
        timestamp = Time.now
        last_hash = last_block.hash
        hash = self.hash(timestamp, last_hash, payload)
        # Return a new block
        self.new(timestamp, last_hash, hash, payload)
      end

      def self.hash(timestamp, last_hash, payload)
        Digest::SHA512.new.hexdigest("#{timestamp}#{last_hash}#{payload}").to_s
      end

      def self.block_hash(block)
        self.hash(block.timestamp, block.last_hash, block.payload)
      end

    end
  end
end
