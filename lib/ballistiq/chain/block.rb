require 'digest/sha2'

module Ballistiq
  module Chain
    class Block
      attr_accessor :timestamp, :lastHash, :hash, :payload

      def initialize(timestamp, lastHash, hash, payload)
        @timestamp = timestamp
        @lastHash = lastHash
        @hash = hash
        @payload = payload
      end

      def to_s
        "Block -\n"\
        "\tTimestamp: #{@timestamp}\n"\
        "\tLast Hash: #{@lastHash}\n"\
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

      def self.mine_block(lastBlock, payload)
        timestamp = Time.now
        lastHash = lastBlock.hash
        hash = self.hash(timestamp, lastHash, payload)
        # Return a new block
        self.new(timestamp, lastHash, hash, payload)
      end

      def self.hash(timestamp, lastHash, payload)
        Digest::SHA512.new.hexdigest("#{timestamp}#{lastHash}#{payload}")
      end

    end
  end
end
