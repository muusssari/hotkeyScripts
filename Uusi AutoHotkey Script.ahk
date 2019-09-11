
 
#singleInstance, force ;one instance is easier to handle
SendMode Input ;for the fast sending keys
 
SetTitleMatchMode, 3
#IfWinActive Counter-Strike: Global Offensive
 
;0 = default
;1 = tap once
;2 = tap twice
;3 = burst
;4 = fully auto for semi auto
fireMode = 0
 
;0 = off
;1 = on
noRecoil = 0
 
canAuto = 0
 
BHopOn = 0
 
consistPull = 0
 
firstShotRecoilTimeMax = 15
firstShotRecoilTime = 0
 
firstShotRestTimeMax = 5
firstShotRestTime = 0
 
buyWinShow = 0
 
;FileRead, tempWepText, %A_WorkingDir%\buy_info.txt
tempWepText := "nova|xm1014|sawedoff|m249|negev|mac10|mp7|ump45|p90|bizon|famas|m4a1|ssg08|aug|awp|scar20`nelite|p250|tec9|deagle`nvest|vesthelm|Taser|defuser`nmolotov|decoy|flashbang|hegrenade|smokegrenade`nNova|XM1014|Sawed-Off/MAG-7|M249|Negev|MAC-10/MP9|MP7|UMP-45|P90|PP-Bizon|Galil AR/FAMAS|AK47/M4A4/M4A1-S|SSG 08|SG 553/AUG|AWP|G3SG1/SCAR-20`nDual Berettas|P250|Tec-9/Five-SeveN/CZ75-Auto|Desert Eagle`nKevlar Vest|Kevlar + Helmet|Zeus x27|Defuse/Rescue Kit`nMolotov/Incendiary Grenade|Decoy Grenade|Flashbang|High Explosive Grenade|Smoke Grenade"
 
;remove all of the \r for simplicity
StringReplace, tempWepText, tempWepText, `r, ,
;arrays 1-4 is console name
;arrays 5-8 is label (alias)
StringSplit, wepArray, tempWepText, `n,
;the split string array is for the sake of simplicity
StringSplit, wepArraySplit1, wepArray1, |,
StringSplit, wepArraySplit2, wepArray2, |,
StringSplit, wepArraySplit3, wepArray3, |,
StringSplit, wepArraySplit4, wepArray4, |,
 
;read the saved presets file
FileRead, tempSaveText, %A_WorkingDir%\buy_save.txt
If ErrorLevel = 1
{
	FileAppend, None#None#None#None^None#None#None#None^None#None#None#None, %A_WorkingDir%\buy_save.txt
	FileRead, tempSaveText, %A_WorkingDir%\buy_save.txt
}
StringReplace, tempSaveText, tempSaveText, `r, ,
StringSplit, tempSaveArray, tempSaveText, ^,
StringSplit, tempSaveArraySplit1, tempSaveArray1, #,
StringSplit, tempSaveArraySplit2, tempSaveArray2, #,
StringSplit, tempSaveArraySplit3, tempSaveArray3, #,
;this is were the saved presets are stored
primary1 := tempSaveArraySplit11
secondary1 := tempSaveArraySplit12
gear1 := tempSaveArraySplit13
grenade1 := tempSaveArraySplit14
 
primary2 := tempSaveArraySplit21
secondary2 := tempSaveArraySplit22
gear2 := tempSaveArraySplit23
grenade2 := tempSaveArraySplit24
 
primary3 := tempSaveArraySplit31
secondary3 := tempSaveArraySplit32
gear3 := tempSaveArraySplit33
grenade3 := tempSaveArraySplit34
 
;show GUI
Gui, Show, w200 h300, CS:GO Tools
Gui, Add, Button, x10 y10 w180 h20 vSHOWBUYBUTTON gSHOWBUY, Autobuy Settings >>
Gui, Add, GroupBox, x10 y50 w135 h190, Other:
Gui, Add, Text, x20 y70 w200 vFIREMODE cBlue, Fire Mode: Default
Gui, Add, Text, x20 y90 vNORECOIL cBlue, No Recoil: Off
Gui, Add, Text, x20 y110 cBlue, No Recoil Amount:
Gui, Add, Edit
Gui, Add, UpDown, vNORECOILAMT Range1-8, 1
Gui, Add, CheckBox, x20 y160 vFireStop, Stop On Fire
Gui, Add, CheckBox, x20 y180 vSlowAuto, Slow Down Auto Fire
Gui, Add, Text, x20 y200 vBHOP cBlue, BHop: Off
Gui, Add, Text, x20 y220 vCONSISTPULL cBlue, Consistent Pull: Off
 
Gui, Add, GroupBox, x-5 y270 w205 h50,
Gui, Add, Text, x5 y280, Good Luck`, Have Fun!
 
