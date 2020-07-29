require_relative '../config/environment'
require 'pry'
# puts "hello world"



cli = CommandLineInterface.new
user_input= cli.greet
name = cli.create_new_user(user_input)
# cli.menu(name)
# cli.get_user_input
# cli.order
# cli.add_name_to_icecream
# cli.get_review(name)
# cli.all_reviews_greater_than_number
# cli.top_five
# cli.icecream_list_with_average_rating
# favorite = cli.add_favorite
# review = cli.create_new_review(name, icecream, rating, favorite)

review = cli.find_review(name)
cli.delete_review(review)


# cli.all_reviews_grater_then_number(8)
# cli.update_ice_cream_name("Vnilla", "!!!", "WHAT???")

# cli.find_ice_cream("vanilla", "reeses")
# cli.find_user_id("taci")