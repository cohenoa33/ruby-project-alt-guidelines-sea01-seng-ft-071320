require_relative '../config/environment'
require 'pry'
# puts "hello world"


cli = CommandLineInterface.new
# user_input= cli.greet
# name = cli.create_new_user(user_input)
# cli.menu(name)
# cli.menu_select(name)


user_outputs = UserOutputs.new
user_outputs.welcome
user_input = cli.greet
name = cli.create_new_user(user_input)
cli.menu(name)
cli.menu_select(name)


# cli.order
# cli.add_favorite
# cli.check_same_orders(name)
# cli.get_review(name)
# cli.icecream_list_with_average_rating(name)
# cli.find_old_review(name)
# cli.changed_my_mind(name, review)
# cli.find_review(action)
# cli.delete_review(review)

# String.color_samples