Gui, 2:+AlwaysOnTop +ToolWindow -Caption
Gui, 2:Show, x10 y10 w220 h500, CS:GO Buy Settings
Gui, 2:Hide
Gui, 2:Add, Text, x10 y10, Primary:
Gui, 2:Add, DropDownList, x10 y30 w150 vPrimaryWep Choose1 AltSubmit, None|%wepArray5%
Gui, 2:Add, Text, x10 y60, Secondary:
Gui, 2:Add, DropDownList, x10 y80 w150 vSecondaryWep Choose1 AltSubmit, None|%wepArray6%
Gui, 2:Add, Text, x10 y110, Gear:
Gui, 2:Add, ListBox, x10 y130 w150 h120 vGearWep Multi Choose1 AltSubmit, None|%wepArray7%
Gui, 2:Add, Text, x10 y250, Grenade:
Gui, 2:Add, ListBox, x10 y270 w150 h120 vGrenadeWep Multi Choose1 AltSubmit, None|%wepArray8%
Gui, 2:Add, Text, x10 y390, Set As Key:
Gui, 2:Add, Button, x10 y410 w60 h60 vPRESET1BUTTON gPRESET1, Numpad 1
Gui, 2:Add, Button, x80 y410 w60 h60 vPRESET2BUTTON gPRESET2, Numpad 2
Gui, 2:Add, Button, x150 y410 w60 h60 vPRESET3BUTTON gPRESET3, Numpad 3
 
OnExit, GuiClose
 
return ;return so that the program does not run the code below on start-up
 
*Up::
 
GuiControlGet, NORECOILAMT
NORECOILAMT := NORECOILAMT + 1
GuiControl, , NORECOILAMT, %NORECOILAMT%
 
return
 
*Down::
 
GuiControlGet, NORECOILAMT
NORECOILAMT := NORECOILAMT - 1
GuiControl, , NORECOILAMT, %NORECOILAMT%
 
return
 
SHOWBUY:
 
WinGetPos, guiPosX, guiPosY,,, A
guiPosX := guiPosX + 200
if(buyWinShow == 0){
	GuiControl,, SHOWBUYBUTTON, Autobuy Settings <<
	Gui, 2:Show, x%guiPosX% y%guiPosY% Restore
	buyWinShow = 1
}else{
	GuiControl,, SHOWBUYBUTTON, Autobuy Settings >>
	Gui, 2:Hide
	buyWinShow = 0
}
 
return
 
;handle the preset button clicks
PRESET1:
 
GuiControlGet, PrimaryWep
GuiControlGet, SecondaryWep
GuiControlGet, GearWep
GuiControlGet, GrenadeWep
PrimaryWep -= 1
SecondaryWep -= 1
 
if(PrimaryWep != 0)
	primary1 := wepArraySplit1%PrimaryWep%
else
	primary1 := "None"
if(SecondaryWep != 0)
	secondary1 := wepArraySplit2%SecondaryWep%
else
	secondary1 := "None"
 
Loop, parse, GearWep, |
{
	tempVar := A_LoopField - 1
	if(tempVar != 0){
		if(A_Index == 1)
			gear1 := wepArraySplit3%tempVar%
		else
			gear1 := gear1 . "|" . wepArraySplit3%tempVar%
	}else{
		gear1 := "None"
	}
}
 
Loop, parse, GrenadeWep, |
{
	tempVar := A_LoopField - 1
	if(tempVar != 0){
		if(A_Index == 1)
			grenade1 := wepArraySplit4%tempVar%
		else
			grenade1 := grenade1 . "|" . wepArraySplit4%tempVar%
	}else{
		grenade1 := "None"
		break
	}
}
 
