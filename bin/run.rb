require_relative '../config/environment'
require 'pry'
# puts "hello world"


cli = CommandLineInterface.new
user_input= cli.greet
name = cli.create_new_user(user_input)
cli.menu(name)
cli.menu_select(name)

# CREATE:
# cli.get_user_input
# cli.order
# cli.add_name_to_icecream
# cli.get_review(name)

# #READ: TOP 5
# cli.icecream_list_with_average_rating

# #UPDATE 
# yes = cli.find_review(name)
# cli.changed_my_mind(name, yes)

# #Delete
# review = cli.find_review(name)
# cli.delete_review(review)


# cli.all_reviews_grater_then_number(8)
# cli.update_ice_cream_name("Vnilla", "!!!", "WHAT???")

# cli.find_ice_cream("vanilla", "reeses")
# cli.find_user_id("taci")



# def get_review(name)
#     puts "Enjoy! please rate your ice cream (a number between 1-10)"
#     rating = gets.strip
#     favorite = update_favorite
#     Review.create(user_id: name.id, icecream_id: IceCream.last.id, rating: rating.to_i, favorite: favorite)
#     puts "Thanks #{name.name}"
# end