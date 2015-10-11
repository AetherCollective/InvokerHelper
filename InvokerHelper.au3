#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Invoker.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Fileversion=1.0.0.8
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "misc.au3"
Opt("Sendkeydelay", 15)
Opt("Sendkeydowndelay", 15)
Opt("PixelCoordMode", 2)
Opt("WinTitleMatchMode", -1)
FileInstall("Invoker.ico", "Invoker.ico", 0)
TraySetIcon("Invoker.ico")
Global $orbs = ""
Global $Spell1 = ""
Global $Spell2 = ""
Global $nocast = False
_Singleton(StringTrimRight(@ScriptName, 4))
LoadHotKeys()
OnAutoItExitRegister("OnExit")
WinWait("Dota 2")
$dotares = WinGetClientSize("Dota 2")
idle()
Func idle()
	While 1
		If Not WinExists("Dota 2") Then Exit
		WinWait("Dota 2")
		Sleep(50)
		checkchatmode()
	WEnd
EndFunc   ;==>idle
Func LoadHotKeys()
	;if Ini not found then
	If Not FileExists(StringTrimRight(@ScriptName, 4) & ".ini") Then

		;Create Default Storage to write INI.
		Local $bindStorage[17][2] = _
				[ _
				["ColdSnap", "y"], _
				["GhostWalk", "p"], _
				["IceWall", "i"], _
				["Tornado", "q"], _
				["EMP", "w"], _
				["Alacrity", "o"], _
				["ForgeSpirits", "u"], _
				["ChaosMeteor", "e"], _
				["SunStrike", "t"], _
				["DeafeningBlast", "r"], _
				["InvokeModifier", "{f5}"], _
				["Quas", "q"], _
				["Wex", "w"], _
				["Exort", "e"], _
				["Invoke", "r"], _
				["Skill1", "d"], _
				["Skill2", "f"]]

		;Writes INI from Storage
		$writeerror = IniWriteSection(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", $bindStorage, 0)

		;Informs the user of the result.
		If $writeerror = False Then
			MsgBox(0, StringTrimRight(@ScriptName, 4), "Could not write INI. You need Admin permissions to write to " & @ScriptDir)
			Exit
		EndIf
		MsgBox(0, StringTrimRight(@ScriptName, 4), "Could not find " & @ScriptDir & StringTrimRight(@ScriptName, 4) & ".ini. Loading Default Binds.")

		;Reruns this function, loading the default binds.
		LoadHotKeys()

		;if Ini was found then
	Else
		;Loads the binds stored in your INI.
		Global $ColdSnap = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "ColdSnap", "y")
		Global $GhostWalk = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "GhostWalk", "p")
		Global $IceWall = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "IceWall", "i")
		Global $Tornado = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "Tornado", "q")
		Global $EMP = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "EMP", "w")
		Global $Alacrity = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "Alacrity", "o")
		Global $ForgeSpirits = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "ForgeSpirits", "u")
		Global $ChaosMeteor = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "ChaosMeteor", "e")
		Global $SunStrike = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "SunStrike", "t")
		Global $DeafeningBlast = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "DeafeningBlast", "r")
		Global $InvokeModifier = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "InvokeModifier", "{f5}")
		Global $Quas = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "Quas", "q")
		Global $Wex = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "Wex", "w")
		Global $Exort = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "Exort", "e")
		Global $Invoke = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "Invoke", "r")
		Global $Skill1 = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "Skill1", "d")
		Global $Skill2 = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "Skill2", "f")

		;Turns the hotkeys on
		HotKeysOn()
	EndIf

	;Storage for each spell and their orb combos.
	Global $binds[10][3] = _
			[ _
			[1, $ColdSnap, $Quas & $Quas & $Quas], _
			[2, $GhostWalk, $Quas & $Quas & $Wex], _
			[3, $IceWall, $Quas & $Quas & $Exort], _
			[4, $Tornado, $Wex & $Wex & $Quas], _
			[5, $EMP, $Wex & $Wex & $Wex], _
			[6, $Alacrity, $Wex & $Wex & $Exort], _
			[7, $ForgeSpirits, $Exort & $Exort & $Quas], _
			[8, $ChaosMeteor, $Exort & $Exort & $Wex], _
			[9, $SunStrike, $Exort & $Exort & $Exort], _
			[10, $DeafeningBlast, $Quas & $Wex & $Exort]]
EndFunc   ;==>LoadHotKeys

