ScriptName NPCScaler_TerminalMenu_Settings_Script Extends TerminalMenu hidden

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Fragments
;;;
Function Fragment_MenuButton_000(ObjectReference akTerminalRef)
  VPI_Debug.DebugMessage("NPCScaler_TerminalMenu_Settings_Script", "Fragment_MenuButton_000", "Settings Menu Button 0 Clicked - Enable Debug Messages.", 0, Venpi_DebugEnabled.GetValueInt())
  Venpi_DebugEnabled.SetValueInt(1)
EndFunction

Function Fragment_MenuButton_001(ObjectReference akTerminalRef)
  VPI_Debug.DebugMessage("NPCScaler_TerminalMenu_Settings_Script", "Fragment_MenuButton_001", "Settings Menu Button 1 Clicked - Disable Debug Messages.", 0, Venpi_DebugEnabled.GetValueInt())
  Venpi_DebugEnabled.SetValueInt(0)
EndFunction
