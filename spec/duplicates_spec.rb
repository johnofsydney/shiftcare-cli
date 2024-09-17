require 'rspec'
require_relative "../duplicates"

RSpec.describe Duplicates do
  let(:clients) do
    [
      { "email" => "john@example.com", "full_name" => "John Doe" },
      { "email" => "jane@example.com", "full_name" => "Jane Smith" },
      { "email" => "john@example.com", "full_name" => "Johnathan Doe" },
      { "email" => "alice@example.com", "full_name" => "Alice Johnson" },
      { "email" => "bob@example.com", "full_name" => "Bob Brown" },
      { "email" => "jane@example.com", "full_name" => "Janet Smith" }
    ]
  end

  describe "#initialize" do
    it "initializes with a list of clients" do
      duplicates = Duplicates.new(clients)
      expect(duplicates.clients).to eq(clients)
    end
  end

  describe "#call" do
    it "returns an empty hash when there are no duplicates" do
      unique_clients = [
        { "email" => "john@example.com", "full_name" => "John Doe" },
        { "email" => "jane@example.com", "full_name" => "Jane Smith" }
      ]
      duplicates = Duplicates.new(unique_clients)
      expect(duplicates.call).to eq({})
    end

    it "returns a hash with duplicate clients grouped by email" do
      duplicates = Duplicates.new(clients)
      result = duplicates.call
      expect(result.keys).to contain_exactly("john@example.com", "jane@example.com")
      expect(result["john@example.com"].size).to eq(2)
      expect(result["jane@example.com"].size).to eq(2)
    end

    it "returns a hash with all clients when all are duplicates" do
      all_duplicates = [
        { "email" => "john@example.com", "full_name" => "John Doe" },
        { "email" => "john@example.com", "full_name" => "Johnathan Doe" }
      ]
      duplicates = Duplicates.new(all_duplicates)
      result = duplicates.call
      expect(result.keys).to contain_exactly("john@example.com")
      expect(result["john@example.com"].size).to eq(2)
    end
  end
end
