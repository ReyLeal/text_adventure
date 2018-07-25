require('./userInput/getUserInput.rb')

module WelcomeModule

  class Welcome
    @@classes =
    { "A" => "Warrior",
      "B" => "Mage",
      "C" => "Archer"
    };

    def greet
      return InputModule::getUserName
    end

    def choseClass (name)
      input = InputModule::getUserClass(name, @@classes)
      return @@classes[input];
    end

  end
end
