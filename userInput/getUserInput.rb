module InputModule

  def self.userChoice
     print "User Coice: ";
   end

  def InputModule.getUserOptionsChoice(options)
    TextHelper::spaceText

    puts "What would you like to do?"

    TextHelper::spaceTextBlank

    options.each do
      |letter, option|
      puts "#{letter} : #{option}"
    end

    TextHelper::spaceTextBlank

    userChoice
    return gets.chomp.upcase;
  end

  def InputModule.getUserName
    TextHelper::spaceText

    puts "Hello Hero!"
    puts "Welcome, to the land of waves. We've been awaiting your arrival."
    TextHelper::spaceTextBlank
    puts "What is your name, Hero?"

    TextHelper::spaceTextBlank

    userChoice
    return gets.chomp;
  end

  def InputModule.getUserClass(name, classes)
    TextHelper::spaceText
    puts "Greetings #{name}!"
    TextHelper::spaceTextBlank
    puts "What class are you?"

    TextHelper::spaceTextBlank

    classes.each do
      |option, className|
      puts "#{option} : #{className}"
    end

    TextHelper::spaceTextBlank

    userChoice
    return gets.chomp.upcase;
  end
end
