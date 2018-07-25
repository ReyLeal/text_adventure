require('./helper/Randomize.rb')
require('./mobs/Mobs.rb')
require('./loot/Loot.rb')

module EncounterModule

  class Encounter

    def initialize(player)
      @player = player;
      @location = selectRandomlocation
      @loot = monsterOrLoot;
    end

    def startEncounter
      if @loot === true
        puts "Next you walk into #{@location} and see a treasure chest!"
        loot = LootModule::ChestLoot.new(@player)
        @player = loot.randomLoot
      else
        mob = MobsModule::Mob.new(@player)
        puts "You walk into #{@location} and notice a #{mob.name}"
        combat = CombatModule::Combat.new(@player, mob.health);
        @player = combat.battle;
      end
      return @player;
    end



    def monsterOrLoot
      randomNumber = RandomizeModule::randomizeStats(0,100);
      randomNumber > 95
    end

    def locations
      [
        "an old cellar",
        "a room with a window",
        "a long choridor",

      ]
    end

    def selectRandomlocation
      random = Random.new;
      return locations[random.rand(locations.count) -1]
    end
  end

end
