Scriptname NPCScaler_StatScalerScript extends ActiveMagicEffect  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory

GlobalVariable Property NPCScaler_Enabled Auto Const Mandatory
GlobalVariable Property NPCScaler_ScalingMin Auto Const Mandatory
GlobalVariable Property NPCScaler_ScalingMax Auto Const Mandatory
GlobalVariable Property NPCScaler_Legendary_ChanceToSpawn Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Keyword Property NPCScaler_Scaled Auto Const Mandatory

ActorValue Property Health Auto Const Mandatory
ActorValue Property DamageResist Auto Const Mandatory
ActorValue Property EnergyResist Auto Const Mandatory
ActorValue Property ElectromagneticDamageResist Auto Const Mandatory
ActorValue Property ENV_Resist_Radiation Auto Const Mandatory
ActorValue Property ENV_Resist_Corrosive Auto Const Mandatory
ActorValue Property ENV_Resist_Airborne Auto Const Mandatory
ActorValue Property ENV_Resist_Thermal Auto Const Mandatory
ActorValue Property CriticalHitChance Auto Const Mandatory
ActorValue Property CriticalHitDamageMult Auto Const Mandatory
ActorValue Property AttackDamageMult Auto Const Mandatory
ActorValue Property ReflectDamage Auto Const Mandatory

Keyword Property ActorTypeLegendary Auto Const Mandatory
;; ActorValue Property LegendaryRank Auto Const Mandatory
LegendaryAliasQuestScript Property LegendaryAliasQuest Auto Const mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
ObjectReference Property Myself Auto
Actor Property RealMe Auto