return
 
PRESET2:
 
GuiControlGet, PrimaryWep
GuiControlGet, SecondaryWep
GuiControlGet, GearWep
GuiControlGet, GrenadeWep
PrimaryWep -= 1
SecondaryWep -= 1
 
if(PrimaryWep != 0)
	primary2 := wepArraySplit1%PrimaryWep%
else
	primary2 := "None"
if(SecondaryWep != 0)
	secondary2 := wepArraySplit2%SecondaryWep%
else
	secondary2 := "None"
 
Loop, parse, GearWep, |
{
	tempVar := A_LoopField - 1
	if(tempVar != 0){
		if(A_Index == 1)
			gear2 := wepArraySplit3%tempVar%
		else
			gear2 := gear2 . "|" . wepArraySplit3%tempVar%
	}else{
		gear2 := "None"
	}
}
 
Loop, parse, GrenadeWep, |
{
	tempVar := A_LoopField - 1
	if(tempVar != 0){
		if(A_Index == 1)
			grenade2 := wepArraySplit4%tempVar%
		else
			grenade2 := grenade2 . "|" . wepArraySplit4%tempVar%
	}else{
		grenade2 := "None"
		break
	}
}
 
return
 
PRESET3:
 
GuiControlGet, PrimaryWep
GuiControlGet, SecondaryWep
GuiControlGet, GearWep
GuiControlGet, GrenadeWep
PrimaryWep -= 1
SecondaryWep -= 1
 
if(PrimaryWep != 0)
	primary3 := wepArraySplit1%PrimaryWep%
else
	primary3 := "None"
if(SecondaryWep != 0)
	secondary3 := wepArraySplit2%SecondaryWep%
else
	secondary3 := "None"
 
Loop, parse, GearWep, |
{
	tempVar := A_LoopField - 1
	if(tempVar != 0){
		if(A_Index == 1)
			gear3 := wepArraySplit3%tempVar%
		else
			gear3 := gear3 . "|" . wepArraySplit3%tempVar%
	}else{
		gear3 := "None"
	}
}
 
Loop, parse, GrenadeWep, |
{
	tempVar := A_LoopField - 1
	if(tempVar != 0){
		if(A_Index == 1)
			grenade3 := wepArraySplit4%tempVar%
		else
			grenade3 := grenade3 . "|" . wepArraySplit4%tempVar%
	}else{
		grenade3 := "None"
		break
	}
}
 
return
 
GuiClose:
 
FileDelete, %A_WorkingDir%\buy_save.txt
saveText := primary1 . "#" . secondary1 . "#" . gear1 . "#" . grenade1 . "^" . primary2 . "#" . secondary2 . "#" . gear2 . "#" . grenade2 . "^" . primary3 . "#" . secondary3 . "#" . gear3 . "#" . grenade3
FileAppend, %saveText%, %A_WorkingDir%\buy_save.txt
ExitApp
 
return
 
*CapsLock::
 
BHopOn += 1
if(BHopOn > 1){
	BHopOn = 0
}
if(BHopOn == 0)
	GuiControl, , BHOP, BHop: Off
else
	GuiControl, , BHOP, BHop: On
 
return
 
*Space::
 
	if(BHopOn == 1){
		While GetKeyState("Space", "P"){
			Send {Space Down}
			Sleep 20
			Send {Space Up}
			Sleep 30 ;This is the wait time between the space presses
		}
	}else{
		Send {Space Down}
		KeyWait, Space
		Send {Space Up}
	}
 
return
 
*RAlt::
 
noRecoil += 1
if(noRecoil > 1){
	noRecoil = 0
}
if(noRecoil == 0)
	GuiControl, , NORECOIL, No Recoil: Off
else
	GuiControl, , NORECOIL, No Recoil: On
 
return
 
*RShift::
 
consistPull += 1
if(consistPull > 1){
	consistPull = 0
}
if(consistPull == 0)
	GuiControl, , CONSISTPULL, Consistent Pull: Off
else
	GuiControl, , CONSISTPULL, Consistent Pull: On
 
return
 
;toggles the fireMode using right ctrl
*RCtrl::
 
