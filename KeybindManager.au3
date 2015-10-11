#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Local $iMsgBoxAnswer
$iMsgBoxAnswer = MsgBox(65, "KeyBindManager", "Welcome to InvokerHelper's Keybind Manager. " & @CRLF & "I will help you get started." & @CRLF & @CRLF & " Press ok to begin.")
If $iMsgBoxAnswer = 2 Then
	MsgBox(16, "KeybindManager", "Script will not function properly until all keybinds are properly configured.")
	Exit
EndIf
$iMsgBoxAnswer = MsgBox(65, "KeyBindManager", "In the next several screens, you will see a window to set your binds. " & @CRLF & "You will be shown an example once you press ok.")
If $iMsgBoxAnswer = 2 Then
	MsgBox(16, "KeybindManager", "Script will not function properly until all keybinds are properly configured.")
	Exit
EndIf
Bind("Example")
$iMsgBoxAnswer = MsgBox(65, "KeyBindManager", "You need to match the keybinds Dota is configured to use. " & @CRLF & "You may need to launch dota to view these keybinds." & @CRLF & "By default, quas will be bound to q, wex to w, exort to e, and so forth. " & @CRLF & "Skill 1 and 2 is ability 5 and 6 in your keybinds." & @CRLF & "They are the keys that you press to use the spells you Invoke.")
If $iMsgBoxAnswer = 2 Then
	MsgBox(16, "KeybindManager", "Script will not function properly until all keybinds are properly configured.")
	Exit
EndIf
Bind("Quas")
Bind("Wex")
Bind("Exort")
Bind("Invoke")
Bind("Skill1")
Bind("Skill2")
$iMsgBoxAnswer = MsgBox(65, "KeyBindManager", "In the next several screens, you will be binding where you want each of Invoker's spells to be bound to.")
If $iMsgBoxAnswer = 2 Then
	MsgBox(16, "KeybindManager", "Script will not function properly until all keybinds are properly configured.")
	Exit
EndIf
Bind("ColdSnap")
Bind("GhostWalk")
Bind("IceWall")
Bind("Tornado")
Bind("EMP")
Bind("Alacrity")
Bind("ForgeSpirits")
Bind("ChaosMeteor")
Bind("SunStrike")
Bind("DeafeningBlast")
$iMsgBoxAnswer = MsgBox(65, "KeyBindManager", "The final hotkey you will set is a modifier key." & @CRLF & "Pressing this key will cause the next spell you cast to Invoke only." & @CRLF & "This is useful for preparing spells before fights.")
If $iMsgBoxAnswer = 2 Then
	MsgBox(16, "KeybindManager", "Script will not function properly until all keybinds are properly configured.")
	Exit
EndIf
Bind("InvokeModifier")
MsgBox(64, "KeyBindManager", "You have completed the tutorial. " & @CRLF & "You may now launch InvokerHelper.")
Exit
Func Bind($ininame)
	Global $hotkey = ""
	#Region ### START Koda GUI section ### Form=
	$Form1 = GUICreate($ininame, 240, 97, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $DS_SETFOREGROUND), $WS_EX_WINDOWEDGE)
	$HotkeyInput = GUICtrlCreateInput("", 8, 60, 121, 21)
	$Button1 = GUICtrlCreateButton("Ok", 136, 60, 95, 21)
	$Checkbox1 = GUICtrlCreateCheckbox("Alt", 8, 28, 35, 17)
	$Checkbox2 = GUICtrlCreateCheckbox("Shift", 50, 28, 41, 17)
	$Checkbox3 = GUICtrlCreateCheckbox("Control", 100, 28, 57, 17)
	$Checkbox4 = GUICtrlCreateCheckbox("Windows", 160, 28, 66, 17)
	GUISetState(@SW_SHOW)
	#EndRegion ### END Koda GUI section ###
	If $ininame = "Example" Then MsgBox(64, "KeyBindManager", "Press ok when you are done viewing the example to resume the tutorial.")
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				MsgBox(16, "KeybindManager", "Script will not function properly until all keybinds are properly configured.")
				Exit
			Case $Button1
				GUISetState(@SW_HIDE)
				If $ininame = "Example" Then Return 1
				If GUICtrlRead($Checkbox1) = $gui_checked Then $hotkey &= "!"
				If GUICtrlRead($Checkbox2) = $gui_checked Then $hotkey &= "+"
				If GUICtrlRead($Checkbox3) = $gui_checked Then $hotkey &= "^"
				If GUICtrlRead($Checkbox4) = $gui_checked Then $hotkey &= "#"
				If GUICtrlRead($HotkeyInput) Then
					$hotkey &= "{" & stringlower(GUICtrlRead($HotkeyInput)) & "}"
					IniWrite("InvokerHelper.ini", "Binds", $ininame, $hotkey)
					Return 1
				Else
					MsgBox(16, "KeybindManager", "Script will not function properly until all keybinds are properly configured.")
					Exit
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>Bind
