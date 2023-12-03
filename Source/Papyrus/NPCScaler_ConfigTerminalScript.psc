ScriptName NPCScaler_ConfigTerminalScript Extends ActiveMagicEffect

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory

GlobalVariable Property NPCScaler_Enabled Auto Const Mandatory
GlobalVariable Property NPCScaler_ScalingMin Auto Const Mandatory
GlobalVariable Property NPCScaler_ScalingMax Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Actor Property PlayerRef Auto
Form Property NPCScaler_ConfigTerminal Auto
Message Property NPCScaler_ConfigTerminal_MainMenu Auto
Message Property NPCScaler_ConfigTerminal_ConfigScaleMin Auto
Message Property NPCScaler_ConfigTerminal_ConfigScaleMax Auto

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
        ;; CLICKED 1: Enable NPC Resizing
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 1 Clicked - Enabling NPC Resize.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_MainMenu
        NPCScaler_Enabled.SetValueInt(1)
      ElseIf (menuButtonClicked == 2)
        ;; CLICKED 2: Disable NPC Resizing
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 2 clicked - Disabling NPC Resize.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_MainMenu
        NPCScaler_Enabled.SetValueInt(0)
      ElseIf (menuButtonClicked == 3)
        ;; CLICKED 3: Set minimum size scale
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 3 clicked - Launching NPCScaler_ConfigTerminal_ConfigScaleMin menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_ConfigScaleMin
      ElseIf (menuButtonClicked == 4)
        ;; CLICKED 4: Set maximum size scale
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Main Menu Button 4 clicked - Launching NPCScaler_ConfigTerminal_ConfigScaleMax menu.", 0, Venpi_DebugEnabled.GetValueInt())
        message = NPCScaler_ConfigTerminal_ConfigScaleMax
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show minimum size scale
    ElseIf (message == NPCScaler_ConfigTerminal_ConfigScaleMin)
      menuButtonClicked = NPCScaler_ConfigTerminal_ConfigScaleMin.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Minimum scale to 35% (Minimum engine can take without targeting errors)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 1 clicked - Minimum scale to 35% (Minimum engine can take without targeting errors).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.35)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Minimum scale to 40%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 2 clicked - Minimum scale to 40%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.40)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Minimum scale to 50%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 3 clicked - Minimum scale to 50%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.50)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Minimum scale to 60%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 4 clicked - Minimum scale to 60%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.60)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Minimum scale to 70%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 5 clicked - Minimum scale to 70%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.70)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Minimum scale to 75%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 6 clicked - Minimum scale to 75%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.75)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Minimum scale to 80%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 7 clicked - Minimum scale to 80%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.80)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: Minimum scale to 85%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 8 clicked - Minimum scale to 85%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.85)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: Minimum scale to 90% (Default)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 9 clicked - Minimum scale to 90% (Default).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.90)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 10) 
        ;; CLICKED 10: Minimum scale to 95%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 10 clicked - Minimum scale to 95%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(0.95)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 11) 
        ;; CLICKED 11: Minimum scale to 100%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 11 clicked - Minimum scale to 100%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(1.00)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 12) 
        ;; CLICKED 12: Minimum scale to 105%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 12 clicked - Minimum scale to 105%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(1.05)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 13) 
        ;; CLICKED 13: Minimum scale to 110%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Minimum Scale Size Button 13 clicked - Minimum scale to 110%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMin.SetValue(1.10)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      EndIf

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Show maximum size scale
    ElseIf (message == NPCScaler_ConfigTerminal_ConfigScaleMax)
      menuButtonClicked = NPCScaler_ConfigTerminal_ConfigScaleMax.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      If (menuButtonClicked == 0)
        ;; CLICKED 0: Return to main menu
      ElseIF (menuButtonClicked == 1) 
        ;; CLICKED 1: Maximum scale to 85%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 1 clicked - Maximum scale to 85%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(0.85)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 2) 
        ;; CLICKED 2: Maximum scale to 90%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 2 clicked - Maximum scale to 90%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(0.90)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 3) 
        ;; CLICKED 3: Maximum scale to 95%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 3 clicked - Maximum scale to 95%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(0.95)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 4) 
        ;; CLICKED 4: Maximum scale to 100%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 4 clicked - Maximum scale to 100%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.00)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 5) 
        ;; CLICKED 5: Maximum scale to 105%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 5 clicked - Maximum scale to 105%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.05)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 6) 
        ;; CLICKED 6: Maximum scale to 110% (Default)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 6 clicked - Maximum scale to 110% (Default).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.10)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 7) 
        ;; CLICKED 7: Maximum scale to 115%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 7 clicked - Maximum scale to 115%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.15)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 8) 
        ;; CLICKED 8: Maximum scale to 120%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 8 clicked - Maximum scale to 120%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.20)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 9) 
        ;; CLICKED 9: Maximum scale to 125%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 9 clicked - Maximum scale to 125%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.25)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 10) 
        ;; CLICKED 10: Maximum scale to 150%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 10 clicked - Maximum scale to 150%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.50)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 11) 
        ;; CLICKED 11: Maximum scale to 175%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 11 clicked - Maximum scale to 175%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(1.75)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 12) 
        ;; CLICKED 12: Maximum scale to 200%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 12 clicked - Maximum scale to 200%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(2.00)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 13) 
        ;; CLICKED 13: Maximum scale to 250%
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 13 clicked - Maximum scale to 250%.", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(2.5)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      ElseIF (menuButtonClicked == 14) 
        ;; CLICKED 14: Maximum scale to 300% (Max engine can take without targeting errors)
        VPI_Debug.DebugMessage("NPCScaler_ConfigTerminalScript", "ProcessMenu", "Maximum Scale Size Button 14 clicked - Maximum scale to 300% (Max engine can take without targeting errors).", 0, Venpi_DebugEnabled.GetValueInt())
        NPCScaler_ScalingMax.SetValue(3.00)
        message = NPCScaler_ConfigTerminal_MainMenu ;; Return to root menu
      EndIf
    EndIf ;; End Main Menu
  EndWhile
EndFunction