;Checks if chat is open or not. modifies hotkeys accordingly.
Func checkchatmode()

	;if ingame chat window is open then

		;Lobby checked
		If IsArray(PixelSearch(Int(1 * $dotares[0] - 5), Int(0 * $dotares[1]), Int(1 * $dotares[0]), Int(0.0194 * $dotares[1] + 5), 0x240607, 10)) Then

		HotKeysOff()

		;Ingame Chat checked
	ElseIf IsArray(PixelSearch(Int(0.3567 * $dotares[0] - 5), Int(0.7185 * $dotares[1] - 5), Int(0.3567 * $dotares[0] + 5), Int(0.7185 * $dotares[1] + 5), 0xFFFFFF, 0)) Then

		HotKeysOff()

		;Character Select checked
	ElseIf IsArray(PixelSearch(0, 0, 0, 0, 0x303030, 0)) Then

		HotKeysOff()

		;Loading Lobby
	ElseIf IsArray(PixelSearch($dotares[0], $dotares[1], $dotares[0], $dotares[1], 0x262A2F, 0)) Then

		HotKeysOff()

		;steam UI checked
	ElseIf IsArray(PixelSearch(0, 0, 0, 0, 0x282927, 10)) Then


		HotKeysOff()

	Else

		HotKeysOn()

	EndIf
EndFunc   ;==>checkchatmode
Func HotKeysOn();self explainatory
	HotKeySet(StringLower($ColdSnap), "UseSpell")
	HotKeySet(StringLower($GhostWalk), "UseSpell")
	HotKeySet(StringLower($IceWall), "UseSpell")
	HotKeySet(StringLower($Tornado), "UseSpell")
	HotKeySet(StringLower($EMP), "UseSpell")
	HotKeySet(StringLower($Alacrity), "UseSpell")
	HotKeySet(StringLower($ForgeSpirits), "UseSpell")
	HotKeySet(StringLower($ChaosMeteor), "UseSpell")
	HotKeySet(StringLower($SunStrike), "UseSpell")
	HotKeySet(StringLower($DeafeningBlast), "UseSpell")
	HotKeySet(StringLower($InvokeModifier), "InvokeModifier")
EndFunc   ;==>HotKeysOn
Func HotKeysOff();self explainatory
	HotKeySet(StringLower($ColdSnap))
	HotKeySet(StringLower($GhostWalk))
	HotKeySet(StringLower($IceWall))
	HotKeySet(StringLower($Tornado))
	HotKeySet(StringLower($EMP))
	HotKeySet(StringLower($Alacrity))
	HotKeySet(StringLower($ForgeSpirits))
	HotKeySet(StringLower($ChaosMeteor))
	HotKeySet(StringLower($SunStrike))
	HotKeySet(StringLower($DeafeningBlast))
	HotKeySet(StringLower($InvokeModifier))
EndFunc   ;==>HotKeysOff

;Creates a 5 second nag screen showing thanks to the user for using my software.
;If you took the time to read the source code, then you have my thanks. You may opt out of the NagScreen by appending NagScreen=False to your INI.
Func OnExit()
	Local $nag = IniRead(StringTrimRight(@ScriptName, 4) & ".ini", "Binds", "NagScreen", "True")
	If $nag = "True" Then MsgBox(0, StringTrimRight(@ScriptName, 4), "Coded by BetaLeaf. Thanks for using my software.", 5)
EndFunc   ;==>OnExit
Func UseSpell()
	;Turns hotkeys off
	HotKeysOff()

	;Detects which hotkey was pressed.
	;check each bind
	For $i = 0 To 9

		;if hotkey was pressed
		If @HotKeyPressed = $binds[$i][1] Then

			;remember which hotkey was pressed
			Local $spellUsed = $i

			;Exits the FOR NEXT loop.
			ExitLoop
		EndIf
	Next;check next bind, Marks end of loop.

	;If spell exists in Slot 1 then
	If $Spell1 = $spellUsed Then

		;do nothing
		Sleep(0)

		;ElseIf spell exists in Slot 2 then
	ElseIf $Spell2 = $spellUsed Then

		;do nothing
		Sleep(0)
	Else

		;Else Invokes the spell. Stores the Invoked spell in storage so AutoIt can keep track of which spells are invoked.
		Send($binds[$spellUsed][2] & $Invoke, "0")

		;Spell 1 becomes spell 2
		$Spell2 = $Spell1

		;Invoked spell becomes spell 1
		$Spell1 = $spellUsed

		;Sleep to allow new spell to fully load into Invoker's Inventory. Without this delay, the previous spell would be used instead.
		Sleep(200)
	EndIf

	;Uses the spell
	If $nocast = False Then
		;If Hotkey represents slot 1 spell, then presses the key for slot 1, Else If Hotkey represents slot 2 spell, then presses the key for slot 2, Else does nothing.
		If $spellUsed = $Spell1 Then
			Send($Skill1)
		ElseIf $spellUsed = $Spell2 Then
			Send($Skill2)
		EndIf
	Else
		Sleep(0)
	EndIf
	;Resets the NoCast Flag.
	$nocast = False
	;Turns hotkeys back on
	HotKeysOn()
EndFunc   ;==>UseSpell
Func InvokeModifier()
	;This flag prevents UseSpell() from casting after it invokes a spell. This is useful for preparing skills for an upcoming teamfight.
	$nocast = True
EndFunc   ;==>InvokeModifier
