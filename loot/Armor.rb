module ArmorModule
  ARMORS = {
    warrior: [
      "Plate Gauntlets",
      "Mthril Shoulder Pads"
    ],
    archer: [
      'Studded Leather Hood',
      'Reinforced Leather Cowl'
    ],
    mage: [
      'Sterling Silk Robes',
      'Enriched robe of the Emmesaries'
    ]
  }

  def self.getArmor(className, armor)
    count = ARMORS[className.downcase.to_sym].count
    {
      name: ARMORS[className.downcase.to_sym][RandomizeModule::randomizeStats(0, count - 1)],
      defence: calculateArmorDefence(armor[:defence])
    }
  end

  def self.calculateArmorDefence(armor)
    improvement = RandomizeModule::randomizeStats(1, 10);

    pctDmg = armor.to_f / improvement.to_f

    (armor + pctDmg)
  end
end
