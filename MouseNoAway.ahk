;
; ƒ}ƒEƒX! “¦‚°‚é‚È!
;
; 2010/04/19 opa
;

#Persistent
#NoEnv
#SingleInstance Force

#Include %A_ScriptDir%
#Include WinHook.ahk

Auto-Execute:
	SetWorkingDir, %A_ScriptDir%
	Menu, Tray, Icon, , , 1
	Menu, Tray, Tip, MouseNoAway
	OnExit, Exit-Execute
	InstallWindowsHook("", "LowLevelMouseProc")
	exit

Exit-Execute:
	UninstallWindowsHook()
	ExitApp

LowLevelMouseProc(nCode, wParam, lParam)
{
	static lastx := -99999
	static lasty := -99999
	static lasta := 0
	static lastx2 := 0
	static lasty2 := 0
	static discard_count := 0

	Critical
	discard := False
	If(nCode >=0 && (wParam = 0x200)){
		x := NumGet(lParam+0, 0, "int")
		y := NumGet(lParam+0, 4, "int")

		if(lastx > -99999){
			dx := x - lastx
			dy := y - lasty
			a := dx * dx + dy * dy
			g := abs(a - lasta)
		}else{
			a := 0
			g := 0
		}

		dx := x - lastx2
		dy := y - lasty2
		a2 := dx * dx + dy * dy
		lastx2 := x
		lasty2 := y

		if(a2 > 102400){			; A limit
			discard_count++
			discard := True
		}else if(a2 > 200 && g > 50000){	; A, G limit
			discard_count++
			discard := True
		}else{
			lastx := x
			lasty := y
			lasta := a
		}
	}
	Critical, Off

	if(discard){
;		ToolTip, %discard_count%
		return True
	}else{
		return CallNextHookEx(nCode, wParam, lParam)
	}
}

