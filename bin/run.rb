require_relative '../config/environment'
require 'pry'
# puts "hello world"


cli = CommandLineInterface.new
user_input= cli.greet
name = cli.create_new_user(user_input)
cli.menu(name)
cli.menu_select(name)


# puts cli_methods.method_name"Hey, what's the scoop? Tell us your name!"
# cli_methods = CliMethods.new