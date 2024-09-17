class Search
  attr_reader :query, :clients, :field_name

  def initialize(clients, query, field_name = "full_name")
    @clients = clients
    @query = query
    @field_name = field_name
  end

  def call
    clients.select { |client| client[field_name].downcase.include?(query.downcase) }
  end
end
