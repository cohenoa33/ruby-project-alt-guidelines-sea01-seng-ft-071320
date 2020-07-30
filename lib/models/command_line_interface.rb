
class CommandLineInterface 

    def greet 
        puts "Hey, what's the scoop? Tell us your name!"
        gets.strip
    end

    def create_new_user(user_input)
        User.find_or_create_by(name: user_input)
    end
 
    def menu(name)
        puts "Hey #{name.name},"
        puts "tell us what you want?"
        puts "Order - to make a new order"  
        puts "Top 5 - to see our top 5 flavors"
        puts "Update - to update your review"
        puts "Delete -  to delete your review"
    end

    def get_user_input
        gets.strip.downcase
    end
    
    def add_name_to_icecream 
        IceCream.all.each do |icecream|
            if icecream.name == nil
                icecream.update({name: Faker::Hipster.word})
            end
        end
    end

    def order
        puts "\nWhat's your flavor for today?"
        flavor = get_user_input
        puts "Which topping do you want to add?"
        topping = get_user_input
        IceCream.find_or_create_by(flavors: flavor, toppings: topping)
        add_name_to_icecream
    end
    
    def add_favorite
        puts "Do you want to add this to your favorite?"
        puts "Type 'Yes' or 'No'"
        input = get_user_input
        if input == "yes"
            input = true
        elsif input == "no" 
            input = false
        else
            invalid_command
            add_favorite
        end
        input
    end

    def get_review(name)
        puts "Please rate your ice cream (a number between 1-10)."
        rating = get_user_input
        if rating.to_i >= 1 && rating.to_i <= 10
            favorite = add_favorite
            Review.create(user_id: name.id, icecream_id: IceCream.last.id, rating: rating.to_i, favorite: favorite)
            puts "Thanks #{name.name}, see you soon!"
        else 
            invalid_command
            get_review(name)
        end
    end
    

    def icecream_list_with_average_rating(name)
        ice_cream_rating = Review.group(:icecream_id).average(:rating)
        sorted_list = ice_cream_rating.map {|key, value| {id: key, rating: value.to_i}}.sort_by{|hash| hash[:rating]}.reverse
        list = sorted_list.slice(0, 5).map do |hash|
            "#{hash[:rating]} => #{IceCream.find(hash[:id]).flavors.downcase}"
        end
        puts "These are our Top 5 flavors:"
        puts list.join("\n")
        
        puts "\nWe can create any flavor that you want!"
        new_order(name)
    end

    def find_old_review(name)
        name_review = Review.where(user_id: name.id)
        if name_review.size > 0
            review = find_review(name, "update")
            changed_my_mind(name, review)
        else
            puts "Looks like it's your first time here. Would you like to order?"
            new_order(name)
        end
    end

    def changed_my_mind(name, review)
        puts "What's your new rating?"
        new_rating = get_user_input
        if new_rating.to_i >= 1 && new_rating.to_i <= 10
            review.update({rating:new_rating})
            puts "We got ya #{name.name}, see you soon!"
        else 
            invalid_command
            changed_my_mind(name, review)
        end
    end

    def new_order(name)
        order
        add_name_to_icecream
        get_review(name)
    end

    def find_review(name, action)
        name_review = Review.where(user_id: name.id)
        ice_cream_names = name_review.collect {|review| review.ice_cream.name}.uniq
        puts "Please type the ice cream name that you want to #{action}."
        puts ice_cream_names
        input = get_user_input
        if ice_cream_names.include?(input)
            icecream = IceCream.all.find_by(name: input)
            review = Review.where(user_id: name.id, icecream_id: icecream.id)
        else 
            invalid_command
            review = find_review(name, action)
        end
        review
    end

    def delete_review(review)
        review.destroy_all
        puts "We deleted your review, see you soon!"
    end
    
    def menu_select(name)
        user_input = get_user_input
        
        if user_input == 'order'
            new_order(name)

        elsif user_input == 'top 5'
            icecream_list_with_average_rating(name)

        elsif user_input == 'update'
            find_old_review(name)

        elsif user_input == 'delete'
            review = find_review(name, "delete")
            delete_review(review)
        else
            invalid_command
            menu(name)
            menu_select(name)
        end
    end

    def invalid_command
        puts 'Please enter a valid command.'
    end
end