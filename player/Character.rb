module PlayerModule
  require('./helper/Randomize.rb')
  require('./helper/Color.rb')
  require('./helper/textHelper.rb')
  require('./loot/Loot.rb')

    class Player
      attr_accessor :name
      attr_accessor :chosenClass
      attr_accessor :equiptment
      attr_accessor :health
      attr_accessor :stamina
      attr_accessor :currency
      attr_accessor :numberOfEncounters

      def initialize
        self.health = 100
        self.stamina = 5
        self.currency = 100
      end

      def setClass(className)
        self["select#{className}"]
      end

      def selectClass(className)
        self.chosenClass = className
        loot = LootModule::StartingLoot.new

        self.equiptment = {
          weapon: loot.getStartingWeapon(className),
          armor: loot.getStartingArmor(className)
        }

        weapon = self.equiptment[:weapon]
        armor = self.equiptment[:armor]

        TextHelper::spaceText

        ColorModule.green( "You pick up a +(#{weapon[:attack][0]} - #{weapon[:attack][1]}) damage #{weapon[:name]}.")
        ColorModule.green( "You also pick up +#{armor[:defence][1]} defence #{armor[:name]} armor.")

        TextHelper::spaceText

      end

      def changeGear(type, name, statType, stats)
        self.equiptment[type][:name] = name;
        self.equiptment[type][statType] = stats;
      end
  end

end