fireMode = 0 ;default
KeyWait, RCtrl
GuiControl, , FIREMODE, Fire Mode: Default
 
return
 
*Numpad7::
 
fireMode = 1 ;tap once
KeyWait, Numpad7
GuiControl, , FIREMODE, Fire Mode: 1x Tap Fire
 
return
 
*Numpad8::
 
fireMode = 2 ;tap twice
KeyWait, Numpad8
GuiControl, , FIREMODE, Fire Mode: 2x Tap Fire
 
return
 
*Numpad9::
 
fireMode = 3 ;burst
KeyWait, Numpad9
GuiControl, , FIREMODE, Fire Mode: Burst Fire
 
return
 
*Numpad4::
 
fireMode = 4 ;full auto for semi auto
KeyWait, Numpad4
GuiControl, , FIREMODE, Fire Mode: Auto Fire
 
return
 
*Numpad5::
 
fireMode = 5 ;full auto for semi auto
KeyWait, Numpad5
GuiControl, , FIREMODE, Fire Mode: Knife
 
return
 
*Numpad6::
 
fireMode = 6 ;tap = burst, click and hold = regular fire
KeyWait, Numpad6
GuiControl, , FIREMODE, Fire Mode: TapBurstHoldRegular
 
return
 
;handles the numpad events (use preset)
*Numpad1::
 
Send ``
 
Random, tempRand, 140, 160
Sleep %tempRand%
 
if(primary1 != "None"){
	Send buy%A_Space%%primary1%
	Random, tempRand, 140, 160
	Sleep %tempRand%
	Send {Enter down}
	Sleep 50
	Send {Enter up}
	Sleep 50
}
if(secondary1 != "None"){
	Send buy%A_Space%%secondary1%
	Random, tempRand, 140, 160
	Sleep %tempRand%
	Send {Enter down}
	Sleep 50
	Send {Enter up}
	Sleep 50
}
if(gear1 != "None"){
	Loop, parse, gear1, |
	{
		Send buy%A_Space%%A_LoopField%
		Random, tempRand, 140, 160
		Sleep %tempRand%
		Send {Enter down}
		Sleep 50
		Send {Enter up}
		Sleep 50
	}
}
if(grenade1 != "None"){
	Loop, parse, grenade1, |
	{
		Send buy%A_Space%%A_LoopField%
		Random, tempRand, 140, 160
		Sleep %tempRand%
		Send {Enter down}
		Sleep 50
		Send {Enter up}
		Sleep 50
	}
}
 
Random, tempRand, 140, 160
Sleep %tempRand%
Send {ESC}
 
return
 
*Numpad2::
 
Send ``
 
Random, tempRand, 140, 160
Sleep %tempRand%
 
if(primary2 != "None"){
	Send buy%A_Space%%primary2%
	Random, tempRand, 140, 160
	Sleep %tempRand%
	Send {Enter down}
	Sleep 50
	Send {Enter up}
	Sleep 50
}
if(secondary2 != "None"){
	Send buy%A_Space%%secondary2%
	Random, tempRand, 140, 160
	Sleep %tempRand%
	Send {Enter down}
	Sleep 50
	Send {Enter up}
	Sleep 50
}
if(gear2 != "None"){
	Loop, parse, gear2, |
	{
		Send buy%A_Space%%A_LoopField%
		Random, tempRand, 140, 160
		Sleep %tempRand%
		Send {Enter down}
		Sleep 50
		Send {Enter up}
		Sleep 50
	}
}
if(grenade2 != "None"){
	Loop, parse, grenade2, |
	{
		Send buy%A_Space%%A_LoopField%
		Random, tempRand, 140, 160
		Sleep %tempRand%
		Send {Enter down}
		Sleep 50
		Send {Enter up}
		Sleep 50
	}
}
 
Random, tempRand, 140, 160
Sleep %tempRand%
Send {ESC}
 
return
 
*Numpad3::
 
Send ``
 
Random, tempRand, 140, 160
Sleep %tempRand%
 
