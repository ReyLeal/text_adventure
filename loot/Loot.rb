module LootModule
  require('./helper/Randomize.rb')
  require('./helper/textHelper.rb')
  require('./helper/Color.rb')
  require('./loot/Armor.rb')
  require('./loot/Weapons.rb')

  LOOTTYPESMONSTER = {
    armor: [1 , 5],
    weapon: [6 , 10],
    currency: [11 , 100]
  }

  LOOTTYPESCHEST = {
    armor: [1 , 50],
    weapon: [51 , 100]
  }

  class MonsterLoot

    def initialize(player)
      @player = player
      @playerWeapon = player.equiptment[:weapon]
      @playerArmor = player.equiptment[:armor]
      @playerClass = player.chosenClass
    end

    def randomLoot
      lootRoll = RandomizeModule::randomizeStats(0,100);
      lootRoll = roll(lootRoll);

      lootClass = Loot.new(lootRoll, @player);

      return lootClass.loot;
    end

    def roll(roll)
      LOOTTYPESMONSTER.map { | name, range |
        if roll.between?( range[0], range[1] )
          return name
        end
      }
    end

  end

  class ChestLoot
    def initialize(player)
      @player = player
      @playerWeapon = player.equiptment[:weapon]
      @playerArmor = player.equiptment[:armor]
      @playerClass = player.chosenClass
    end

    def randomLoot
      lootRoll = RandomizeModule::randomizeStats(0,100);
      lootRoll = roll(lootRoll);

      lootClass = Loot.new(lootRoll, @player);

      return lootClass.loot;
    end

    def roll(roll)
      LOOTTYPESCHEST.map { | name, range |
        if roll.between?( range[0], range[1] )
          return name
        end
      }
    end
  end

  class StartingLoot
    @@standardClassEquiptment = {
      'Warrior' => ['training sword', 'copper chainmail'],
      'Mage' => ['training staff', 'worn rags'],
      'Archer' => ['simple bow', 'leather garbs']
    }
    def initialize
    end

    def getStartingWeapon(className)
      minAttack = RandomizeModule::randomizeStats(1,2);
      maxAttack = RandomizeModule::randomizeStats(3,5);
      attackStats = [ minAttack, maxAttack ];

      {
        name: @@standardClassEquiptment[className][0],
        attack: attackStats
      }
    end

    def getStartingArmor(className)
      {
        name: @@standardClassEquiptment[className][1],
        defence: RandomizeModule::randomizeStats(-2,-1)
       }
    end
  end

  class Loot
    attr_accessor :loot

    def initialize(lootRoll, player)
      @player = player;
      @playerWeapon = player.equiptment[:weapon]
      @playerArmor = player.equiptment[:armor]
      @playerClass = player.chosenClass

      TextHelper::spaceText

      self.loot = lootRoll === :armor ? self.getArmor : self.loot;
      self.loot = lootRoll === :weapon ? self.getWeapon : self.loot;
      self.loot = lootRoll === :currency ? self.getCurrency : self.loot;

      TextHelper::spaceText
    end

    def getArmor
      @player.equiptment[:armor] = ArmorModule::getArmor(@playerClass, @playerArmor);
      ColorModule.green("You have obtained #{@player.equiptment[:armor][:name]}(#{@player.equiptment[:armor][:defence]})");

      @player
    end

    def getWeapon
      @player.equiptment[:weapon] = WeaponModule::getWeapon(@playerClass, @playerWeapon);
      ColorModule.green("You have obtained #{@player.equiptment[:weapon][:name]}(#{@player.equiptment[:weapon][:attack][0]} - #{@player.equiptment[:weapon][:attack][1]})");

      @player
    end

    def getCurrency
      currency = RandomizeModule::randomizeStats(1, 15);
      @player.currency = @player.currency + currency;

      ColorModule.green("You have obtained #{currency} gold coins. New Balance : #{@player.currency} coins");

      @player
    end
  end

end
