# Ruby Adventure Game

system "clear"

##########################################################################

def create_room
  "You are in a cave structure. You see an opening."
end

def loot
  ["a Sith Holocron", "a Jedi lightsaber", "a Stimpack", "Dark side texts", "a Blaster"].sample
end

#########################################################################

### RNG Generator

def roll_dice(number_of_dice, size_of_dice)
  total = 0
  1.upto(number_of_dice) do
    total = total + rand(size_of_dice) + 1
  end
  return total
end

###########################################################################

### Game Methods

def has_enemy?
  if roll_dice(2, 6) >= 1
    true
  else
    false
  end
end

def has_escaped?
  if roll_dice(2, 6) >= 11
    true
  else
    false
  end
end

# def enemy?
#   if roll_dice(2, 6) >= 2
#     true
#   else
#     false
#   end
# end

def gundark
  if roll_dice(2, 6) <= 1 && roll_dice(2, 6) >= 6
    true
  else
    false
  end
end

def dark_jedi
  if roll_dice(2, 6) <= 7 && roll_dice(2, 6) >= 12
    true
  else
    false
  end
end

def enemy_attack?
  if roll_dice(2, 6) >= 9
    true
  else
    false
  end
end

def defeat_enemy?
  if roll_dice(2, 6) >= 4
    true
  else
    false
  end
end

def has_loot?
  if roll_dice(2, 6) >= 8
    true
  else
    false
  end
end

##################################################################

# Variables

number_of_rooms_explored = 1
loot_count = 0
health_points = 20
force_points = 10
escaped = false
enemy = false
current_room = "create_room"

#################################################################

# Introduction

puts "You are Anakin Skywalker. You are on a mission with your master, Obi-Wan Kenobi, on a mysterious planet occupied by the CIS. You were ambushed by the droids and you got seperated from Obi-Wan. You now find yourself in a cave system with nothing but your wits. Try and find your way out of the cave, using the items you loot to aid your escape."
puts "Watch out for foes that you may encounter!"
puts "To play, type one of the given commands."

########################################################################

# Game Loop
while health_points > 0 and not escaped
  # Game Code

  actions = ["m - move", "s- search"]

  puts "Room # #{number_of_rooms_explored}"
  # Enemy Encounter
  if has_enemy?
    gundark || dark_jedi
  end
  if gundark
    puts "You have encountered a Gundark! You will need a blaster to defeat it."
    actions << "f - fight"
    actions << "r - run"
  elsif dark_jedi
    puts "Your foe is a Dark Jedi! You will need a lightsaber to defeat them."
    actions << "f - fight"
    actions << "r - run"
  end

  print "What will you do? (#{actions.join(",")}) : "

  # Enemy Attack
  player_action = gets.chomp
  if gundark || dark_jedi && enemy_attack?
    health_points = health_points - 1
    puts "You have taken damage!"
  end
  # Player Commands
  if player_action == "m"
    current_room = create_room
    number_of_rooms_explored = number_of_rooms_explored + 1
    gundark = has_enemy?
    dark_jedi = has_enemy?
    escaped = has_escaped?
  elsif player_action == "s"
    if has_loot?
      puts "You found #{loot}!"
      loot_count = loot_count + 1
    elsif has_enemy?
      gundark || dark_jedi
    else
      puts "You didn't find anything."
    end

    #Rigged Condition - searching triggers enemies
    if not enemy
      enemy = has_enemy?
    end
  elsif player_action == "f"
    if defeat_enemy?
      enemy = false
      puts "You defeated your foe!"
    else
      puts "You failed to defeat your foe."
    end
  else
    puts "Please input one of the game commands."
  end
end

if health_points > 0
  puts "You escaped! The Hero With No Fear lives to fight another day!"
  puts "You explored #{number_of_rooms_explored} rooms"
  puts "you found #{loot_count} items of loot."
else
  puts "You did not make it out of the cave."
  puts "You explored #{number_of_rooms_explored} areas before your demise."
end
