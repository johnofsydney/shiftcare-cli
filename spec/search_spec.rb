require 'rspec'
require_relative '../search'

RSpec.describe Search do
  let(:clients) do
    [
      { "full_name" => "John Doe" },
      { "full_name" => "Jane Smith" },
      { "full_name" => "Johnny Appleseed" }
    ]
  end

  describe '#initialize' do
    it 'initializes with clients and query' do
      search = Search.new(clients, 'john')
      expect(search.clients).to eq(clients)
      expect(search.query).to eq('john')
    end
  end

  describe '#call' do
    it 'returns clients that match the query' do
      search = Search.new(clients, 'john')
      results = search.call
      expect(results).to contain_exactly(
        { "full_name" => "John Doe" },
        { "full_name" => "Johnny Appleseed" }
      )
    end

    it 'returns an empty array when no clients match the query' do
      search = Search.new(clients, 'nonexistent')
      results = search.call
      expect(results).to be_empty
    end

    it 'returns all clients when all match the query' do
      search = Search.new(clients, 'j')
      results = search.call
      expect(results).to contain_exactly(
        { "full_name" => "John Doe" },
        { "full_name" => "Jane Smith" },
        { "full_name" => "Johnny Appleseed" }
      )
    end
  end
end