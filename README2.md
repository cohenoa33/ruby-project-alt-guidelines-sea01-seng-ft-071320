step 1:
  V  - greets the user
  V  - ask user's name

step 2
  V  - if user doesn't exist create new user
   V     - ask for ice cream, topping?
        - (ask if wants to know top favorites?)
   V     - get user input 

step 3
  V  - ask new user if they would like to rate the ice cream  
  V      - promp message - type "yes" or "no"
   V     - prompt message - rate between 1-10
  V      - get another input
  V  - ask if they want to add it to favorite
 V       - get another input 
  V  - create a new review 
  V  - puts a thank you message

    - all the flaveros: puts all the flavors to the screen 
V   - order new one and rate it
    -  update review: 
    - delete review
    - exit: puts: bye bye

    compute_average
    - look at all elements in Review
    - group all the ratings according to the ice cream id
    - calculate the rating for every ice cream
    - get ice cream names (similar to the all_reviews_greater_than_number)

    delete review
  V  - puts all the icrcream names that the user rate
  V  - find the review that the user want to delete
  V  - delete review


 - check if user already exist
        - if true ask if user wants to update the review or wants a new ice cream

   
        - get user input 
    - write some code

step 3
    - if user wants to create new ice cream
    

#def say_hello(name)
  #"Hi #{name}!"
#end
 
#puts "Enter your name:"
#users_name = gets.strip
 
#puts say_hello(users_name)

def help 
  puts "I accept the following commands:"
  puts " - help : displays this help message"
  puts " - list : displays a list of songs you can play"
  puts " - play : lets you choose a song to play"
  puts " - exit : exits this program"
end

def list(songs)
  i = 0
  while i< songs.length do 
    songs.each_with_index  
    puts " #{i+1}. #{songs[i]}"
    i += 1
  end
end

def play(songs)
  puts "Please enter a song name or number:"
  user_response = gets.strip.to_s

    songs.include? (user_response)
    if true
     puts "Playing #{song}"
    else
    puts "Invalid input, please try again"
   end

  
end

def hit? (card_total)
  # code hit? here
   prompt_user
   user_input = get_user_input
   
  if user_input=='s'
    
  
  elsif user_input == 'h'
    card_total += deal_card
    card_total
  else
    invalid_command
    hit?(card_total)
  
  end
  user_input
  card_total
end

def invalid_command
  # code invalid_command here
  puts 'Please enter a valid command'
end