if(primary3 != "None"){
	Send buy%A_Space%%primary3%
	Random, tempRand, 140, 160
	Sleep %tempRand%
	Send {Enter down}
	Sleep 50
	Send {Enter up}
	Sleep 50
}
if(secondary3 != "None"){
	Send buy%A_Space%%secondary3%
	Random, tempRand, 140, 160
	Sleep %tempRand%
	Send {Enter down}
	Sleep 50
	Send {Enter up}
	Sleep 50
}
if(gear3 != "None"){
	Loop, parse, gear3, |
	{
		Send buy%A_Space%%A_LoopField%
		Random, tempRand, 140, 160
		Sleep %tempRand%
		Send {Enter down}
		Sleep 50
		Send {Enter up}
		Sleep 50
	}
}
if(grenade3 != "None"){
	Loop, parse, grenade3, |
	{
		Send buy%A_Space%%A_LoopField%
		Random, tempRand, 140, 160
		Sleep %tempRand%
		Send {Enter down}
		Sleep 50
		Send {Enter up}
		Sleep 50
	}
}
 
Random, tempRand, 140, 160
Sleep %tempRand%
Send {ESC}
 
return
 
;handles left click for the burst and tap fire
$*LButton::
 
GuiControlGet, FireStop
GuiControlGet, SlowAuto
if(FireStop == 1){
	if(GetKeyState("a", "P") && !GetKeyState("d", "P")){
		Hotkey, *a, dummyLabel, On
		Send {a down}
		Sleep 20
		Send {a up}
	}else if(GetKeyState("d", "P") && !GetKeyState("a", "P")){
		Hotkey, *d, dummyLabel, On
		Send {d down}
		Sleep 20
		Send {d up}
	}
	
	if(GetKeyState("w", "P") && !GetKeyState("s", "P")){
		Hotkey, *w, dummyLabel, On
		Send {w down}
		Sleep 20
		Send {w up}
	}else if(GetKeyState("s", "P") && !GetKeyState("w", "P")){
		Hotkey, *s, dummyLabel, On
		Send {s down}
		Sleep 20
		Send {s up}
	}
}
 
