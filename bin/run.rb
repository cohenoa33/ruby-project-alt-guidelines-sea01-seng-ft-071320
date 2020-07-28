require_relative '../config/environment'
require 'pry'
# puts "hello world"

def greet 
    puts "Hey, what's the scoop?"
    # gets.strip
end
greet

def user_input_for_name
    puts "what is your name?"
    user_input = gets.strip
    user_input
end


def create_new_user(user_input)
    User.all.select do |user|
        # binding.pry
        if user.name == user_input
        else 
            User.create(name: user_input)
        end
    end
end
# user_input = create_new_user(user_input)
create_new_user("Noa")

def user_input_for_flavor
    puts "hey #{user_input_for_name}, what is your flavor for today?"
    gets.strip
end
flavor = user_input_for_flavor

# def user_input__for_topping
#     puts "which topping to add?"
#     gets.strip
# end

# topping = user_input__for_topping

# => CREATE

#ask user's name

#ask user to choose a flavor
    #if flavor exists print flavor 
    #else create a new flavor

#ask user to choose toppings
    #if flavor exists print flavor 
    #else create a new flavor

#ask user to rate the icecream

#ask user if want to add to favorites list

#after all the methods above run
    #create a review
    #puts a message of the review and a thank you note.


# => READ

#user can see all the other user's review

#user can see the ice cream with the highest ratings


# => UPDATE

#user can add ice cream to the their list of favorites


# => DELETE

#user can delete the review



