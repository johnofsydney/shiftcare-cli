class Duplicates
  attr_reader :clients

  def initialize(clients)
    @clients = clients
  end

  def call
    clients.group_by { |client| client["email"] }
           .select { |_, clients| clients.size > 1 }
  end
end