GuiControlGet, NORECOILAMT
if(fireMode == 0){ ;default
	Click down
	While GetKeyState("LButton", "P"){
		if(noRecoil == 1){
			if(consistPull == 0){
				if(firstShotRestTime > firstShotRestTimeMax){
					if(firstShotRecoilTime > firstShotRecoilTimeMax){
						mouseXY(0, NORECOILAMT)
						Random, tempRand, 200, 220
						Sleep %tempRand%
					}else{
						firstShotRecoilTime += 1
						mouseXY(0, NORECOILAMT * 2)
						Random, tempRand, 20, 40
						Sleep %tempRand%
					}
				}else{
					firstShotRestTime += 1
					Random, tempRand, 20, 40
					Sleep %tempRand%
				}
			}else{
				if(firstShotRestTime > firstShotRestTimeMax){
					mouseXY(0, NORECOILAMT)
					Random, tempRand, 20, 40
					Sleep %tempRand%
				}else{
					firstShotRestTime += 1
					Random, tempRand, 20, 40
					Sleep %tempRand%
				}
			}
		}
	}
	Click up
}else if(fireMode == 1){ ;tap once
	Click down
	Random, tempRand, 40, 60
	Sleep %tempRand%
	Click up
}else if(fireMode == 2){ ;tap twice
	Click down
	Random, tempRand, 40, 60
	Sleep %tempRand%
	Click up
	Random, tempRand, 50, 70
	Sleep %tempRand%
	Click down
	Random, tempRand, 40, 60
	Sleep %tempRand%
	Click up
}else if(fireMode == 3){ ;burst
	Click down
	Random, tempRand, 175, 250
	Sleep %tempRand%
	Click up
}else if(fireMode == 4){ ;auto for semi-autos
	While GetKeyState("LButton", "P"){
		Random, tempRand, 15, 25
		Click down
		Sleep %tempRand%
		Click up
		if(noRecoil == 1 && SlowAuto != 1){
			if(consistPull == 0){
				if(firstShotRestTime > firstShotRestTimeMax){
					if(firstShotRecoilTime > firstShotRecoilTimeMax){
						mouseXY(0, NORECOILAMT)
						Random, tempRand, 200, 220
						Sleep %tempRand%
					}else{
						firstShotRecoilTime += 1
						mouseXY(0, NORECOILAMT * 2)
						Random, tempRand, 20, 40
						Sleep %tempRand%
					}
				}else{
					firstShotRestTime += 1
					Random, tempRand, 20, 40
					Sleep %tempRand%
				}
			}else{
				if(firstShotRestTime > firstShotRestTimeMax){
					mouseXY(0, NORECOILAMT)
					Random, tempRand, 20, 40
					Sleep %tempRand%
				}else{
					firstShotRestTime += 1
					Random, tempRand, 20, 40
					Sleep %tempRand%
				}
			}
		}
		if(SlowAuto == 1){
			Random, tempRand, 400, 500
		}
		Sleep %tempRand%
		WinGetTitle, title, A
		if(title != "Counter-Strike: Global Offensive")
		{
			break
		}
		If !GetKeyState("LButton", "P")
		{
			break
		}
	}
}else if(fireMode == 5){
	While GetKeyState("LButton", "P"){
		Click down
		Random, tempRand, 20, 30
		Sleep %tempRand%
		Click up
		Random, tempRand, 500, 600
		Sleep %tempRand%
		Click down
		Random, tempRand, 20, 30
		Sleep %tempRand%
		Click up
		Random, tempRand, 500, 600
		Sleep %tempRand%
		Click down right
		Random, tempRand, 20, 30
		Sleep %tempRand%
		Click up right
		Random, tempRand, 1000, 1200
		Sleep %tempRand%
	}
}else if(fireMode == 6){
	Click down
	canAuto = 0
	SetTimer, LButtonHeld, 200
	While GetKeyState("LButton", "P"){
		if(noRecoil == 1){
			if(consistPull == 0){
				if(firstShotRestTime > firstShotRestTimeMax){
					if(firstShotRecoilTime > firstShotRecoilTimeMax){
						mouseXY(0, NORECOILAMT)
						Random, tempRand, 200, 220
						Sleep %tempRand%
					}else{
						firstShotRecoilTime += 1
						mouseXY(0, NORECOILAMT * 2)
						Random, tempRand, 20, 40
						Sleep %tempRand%
					}
				}else{
					firstShotRestTime += 1
					Random, tempRand, 20, 40
					Sleep %tempRand%
				}
			}else{
				if(firstShotRestTime > firstShotRestTimeMax){
					mouseXY(0, NORECOILAMT)
					Random, tempRand, 20, 40
					Sleep %tempRand%
				}else{
					firstShotRestTime += 1
					Random, tempRand, 20, 40
					Sleep %tempRand%
				}
			}
		}
	}
	if(canAuto == 0){
		Click up
		Random, tempRand, 50, 100
		Sleep %tempRand%
		Click down
		Random, tempRand, 30, 40
		Sleep %tempRand%
		Click up
		SetTimer, LButtonHeld, Off
	}else{
		Click up
	}
}
firstShotRecoilTime = 0
firstShotRestTime = 0
if(FireStop == 1){
	Hotkey, *a, dummyLabel, Off
	Hotkey, *d, dummyLabel, Off
	Hotkey, *w, dummyLabel, Off
	Hotkey, *s, dummyLabel, Off
	if(GetKeyState("a", "P") && !GetKeyState("d", "P")){
		Sleep 20
		Send {a down}
		Sleep 20
		Send {a up}
	}else if(GetKeyState("d", "P") && !GetKeyState("a", "P")){
		Sleep 20
		Send {d down}
		Sleep 20
		Send {d up}
	}
	
	if(GetKeyState("w", "P") && !GetKeyState("s", "P")){
		Sleep 20
		Send {w down}
		Sleep 20
		Send {w up}
	}else if(GetKeyState("s", "P") && !GetKeyState("w", "P")){
		Sleep 20
		Send {s down}
		Sleep 20
		Send {s up}
	}
}
 
return
 
LButtonHeld:
 
canAuto = 1
 
return
 
mouseXY(x, y) ;moves the mouse (relative movements)
{
    DllCall("mouse_event",uint,1,int,x,int,y,uint,0,int,0)
}
 
dummyLabel: ;does nothing (to disable a key)
return 