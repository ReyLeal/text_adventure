module WeaponModule
  WEAPONS = {
    warrior: [
      "'Boar Hunter' - Axe",
      "'The Beast Slayer'- Claymore"
    ],
    archer: [
      "'Holy Point Shot'",
      "'Mthril Impaler' - Crossbow"
    ],
    mage: [
      "'Sages Silver Staff' - Staff",
      "'Pegasus' Horn' - Wand"
    ]
  }

  def self.getWeapon(className, weapon)
    count = WEAPONS[className.downcase.to_sym].count
    {
      name: WEAPONS[className.downcase.to_sym][RandomizeModule::randomizeStats(0, count - 1)],
      attack: calculateWeaponDamage(weapon[:attack])
    }
  end

  def self.calculateWeaponDamage(weapon)
    improvement = RandomizeModule::randomizeStats(1, 10);

    pctDmg = weapon[1].to_f / improvement.to_f
    maxDmg = (pctDmg + weapon[1]).ceil;
    minDmg = maxDmg - RandomizeModule::randomizeStats(1, 3);

    return [minDmg, maxDmg];
  end
end
