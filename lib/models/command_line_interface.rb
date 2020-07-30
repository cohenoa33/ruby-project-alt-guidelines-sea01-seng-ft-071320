class CommandLineInterface 

    def greet 
        puts "Hey, what's the scoop? Tell us your name!"
        gets.strip
    end

    def create_new_user(user_input)
        User.find_or_create_by(name: user_input)
    end
 
    def menu(name)
        puts "Hey #{name.name},
        tell as what you want?"
        puts "Order - to make a new order"  
        puts "Top 5 - for see our top 5"
        puts "Update - to update your review"
        puts "Delete -  to delete your review"
    end

    def get_user_input
        gets.strip
    end
    
    def add_name_to_icecream 
        IceCream.all.each do |icecream|
            if icecream.name == nil
                icecream.update({name: Faker::Hipster.word})
            end
        end
    end

    def order
        puts "what's your flavor for today?"
        flavor = get_user_input
        puts "which topping to add?"
        topping = get_user_input
        IceCream.find_or_create_by(flavors: flavor, toppings: topping)
        add_name_to_icecream
    end
    
    def add_favorite
        puts "Do you want to add this to your favorite?"
        puts "type 'Yes' or 'No'"
        input = get_user_input
        if input == "Yes"  
            input = true
        elsif input == "No" 
            input = false
        else
            invalid_command
            add_favorite
        end
        input
    end

    def get_review(name)
        puts "Please rate your ice cream (a number between 1-10)"
        rating = get_user_input
        if (1..10).member?(rating.to_i)
        favorite = add_favorite
        Review.create(user_id: name.id, icecream_id: IceCream.last.id, rating: rating.to_i, favorite: favorite)
        puts "Thanks #{name.name}, see you soon!"
        else 
            invalid_command
            get_review(name)
        end
    end
        
    def icecream_list_with_average_rating # return top5
        ice_cream_rating = Review.group(:icecream_id).average(:rating)
        list = ice_cream_rating.map do |k, v|
            "#{v.to_i} => #{IceCream.find(k).name}"
        end
        array_of_flav = list.sort.reverse
        puts "Here are our Top 5:"
        puts array_of_flav.slice(0, 5)
        puts "Do you want to order?"
    end

    def find_old_review(name)
        name_review = Review.where(user_id: name.id)
        if name_review.size > 0
            find_the_one(name)
        else
            puts "look like it's your first time here, would you like to order?"
        end
    end

    def changed_my_mind(name, review)
        puts "New rating?"
        new_rating = get_user_input
        if (1..10).member?(new_rating.to_i)
        review.update({rating:new_rating})
        puts "We got ya #{name.name}, see you soon!"
        else 
        invalid_command
        changed_my_mind(name, review)
        end
    end


    def find_the_one(name)
        name_review = Review.where(user_id: name.id)
        ice_cream_name = name_review.collect {|review| review.ice_cream.name}.uniq
        puts "Please type the ice cream name that you want to edit."
        puts ice_cream_name
        input = get_user_input
        if ice_cream_name.include?(input)
        icecream = IceCream.all.find_by(name: input)
        review = Review.where(user_id: name.id, icecream_id: icecream.id)
        changed_my_mind(name, review)
        else 
        invalid_command
        find_the_one(name)
        end
        review
    end


    def find_review(name)
        users_review = Review.where(user_id: name.id)
        ice_cream_name = users_review.collect {|review| review.ice_cream.name}.uniq
        puts "Please type the ice cream name for the review."
        puts ice_cream_name
        input = get_user_input
        ice_cream_name.include?(input)
        icecream = IceCream.all.find_by(name: input)
        review = Review.where(user_id: name.id, icecream_id: icecream.id)
        review

    end

    
    def delete_review(review)
        review.destroy_all
        puts "We deleted your review, see you soon!"
    end
    
    def menu_select(name)
        user_input = get_user_input
        
        if user_input == 'Order'
        order
        add_name_to_icecream
        get_review(name)

        elsif user_input == 'Top 5'
        icecream_list_with_average_rating

        elsif user_input == 'Update'
        find_old_review(name)
     

        elsif user_input == 'Delete'
            review = find_review(name)
            delete_review(review)
        else
        invalid_command
        menu(name)
        menu_select(name)
        end
        
    end

    def invalid_command
        puts 'Please enter a valid command'
    end
end