ObjectReference Property PlayerRef Auto Const Mandatory
Actor Property Player Auto


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage("NPCScaler_StatScalerScript", "OnEffectStart", "OnEffectStart triggered", 0, Venpi_DebugEnabled.GetValueInt())
  If (akTarget == None)
    Return
  EndIf

  Myself = akTarget
  RealMe = akTarget.GetSelfAsActor()
  Player = PlayerRef.GetSelfAsActor()

  ;; Have a race condition which shouldn't be possible but injecting a keyword to prevent reprossessing. 
  If (Myself.HasKeyword(NPCScaler_Scaled)) 
    return
  Else
    RealMe.AddKeyword(NPCScaler_Scaled)
  EndIf

  If (NPCScaler_Enabled.GetValueInt() == 1)
    HandleStatScaling()
  Else
    VPI_Debug.DebugMessage("NPCScaler_StatScalerScript", "OnEffectStart", "NPC Stat Scaling is currently disabled.", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
EndEvent

Event OnEffectFinish(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  ; VPI_Debug.DebugMessage("NPCScaler_StatScalerScript", "OnEffectFinish", "OnEffectFinish triggered", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function HandleStatScaling()
  int playerLevel = Player.GetLevel()
  int myLevel = RealMe.GetLeveledActorBase().GetLevel()

  int playerHealth = Player.GetValueInt(Health)
  int myHealth = RealMe.GetValueInt(Health)

  int playerDamageResist = Player.GetValueInt(DamageResist)
  int myDamageResist = RealMe.GetValueInt(DamageResist)
  int playerEnergyResist = Player.GetValueInt(EnergyResist)
  int myEnergyResist = RealMe.GetValueInt(EnergyResist)
  int playerEMDamageResist = Player.GetValueInt(ElectromagneticDamageResist)
  int myEMDamageResist = RealMe.GetValueInt(ElectromagneticDamageResist)

  int playerRadiationResist = Player.GetValueInt(ENV_Resist_Radiation)
  int myRadiationResist = RealMe.GetValueInt(ENV_Resist_Radiation)
  int playerCorrosiveResist = Player.GetValueInt(ENV_Resist_Corrosive)
  int myCorrosiveResist = RealMe.GetValueInt(ENV_Resist_Corrosive)
  int playerAirborneResist = Player.GetValueInt(ENV_Resist_Airborne)
  int myAirborneResist = RealMe.GetValueInt(ENV_Resist_Airborne)
  int playerThermalResist = Player.GetValueInt(ENV_Resist_Thermal)
  int myThermalResist = RealMe.GetValueInt(ENV_Resist_Thermal)

  Float playerReflectDamage = Player.GetValue(ReflectDamage)
  Float myReflectDamage = RealMe.GetValue(ReflectDamage)
  Float playerCriticalHitChance = Player.GetValue(CriticalHitChance)
  Float myCriticalHitChance = RealMe.GetValue(CriticalHitChance)
  Float playerCriticalHitDamageMult = Player.GetValue(CriticalHitDamageMult)
  Float myCriticalHitDamageMult = RealMe.GetValue(CriticalHitDamageMult)
  Float playerAttackDamageMult = Player.GetValue(AttackDamageMult)
  Float myAttackDamageMult = RealMe.GetValue(AttackDamageMult)

  int encounterlevel = RealMe.CalculateEncounterLevel(Game.GetDifficulty())

  ; DebugLevelScaling("INITIAL")

  If (RealMe.HasKeyword(ActorTypeLegendary))
      VPI_Debug.DebugMessage("NPCScaler_StatScalerScript", "HandleStatScaling",  Myself + "> is already a legendary so skipping because the engine handle stat scaling for legendary NPCs fairly well.", 0, Venpi_DebugEnabled.GetValueInt())
      ; DebugLevelScaling("FINAL")
      return
  EndIf

  Int chanceLegendary = NPCScaler_Legendary_ChanceToSpawn.GetValueInt()
  if (chanceLegendary <= 0)
    chanceLegendary = 0
  ElseIF (chanceLegendary >= 100)
    chanceLegendary = 100
  EndIf
  If (chanceLegendary == 100 || Game.GetDieRollSuccess(chanceLegendary, 1, 100, -1, -1))
    ;; Won the lotto I become a legendary
    VPI_Debug.DebugMessage("NPCScaler_StatScalerScript", "HandleStatScaling",  Myself + "> has won the lotto and is now a legendary so skipping because the engine handle stat scaling for legendary NPCs fairly well.", 0, Venpi_DebugEnabled.GetValueInt())
    LegendaryAliasQuest.MakeLegendary(RealMe)
    ; DebugLevelScaling("FINAL")
    return
  EndIf

  Float npcScalingAdjustmentToPlayer = GetScalingAdjustmentForDifficulty()

  string message = "\n\n -=-=-=-=-= STAT DEBUG (" + Myself + ") =-=-=-=-=-\n\n"
  message += "Calculated a stat adjustment factor of " + npcScalingAdjustmentToPlayer + ".\n"

  int scaledHealth = Math.Round(playerHealth * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(Health, scaledHealth)
  message += "Adjusting my Health to " + scaledHealth + " from " + myHealth + " using a scalig factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerHealth + " health.\n"

  int scaledDamageResist = Math.Round(playerDamageResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(DamageResist, scaledDamageResist)
  message += "Adjusting my Damage Resist stat to " + scaledDamageResist + " from " + myDamageResist + " using a scalig factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerDamageResist + " damage resist.\n"

  int scaledEnergyResist = Math.Round(playerEnergyResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(EnergyResist, scaledEnergyResist)
  message += "Adjusting my Energy Resist stat to " + scaledEnergyResist + " from " + myEnergyResist + " using a scalig factor of " + npcScalingAdjustmentToPlayer + " against the player's " + playerEnergyResist + " energy resist.\n"

  int scaledEMDamageResist = Math.Round(playerEMDamageResist * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(ElectromagneticDamageResist, scaledEMDamageResist)
  message += "Adjusting my EM Damage Resist stat to " + scaledEMDamageResist + " from " + myEMDamageResist + " using a scalig factor of " + npcScalingAdjustmentToPlayer  + " against the player's " + playerEMDamageResist + " EM damage resist.\n"

  Float scaledCriticalHitChance = Math.Round(playerCriticalHitChance * npcScalingAdjustmentToPlayer)
  RealMe.SetValue(CriticalHitChance, scaledCriticalHitChance)
  message += "Adjusting my EM Damage Resist stat to " + scaledCriticalHitChance + " from " + myCriticalHitChance + " using a scalig factor of " + npcScalingAdjustmentToPlayer  + " against the player's " + playerCriticalHitChance + " EM damage resist.\n"


  ;; Some stats adjust by rank
  Float scaledAttackDamageMult = Utility.RandomFloat(0.95, 1.25)
  Float scaledCriticalHitDamageMult = Utility.RandomFloat(0.95, 1.25)

  message += "Adjusting my attack multiplier to " + scaledAttackDamageMult + " from " + myAttackDamageMult + " against the player's " + playerAttackDamageMult + ".\n"
  RealMe.SetValue(AttackDamageMult, scaledAttackDamageMult)

  message += "Adjusting my critical damage multiplier to " + scaledCriticalHitDamageMult + " from " + myCriticalHitDamageMult + " against the player's " + playerCriticalHitDamageMult + ".\n"
  RealMe.SetValue(CriticalHitDamageMult, scaledCriticalHitDamageMult)

  message += "\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"
  VPI_Debug.DebugMessage("NPCScaler_StatScalerScript", "HandleStatScaling", message, 0, Venpi_DebugEnabled.GetValueInt())
  DebugLevelScaling("FINAL")
EndFunction

Float Function GetScalingAdjustmentForDifficulty()
  Int iDifficulty = Game.GetDifficulty()
  string sDifficulty = VPI_GameUtilities.GetDifficulty(iDifficulty)

  Float base = Utility.RandomFloat(NPCScaler_ScalingMin.GetValue(),NPCScaler_ScalingMax.GetValue())
  Float calculated = 1
  if (iDifficulty == 0)
    ;; Very Easy Difficulty
    calculated = base + 0.05
  ElseIf (iDifficulty == 1)
    ;; Easy Difficulty
    calculated = base + 0.10
  ElseIf (iDifficulty == 2)
    ;; Normal Difficulty
    calculated = base + 0.25
  ElseIf (iDifficulty == 3)
    ;; Hard Difficulty
    calculated = base + 0.75
  ElseIf (iDifficulty == 4)
    ;; Very Hard Difficulty
    calculated = base + 1.25
  Else 
    ;; Really can only be survival mode
    calculated = base + 5.00
  EndIf

  return calculated
EndFunction

Function DebugLevelScaling(String scalingState)
  int playerLevel = Player.GetLevel()
  int myLevel = RealMe.GetLeveledActorBase().GetLevel()
  string message = "\n\n ********** STAT DEBUG (" + scalingState +  "-" + Myself + ") ********** \n\n"
  message += "Scaling for a player of level " + playerLevel + " and my level is " + myLevel + ".\n"

  int playerHealth = Player.GetValueInt(Health)
  int myHealth = RealMe.GetValueInt(Health)

  int playerDamageResist = Player.GetValueInt(DamageResist)
  int myDamageResist = RealMe.GetValueInt(DamageResist)
  int playerEnergyResist = Player.GetValueInt(EnergyResist)
  int myEnergyResist = RealMe.GetValueInt(EnergyResist)
  int playerEMDamageResist = Player.GetValueInt(ElectromagneticDamageResist)
  int myEMDamageResist = RealMe.GetValueInt(ElectromagneticDamageResist)

  int playerRadiationResist = Player.GetValueInt(ENV_Resist_Radiation)
  int myRadiationResist = RealMe.GetValueInt(ENV_Resist_Radiation)
  int playerCorrosiveResist = Player.GetValueInt(ENV_Resist_Corrosive)
  int myCorrosiveResist = RealMe.GetValueInt(ENV_Resist_Corrosive)
  int playerAirborneResist = Player.GetValueInt(ENV_Resist_Airborne)
  int myAirborneResist = RealMe.GetValueInt(ENV_Resist_Airborne)
  int playerThermalResist = Player.GetValueInt(ENV_Resist_Thermal)
  int myThermalResist = RealMe.GetValueInt(ENV_Resist_Thermal)

  Float playerReflectDamage = Player.GetValue(ReflectDamage)
  Float myReflectDamage = RealMe.GetValue(ReflectDamage)
  Float playerCriticalHitChance = Player.GetValue(CriticalHitChance)
  Float myCriticalHitChance = RealMe.GetValue(CriticalHitChance)
  Float playerCriticalHitDamageMult = Player.GetValue(CriticalHitDamageMult)
  Float myCriticalHitDamageMult = RealMe.GetValue(CriticalHitDamageMult)
  Float playerAttackDamageMult = Player.GetValue(AttackDamageMult)
  Float myAttackDamageMult = RealMe.GetValue(AttackDamageMult)

  int encounterlevel = RealMe.CalculateEncounterLevel(Game.GetDifficulty())

  message += "Current stats (Encounter Level " + encounterlevel +"):\n"
  message += "My/Player Level: " + myLevel + "/" + playerLevel + ".\n"
  message += "My/Player Health: " + myHealth + "/" + playerHealth + ".\n"
  
  message += "My/Player Damage Resist: " + myDamageResist + " | " + playerDamageResist + ".\n"
  message += "My/Player Energy Resist: " + myEnergyResist + " | " + playerEnergyResist + ".\n"
  message += "My/Player EM Resist: " + myEMDamageResist + " | " + playerEMDamageResist + ".\n"

  message += "My/Player Radiation Resist: " + myRadiationResist + " | " + playerRadiationResist + ".\n"
  message += "My/Player Corrosive Resist: " + myCorrosiveResist + " | " + playerCorrosiveResist + ".\n"
  message += "My/Player Airborne Resist: " + myAirborneResist + " | " + playerAirborneResist + ".\n"
  message += "My/Player Thermal Resist: " + myThermalResist + " | " + playerThermalResist + ".\n"

  message += "My/Player Reflect Damage: " + myReflectDamage + " | " + playerReflectDamage + ".\n"
  message += "My/Player Critical Hit Chance: " + myCriticalHitChance + " | " + playerCriticalHitChance + ".\n"
  message += "My/Player Critical Hit Damage Multiplier: " + myCriticalHitDamageMult + " | " + playerCriticalHitDamageMult + ".\n"
  message += "My/Player Attack Damage Multiplier: " + myAttackDamageMult + " | " + playerAttackDamageMult + ".\n"

  message += "\n************************************************************\n\n"
  VPI_Debug.DebugMessage("NPCScaler_StatScalerScript", "DebugLevelScaling-" + scalingState, message, 0, Venpi_DebugEnabled.GetValueInt())
EndFunction
