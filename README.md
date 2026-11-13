Project Codename: portuno  
Project Owner: Xaverio  
Date of Creation: 07/11/2026  
Game Engine/Version: Godot 4.7.stable  
Project Title: -

# About/Description
Platformer game where a character jumps their way to finish avoiding 
obstacles and spikes.

## WARNING!
- Do not put spike tile with spike type "2" (Falling Spike) on the ground 
as they are meant to be placed on walls and ceiling.

## To Do
- Add Retractable Spike
- Create a test level for gameplay flow.

### Main Character
Simple mechanic and attributes. They have one life, just move and jump and
a simple goal: reach the finish line in a level without dying.

### Level Structure
Level geometry is made with tiles using TileMapLayer. This is for
static geometry of the level. Other objects such as moving platforms are 
placed manually into the level.

### Spike Tiles and Entities
The numbers represent type ID:  
1. Static Spike
2. Falling Spike: Must be placed on walls and ceiling

The numbers represent spike entities ID:  
1. Falling Spike

### Map Features
- No slopes
- One way collision tiles
- Moving platforms/parts
- Jump Pad
- Water
- Lever/Activator

One way collision tile is just basic one way tile. Player can press
down key to descent. The key can cancel coyote time and falls instantly
when off the surface edge.  

The moving platform uses TileMapLayer with "Use Kinematic Bodies" turned on. All spikes
can technically attached to it with some being placed manually using Grid Snap.  

Jump Pad is basic scene (separate from tileset) with green part at the top that act as trampoline boosts jump
for player and Legged Spikes on contact. It is a standalone basic scene for simple operation on the entities and 
do not require tile map complex operation in the said entities code.

Water is a tile that allows swimming (switches movement mode) for player. 
Kills any spike. 

Lever/Activator is a simple scene that triggers an action on a map.

### Spikes
Responsible for level hazard and killing the player. The killing code is
performed in the spike, so the player should only focus on moving and jumping.
Spike enemy ideas:
1. Static Spike
2. Falling Spike
3. Retractable Spike
4. Spike Shooter
5. Homing Spike
6. "Spike" Mine
7. Legged Spike
8. Ghost Spike
9. Sir Spiker (Boss)

Static Spike: Normal spike. Part of the tiles. Lives in Spikes TileMapLayer.  

Falling Spike: A spike that falls to the ground. Triggered when player's upward
raycast hits them. Placed on walls or ceiling to work. Not functioning once it hits a ground.  

Retractable Spike: Periodically retracts and protracts from surface. The timer
is for retracting and protracting are editable and compatible with moving platform. 
Collision is always active and when protracting, it checks whether player is inside it hitbox
during retracted stage and has not left yet. Kills if do when its protracting.  

Spike Shooter: A static cannon that shoots spikes. The projectile speed is fixed but the
rate of fire is editable.  

Homing Spike: A proximity triggered spike. Fixed rotation speed and acceleration. 
Will home towards player and destroys itself upon contact on any objects that are not
spikes.  

"Spike" Mine: A landmine shaped like spike. Proximity triggered like 
homing spike and fixed detonation time (half a second, 5 beeps) and explode.  

Legged Spike: Proximity triggered sentient spike. Not smart enough to avoid obstacles. 
Will drown to death, fall to their death and running into a wall. 
Unable to jump because of the short legs. Follows player.  

Ghost Spike: Proximity triggered floating spike. 
Does not kill player but temporarily blinds them (and bonus jumpscare). Phase through
everything.  

Sir Spiker: The boss. Larger than usual.  

#### Credits
- 
