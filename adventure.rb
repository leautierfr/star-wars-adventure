# Star Wars Adventure

system "clear"

##########################################################################

def create_room
  "You are in a cave structure. You see an opening."
end

def loot
  ["a Sith Holocron", "a Jedi lightsaber", "a Stimpack", "a Blaster"].sample
end

#########################################################################

### RNG

def roll_dice(number_of_dice, size_of_dice)
  total = 0
  1.upto(number_of_dice) do
    total = total + rand(size_of_dice) + 1
  end
  return total
end

###########################################################################

### Game Methods

def has_escaped?
  if roll_dice(2, 6) >= 12
    true
  else
    false
  end
end

def gundark
  if roll_dice(2, 6) >= 5 && roll_dice(2, 6) <= 6
    true
  else
    false
  end
end

def dark_jedi
  if roll_dice(2, 6) >= 10 && roll_dice(2, 6) <= 11
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
  if roll_dice(2, 6) >= 2
    true
  else
    false
  end
end

##################################################################

# Variables

number_of_rooms_explored = 1
loot1 = ""
health_points = 10
escaped = false
enemy = false
current_room = "create_room"
inventory = []
dark_side = 0

#################################################################

# Introduction

puts "You are Anakin Skywalker. You are on a mission with your master, Obi-Wan Kenobi, on a mysterious planet occupied by the CIS. You were ambushed by the droids and you got seperated from Obi-Wan. You now find yourself in a cave system with nothing but your wits. Try and find your way out of the cave, using the items you loot to aid your escape."
puts "Watch out for foes that you may encounter!"
puts "To play, type one of the given commands."

########################################################################

# Game Loop
while health_points > 0 and not escaped
  # Game Code

  actions = ["m - move", "s- search room", "i - check inventory"]

  if inventory.include? "a Stimpack"
    actions << "h - heal"
  end

  if gundark
    puts "You have encountered a Gundark! You will need a blaster to defeat it."
    actions << "r - run"
    if inventory.include? "a Blaster"
      actions << "f - fight"
    end

    if inventory.include? "a Sith Holocron"
      actions << "d - use the dark side"
    end
  elsif dark_jedi
    puts "You have encountered a Dark Jedi! You will need a lightsaber to defeat them."
    actions << "r - run"
    if inventory.include? "a Jedi lightsaber"
      actions << "f - fight"
    end

    if inventory.include? "a Sith Holocron"
      actions << "d - use the dark side"
    end
  end

  puts "Room # #{number_of_rooms_explored}"

  print "What will you do? (#{actions.join(",")}) : "

  # Enemy Attack
  player_action = gets.chomp
  if gundark && enemy_attack? || dark_jedi && enemy_attack?
    health_points = health_points - 1
    puts "You have taken damage!"
  end
  # Player Commands
  if player_action == "i"
    puts inventory
  elsif player_action == "h"
    puts "You used a Stimpack to recover one health point"
    health_points = health_points + 1
    inventory.delete("a Stimpack")
  elsif player_action == "m"
    current_room = create_room
    number_of_rooms_explored = number_of_rooms_explored + 1
    gundark || dark_jedi
    escaped = has_escaped?
  elsif player_action == "r"
    puts "You run to another room in the cave structure."
    current_room = create_room
    number_of_rooms_explored = number_of_rooms_explored + 1
  elsif player_action == "s"
    if has_loot?
      loot1 = loot
      inventory << loot1
      puts "You found #{loot1}!"
    elsif gundark
      puts "A Gundark emerges from the darkness! You will need a blaster to defeat it."
    elsif dark_jedi
      puts "You are ambushed by a Dark Jedi! You will need a lightsaber to defeat them."
    else
      puts "You didn't find anything."
    end
  elsif player_action == "f"
    if defeat_enemy?
      gundark = false || dark_jedi = false
      puts "You defeated your foe!"
    else
      puts "You failed to defeat your foe."
    end
  elsif player_action == "d"
    gundark = false || dark_jedi = false
    dark_side = dark_side + 1
    puts "You used the dark side to defeat your foe. You have taken one dark side point."
  else
    puts "Please input one of the game commands."
  end
end

if health_points > 0
  puts "You escaped! Anakin lives to fight another day!"
  puts "You explored #{number_of_rooms_explored} rooms."
elsif dark_side > 6
  puts "You have fallen to the dark side. All hope is lost!"
else
  puts "You did not make it out of the cave."
  puts "You explored #{number_of_rooms_explored} areas before your demise."
end
