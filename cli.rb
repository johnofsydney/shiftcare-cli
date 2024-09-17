require 'json'
require_relative 'search'
require_relative 'duplicates'


class CLI
  def self.clients(file = 'clients.json')
    clients_json = File.read(file)
    JSON.parse(clients_json)
  end

  def self.run
    puts "Welcome to the CLI app!"
    puts "Available commands:"
    puts "1. search <query>"
    puts "2. duplicates"
    puts "3. exit"

    loop do
      print "> "
      input = gets.chomp
      command, *args = input.split(" ")

      case command
      when "search"
        puts Search.new(clients, args[0]).call
      when "duplicates"
        puts Duplicates.new(clients).call
      when "exit"
        puts "Goodbye!"
        break
      else
        puts "Invalid command. Please try again."
      end
    end
  end
end

CLI.run
