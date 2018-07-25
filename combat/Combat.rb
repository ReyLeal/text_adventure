require('./helper/Randomize.rb')
require('./helper/TextHelper.rb')
require('./helper/Color.rb')
require('./userInput/getUserInput.rb')
require('./loot/Loot.rb')

module CombatModule

  class Combat
    @@attackChances = {
      miss: [ 1, 5 ],
      dodge: [ 6, 15 ],
      hit: [ 15, 94 ],
      crit: [ 95, 100 ],
    }

    @@battleChoices = {
        A: "Attack",
        B: "Defend"
    }

    @@userOption = nil;

    def initialize(player, mobHealth)
      @player = player;
      @weapon = player.equiptment[:weapon];
      @armor = player.equiptment[:armor];
      @playerHealth = player.health;
      @playerClass = player.chosenClass;
      @mobHealth = mobHealth;
    end

    def battle
      begin
        @@userOption = InputModule::getUserOptionsChoice(@@battleChoices);

        TextHelper::spaceText

        if(@@userOption === "A")
          ColorModule.blue("You attack the monster and deal #{attack} damage!");

          if @mobHealth > 0
             ColorModule.red("The monster attacks you and deals #{mobAttack} damage!");
          end;

        elsif(@@userOption === "B")

          if @mobHealth > 0
            ColorModule.red("You attempt to block the monsters attack.");
            ColorModule.red("The monster deals #{defend} damage!");
          end;

        end

        TextHelper::spaceTextBlank

        puts "Player Health: #{@playerHealth}"
        puts "Monster Health: #{@mobHealth}"

      end until @playerHealth <= 0 || @mobHealth <= 0;

      endBattle

    end

    def endBattle
      TextHelper::spaceTextBlank

      if( @mobHealth <= 0 )
        loot = LootModule::MonsterLoot.new(@player)
        @player = loot.randomLoot
        ColorModule.blue("The Beast has been slain!!!")
       else
        ColorModule.red("You have died...")
      end

      TextHelper::spaceText

      @player.health = @playerHealth;
      @player;
    end

    def attack
      attackChance = RandomizeModule::randomizeStats( 1, 100 );
      damage = calculateDamage(@weapon[:attack], roll(attackChance))
      @mobHealth = @mobHealth - damage;
      return damage > @weapon[:attack][1] ? "#{damage}(critical)" : damage;
    end

    def defend
      attackChance = RandomizeModule::randomizeStats( 1, 100 );
      damage = calculateDamage( [ 1, 5 ] , roll( attackChance ) );
      damage =  damage + @armor[:defence];
      damage = damage > 0 ? damage : 0;
      @playerHealth = @playerHealth - damage;
      return damage > 5 ? "#{damage}(critical)" : damage;
    end

    def mobAttack
      attackChance = RandomizeModule::randomizeStats( 1, 100 );
      damage = calculateDamage( [ 1, 5 ] , roll( attackChance ) );
      @playerHealth = @playerHealth - damage;
      return damage > 5 ? "#{damage}(critical)" : damage;
    end

    def calculateDamage(weapon, roll)
      hit = RandomizeModule::randomizeStats( weapon[0], weapon[1] );

      if roll === :hit then return hit end;
      if roll === :dodge || roll === :miss then return 0 end;
      if roll === :crit then return hit * 1.25 end;
    end

    def roll(attackChance)
      @@attackChances.map { | name, range |
        if attackChance.between?( range[0], range[1] )
          return name
        end
      }
    end
  end

end
