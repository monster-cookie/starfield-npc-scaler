ScriptName NPCScaler_ConfigTerminalScript Extends ActiveMagicEffect

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory

GlobalVariable Property NPCScaler_Enabled Auto Const Mandatory
GlobalVariable Property NPCScaler_ScalingMin Auto Const Mandatory
GlobalVariable Property NPCScaler_ScalingMax Auto Const Mandatory

GlobalVariable Property NPCScaler_BaseAdjustment_VE Auto Const Mandatory
GlobalVariable Property NPCScaler_BaseAdjustment_E Auto Const Mandatory
GlobalVariable Property NPCScaler_BaseAdjustment_N Auto Const Mandatory
GlobalVariable Property NPCScaler_BaseAdjustment_H Auto Const Mandatory
GlobalVariable Property NPCScaler_BaseAdjustment_VH Auto Const Mandatory
GlobalVariable Property NPCScaler_BaseAdjustment_TSV Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Actor Property PlayerRef Auto
Form Property NPCScaler_ConfigTerminal Auto
Message Property NPCScaler_ConfigTerminal_MainMenu Auto
Message Property NPCScaler_ConfigTerminal_ConfigScaleMin Auto
Message Property NPCScaler_ConfigTerminal_ConfigScaleMax Auto
Message Property NPCScaler_ConfigTerminal_ConfigCurrentDifficultyBase Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  If (akTarget == PlayerRef as ObjectReference)
    VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "OnEffectStart", "Regenerating the item and calling process menu.", 0, Venpi_DebugEnabled.GetValueInt())
    PlayerRef.AddItem(NPCScaler_ConfigTerminal, 1, True) ;; Need to replace the item we just consumed to trigger the menu
    Self.ProcessMenu(NPCScaler_ConfigTerminal_MainMenu, -1, True)
  Else
    VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "OnEffectStart", "Inventoy object trigger by someone other then the player??? PlayerRef = " + PlayerRef as ObjectReference + " Target is " + akTarget + ".", 0, Venpi_DebugEnabled.GetValueInt())
  EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function ProcessMenu(Message message, Int menuButtonClicked, Bool menuActive)
  While (menuActive)
    If (message == NPCScaler_ConfigTerminal_MainMenu)
      menuButtonClicked = NPCScaler_ConfigTerminal_MainMenu.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Close Menu Clicked
        menuActive = False
      ElseIf (menuButtonClicked == 1)
        ;; CLICKED 1: Enable NPC Stat Scaling
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 1 Clicked - Enable NPC Stat Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_MainMenu
        NPCScaler_Enabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 2)
        ;; CLICKED 2: Disable NPC Stat Scaling
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 2 clicked - Disable NPC Stat Scaling.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_MainMenu
        NPCScaler_Enabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 3)
        ;; CLICKED 3: Enable Debug Mode
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 3 Clicked - Enable Debug Mode.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_MainMenu
        Venpi_DebugEnabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 4)
        ;; CLICKED 4: Disable Debug Mode
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 4 clicked - Disable Debug Mode.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_MainMenu
        Venpi_DebugEnabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 5)
        ;; CLICKED 5: Set minimum stat adjustment factor
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 5 clicked - Launching NPCScaler_ConfigTerminal_ConfigScaleMin menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_ConfigScaleMin
      ElseIf (menuButtonClicked == 6)
        ;; CLICKED 6: Set maximum stat adjustment factor
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 6 clicked - Launching NPCScaler_ConfigTerminal_ConfigScaleMax menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_ConfigScaleMax
      ElseIf (menuButtonClicked == 7)
        ;; CLICKED 7: Set base adjustment factor for current difficulty setting
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 7 clicked - Launching NPCScaler_ConfigTerminal_ConfigCurrentDifficultyBase menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_ConfigCurrentDifficultyBase
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Set minimum stat adjustment factor
    ElseIf (message == NPCScaler_ConfigTerminal_ConfigScaleMin)
      menuButtonClicked = NPCScaler_ConfigTerminal_ConfigScaleMin.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Minimum stat adjustment to 35% (Close to what game default is)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 1 clicked - Minimum stat adjustment to 35% (Close to what game default is).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.35)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Minimum stat adjustment to 40%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 2 clicked - Minimum stat adjustment to 40%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.40)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Minimum stat adjustment to 50%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 3 clicked - Minimum stat adjustment to 50%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.50)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Minimum stat adjustment to 60%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 4 clicked - Minimum stat adjustment to 60%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.60)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Minimum stat adjustment to 70%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 5 clicked - Minimum stat adjustment to 70%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.70)
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Minimum stat adjustment to 75%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 6 clicked - Minimum stat adjustment to 75%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.75)
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Minimum stat adjustment to 80% (Default)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 7 clicked - Minimum stat adjustment to 80% (Default).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.80)
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: Minimum stat adjustment to 85%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 8 clicked - Minimum stat adjustment to 85%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.85)
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: Minimum stat adjustment to 90%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 9 clicked - Minimum stat adjustment to 90%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.90)
      ElseIF (menuButtonClicked == 10) 
        ;; CLICKED 10: Minimum stat adjustment to 95%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 10 clicked - Minimum stat adjustment to 95%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.95)
      ElseIF (menuButtonClicked == 11) 
        ;; CLICKED 11: Minimum stat adjustment to 100% (Match Player Stats Exactly)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 11 clicked - Minimum stat adjustment to 100% (Match Player Stats Exactly).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(1.00)
      ElseIF (menuButtonClicked == 12) 
        ;; CLICKED 12: Minimum stat adjustment to 105%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 12 clicked - Minimum stat adjustment to 105%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(1.05)
      ElseIF (menuButtonClicked == 13) 
        ;; CLICKED 13: Minimum stat adjustment to 110%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 13 clicked - Minimum stat adjustment to 110%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(1.10)
      ElseIF (menuButtonClicked == 14) 
        ;; CLICKED 14: Minimum stat adjustment to 115%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 14 clicked - Minimum stat adjustment to 115%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(1.15)
      ElseIF (menuButtonClicked == 15) 
        ;; CLICKED 15: Minimum stat adjustment to 125%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 15 clicked - Minimum stat adjustment to 125%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(1.25)
      ElseIF (menuButtonClicked == 16) 
        ;; CLICKED 16: Minimum stat adjustment to 150%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 16 clicked - Minimum stat adjustment to 150%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(1.50)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  Show Menu: Set maximum stat adjustment factor
    ElseIf (message == NPCScaler_ConfigTerminal_ConfigScaleMax)
      menuButtonClicked = NPCScaler_ConfigTerminal_ConfigScaleMax.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Maximum stat adjustment to 35% (Close to what game default is)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 1 clicked - Maximum stat adjustment to 35% (Close to what game default is).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(0.35)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Maximum stat adjustment to 85%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 2 clicked - Maximum stat adjustment to 85%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(0.85)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Maximum stat adjustment to 90%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 3 clicked -Maximum stat adjustment to 90%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(0.90)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Maximum stat adjustment to 95%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 4 clicked - Maximum stat adjustment to 95%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(0.95)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Maximum stat adjustment to 100% (Match Player Stats Exactly)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 5 clicked - Maximum stat adjustment to 100% (Match Player Stats Exactly).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.00)
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Maximum stat adjustment to 105%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 6 clicked - Maximum stat adjustment to 105%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.05)
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Maximum stat adjustment to 110%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 7 clicked - Maximum stat adjustment to 110%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.10)
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: Maximum stat adjustment to 115%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 8 clicked - Maximum stat adjustment to 115%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.15)
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: Maximum stat adjustment to 120%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 9 clicked - Maximum stat adjustment to 120%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.20)
      ElseIF (menuButtonClicked == 10) 
        ;; CLICKED 10: Maximum stat adjustment to 125% (Default)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 10 clicked - Maximum stat adjustment to 125% (Default).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.25)
      ElseIF (menuButtonClicked == 11) 
        ;; CLICKED 11: Maximum stat adjustment to 150%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 11 clicked - Maximum stat adjustment to 150%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.50)
      ElseIF (menuButtonClicked == 12) 
        ;; CLICKED 12: Maximum stat adjustment to 175%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 12 clicked - Maximum stat adjustment to 175%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.75)
      ElseIF (menuButtonClicked == 13) 
        ;; CLICKED 13: Maximum stat adjustment to 200%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 13 clicked - Maximum stat adjustment to 200%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(2.0)
      ElseIF (menuButtonClicked == 14) 
        ;; CLICKED 14: Maximum stat adjustment to 250%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 14 clicked - Maximum stat adjustment to 250%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(2.50)
      ElseIF (menuButtonClicked == 15) 
        ;; CLICKED 15: Maximum stat adjustment to 300%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 15 clicked - Maximum stat adjustment to 300%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(3.0)
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show Menu: Set base adjustment factor for current difficulty setting 
    ElseIf (message == NPCScaler_ConfigTerminal_ConfigCurrentDifficultyBase)
      menuButtonClicked = NPCScaler_ConfigTerminal_ConfigCurrentDifficultyBase.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Base scaling factor to 0% (Default for Very Easy)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 1 clicked - Base scaling factor to 0% (Default for Very Easy).", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.0)
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Base scaling factor to 10% (Default for Easy)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 2 clicked - Base scaling factor to 10% (Default for Easy).", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.10)
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Base scaling factor to 20%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 3 clicked - Base scaling factor to 20%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.20)
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Base scaling factor to 25% (Default for Normal)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 4 clicked - Base scaling factor to 25% (Default for Normal).", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.25)
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Base scaling factor to 30%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 5 clicked - Base scaling factor to 30%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.30)
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Base scaling factor to 40%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 6 clicked - Base scaling factor to 40%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.40)
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Base scaling factor to 50%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 7 clicked - Base scaling factor to 50%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.50)
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: Base scaling factor to 60%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 8 clicked - Base scaling factor to 60%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.60)
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: Base scaling factor to 70%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 9 clicked - Base scaling factor to 70%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.70)
      ElseIF (menuButtonClicked == 10) 
        ;; CLICKED 10: Base scaling factor to 75% (Default for Hard)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 10 clicked - Base scaling factor to 75% (Default for Hard).", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.75)
      ElseIF (menuButtonClicked == 11) 
        ;; CLICKED 11: Base scaling factor to 80%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 11 clicked - Base scaling factor to 80%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.80)
      ElseIF (menuButtonClicked == 12) 
        ;; CLICKED 12: Base scaling factor to 90%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 12 clicked - Base scaling factor to 90%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(0.90)
      ElseIF (menuButtonClicked == 13) 
        ;; CLICKED 13: Base scaling factor to 100%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 13 clicked - Base scaling factor to 100%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(1.0)
      ElseIF (menuButtonClicked == 14) 
        ;; CLICKED 14: Base scaling factor to 125% (Default for Very Hard)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 14 clicked - Base scaling factor to 125% (Default for Very Hard).", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(1.25)
      ElseIF (menuButtonClicked == 15) 
        ;; CLICKED 15: Base scaling factor to 150%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 15 clicked - Base scaling factor to 150%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(1.50)
      ElseIF (menuButtonClicked == 16) 
        ;; CLICKED 16: Base scaling factor to 175%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 16 clicked - Base scaling factor to 175%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(1.75)
      ElseIF (menuButtonClicked == 17) 
        ;; CLICKED 17: Base scaling factor to 200%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 17 clicked - Base scaling factor to 200%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(2.00)
      ElseIF (menuButtonClicked == 18) 
        ;; CLICKED 18: Base scaling factor to 225%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 18 clicked - Base scaling factor to 225%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(2.25)
      ElseIF (menuButtonClicked == 19) 
        ;; CLICKED 19: Base scaling factor to 250%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 19 clicked - Base scaling factor to 250%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(2.50)
      ElseIF (menuButtonClicked == 20) 
        ;; CLICKED 20: Base scaling factor to 275%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 20 clicked - Base scaling factor to 275%.", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(2.75)
      ElseIF (menuButtonClicked == 21) 
        ;; CLICKED 21: Base scaling factor to 300% (Default for Survival/Nightmare)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Difficulty Base Adjustment Factor Button 21 clicked - Base scaling factor to 300% (Default for Survival/Nightmare).", 0, Venpi_DebugEnabled.GetValueInt())
        SetBaseAdjustmentForCurrentDifficulty(3.00)
      EndIf
    EndIf ;; End Main Menu
  EndWhile
EndFunction

Function SetBaseAdjustmentForCurrentDifficulty(Float adjustment)
  Int iDifficulty = Game.GetDifficulty()
  if (iDifficulty == 0)
    ;; Very Easy Difficulty
    NPCScaler_BaseAdjustment_VE.SetValue(adjustment)
  ElseIf (iDifficulty == 1)
    ;; Easy Difficulty
    NPCScaler_BaseAdjustment_E.SetValue(adjustment)
  ElseIf (iDifficulty == 2)
    ;; Normal Difficulty
    NPCScaler_BaseAdjustment_N.SetValue(adjustment)
  ElseIf (iDifficulty == 3)
    ;; Hard Difficulty
    NPCScaler_BaseAdjustment_H.SetValue(adjustment)
  ElseIf (iDifficulty == 4)
    ;; Very Hard Difficulty
    NPCScaler_BaseAdjustment_VH.SetValue(adjustment)
  Else 
    ;; Really can only be survival/nightmare mode
    NPCScaler_BaseAdjustment_TSV.SetValue(adjustment)
  EndIf
EndFunction
