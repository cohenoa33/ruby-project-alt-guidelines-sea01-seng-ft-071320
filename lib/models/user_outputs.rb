
class UserOutputs
    def welcome 
        a = Artii::Base.new 
        a.asciify("Welcome")
        puts a.asciify('Welcome to Scoopy')
    end

    def self.greeting
        puts "Hey, what's the scoop? Tell us your name!".light_magenta
    end

    def self.menu_list(name)
        puts "\nHey #{name.name},".light_magenta
        puts "tell us what you want?".light_magenta
        puts "\nOrder - to make a new order".light_yellow
        puts "Top 5 - to see our top 5 flavors".light_cyan
        puts "Update - to update your review".light_green
        puts "Delete -  to delete your review".light_red
    end

    def self.flavor
        puts "\nWhat's your flavor for today?".light_magenta
    end

    def self.topping
        puts "Which topping do you want to add?".light_magenta
    end

    def self.favorite?
        puts "Do you want to add this to your favorite?".light_magenta
        puts "Type 'Yes' or 'No'".light_magenta
    end

    def self.updated
        puts "We see you like this one! Please update your rating (a number between 1-10).".light_magenta
    end

    def self.thanks(name)
        puts "Thanks #{name.name}, see you soon!".light_magenta
    end

    def self.rating(name)
        puts "Please rate your ice cream (a number between 1-10).".light_magenta
    end

    def self.top_5
        puts "These are our Top 5 flavors:".light_magenta
    end

    def self.any_flavor
        puts "\nWe can create any flavor that you want!".light_magenta
    end

    def self.first_time
        puts "Looks like it's your first time here. Would you like to order?".light_magenta
    end

    def self.new_rating
        puts "What's your new rating?".light_magenta
    end

    def self.soon(name)
        puts "We got ya #{name.name}, see you soon!".light_magenta
    end

    def self.option(action)
        puts "Please type the ice cream name that you want to #{action}.".light_magenta
    end

    def self.delete_all
        puts "We deleted your review, see you soon!".light_magenta
    end

    def self.invalid
        puts 'Please enter a valid command.'.red
    end

    def self.menu?
        puts "Do you want to check the menu first? Please type yes/no".light_magenta
    end

     def self.menu
        puts "\nMenu \u{1F366}".blue.underline 
    end
end

