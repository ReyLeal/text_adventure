module MobsModule

  class Mob

    attr_accessor :name
    attr_accessor :health

    def initialize(player)
      @player = player;
      mob = selectRandomMob
      @name = mob.keys[0]
      @health = mob[@name];
    end

    def mobs
      [
        {wraith: 20},
        {ghost: 10},
        {ghoul: 25},
      ]
    end

    def boss
      [
        {khathril: 40}
      ]
    end

    def selectRandomMob
      if(@player.numberOfEncounters === 10)
        return boss
      else
        random = Random.new;
        return mobs[random.rand(mobs.count) -1]
      end
    end

  end

end
