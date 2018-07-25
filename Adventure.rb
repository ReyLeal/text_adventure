require('./player/Character.rb');
require('./scenario/Welcome.rb');
require('./combat/Combat.rb');
require('./scenario/Encounter.rb');

# Start
player = PlayerModule::Player.new;

# Welcome player // Player sets name
welcome = WelcomeModule::Welcome.new;
player.name = welcome.greet;

# Asks player what class they are
playerClass = welcome.choseClass(player.name);

# Sets Players Class
player.selectClass(playerClass);
player.numberOfEncounters = 0;

begin
  encounter = EncounterModule::Encounter.new(player);
  player = encounter.startEncounter
  player.numberOfEncounters = player.numberOfEncounters + 1
end until (player.health <= 0 || player.numberOfEncounters === 11)


# Next steps:

# Create spells
# Create town / shops
# Players should be able to type custom commands to see a list of commands
# Like character stats, gold, armor, weaponse
