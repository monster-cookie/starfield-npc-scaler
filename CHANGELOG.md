# V1.0 Permutations

## V1.0.5
* New scaling/preset difficulties Normal no change to the rules, hard increases the scaling factor by 2, nightmare increases it by 4, and apocalypse increase by 8. 
* Crit damage/Attack mult are now a factor of your level diff so if you are level 10 the attack boost is 1, level 50 is 1.32, level 100 is 1.58, level 150 is 3.49, level 250 is 7.96

## V1.0.4
* Scaling by NPC race (Human, Robot, Critter, Creature) and default as a fall back. Default/Human/Robot are enabled with base=.1, scaleMin=0.8, scaleMax=1.1; Critter is disabled with base=0, scaleMin=0.4, scaleMax=0.8; finally, Creature is disabled with base=0, scaleMin=0.6, scaleMax=0.9;
* Base is a true generic base that adjust for difficulty using multipliers are 0 for Very Easy, 1 for Easy, 3 for Normal, 6 for hard, 12 for very hard, 30 for TSV.
* Easter egg mode for critters brings back our critter overlords but only a 5% chance of happening. It increases min by 25% and max by 50%. I'm working on giving them an obvious animation effect/glow but that will be a later update probably with custom loot as critters don't get loot.
* The new stat adjustment setting seems stable to me though I did run into a random sponge or 2 but very rare. 

## V1.0.3
* In PEX land evaluating the keywords and excluding all CCT NPCs from scaling, like critters they become super creature mutants.
* Requires Venpi's Core Utilities 1.0.6 or newer 

## V1.0.2
* Stat scaling will no longer be applied to critters (via race and keyword)

## V1.0.1
* Imported some game settings from Dynamic Scaling.

## V1.0.0
* Initial Release