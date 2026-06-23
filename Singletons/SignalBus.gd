extends Node

# Win/loss signals
signal player_died
signal player_win

# Battle signals
signal battle_start

# Upgrade signals
signal upgrade_selected(upgradeName: String)

signal load_upgrade(source) #ex: load_upgrade(self)

# Scene switching signal
signal scene_switch(scenePath: String)

#impact collision
signal hit(source, target) #source should always be passed like hit(self, body)

signal hitstop

signal damage #keeping this seperate so that I'm not passing a bunch of unnecessary things into hit

signal mine_explosion(mine, target_list)

signal enemy_died
