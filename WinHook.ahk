;keyboard hook code credit: http://www.autohotkey.com/forum/post-127490.html#127490
;
;modified by opa 2010/03/03

InstallWindowsHook(KeyboardHandler = "", MouseHandler = "")
{
   global KeyHookHandle = 0
   global MouseHookHandle = 0

   if(KeyboardHandler != ""){
      KeyHookHandle := SetWindowsHookEx(WH_KEYBOARD_LL := 13, RegisterCallback(KeyboardHandler, "Fast"))
   }

   if(MouseHandler != ""){
      MouseHookHandle := SetWindowsHookEx(WH_MOUSE_LL := 14, RegisterCallback(MouseHandler, "Fast"))
   }
}

UninstallWindowsHook()
{
   global KeyHookHandle
   global MouseHookHandle

   UnhookWindowsHookEx(KeyHookHandle)
   UnhookWindowsHookEx(MouseHookHandle)
}

SetWindowsHookEx(idHook, pfn)
{
   Return DllCall("SetWindowsHookEx", "int", idHook, "Uint", pfn, "Uint", DllCall("GetModuleHandle", "Uint", 0), "Uint", 0)
}

UnhookWindowsHookEx(hHook)
{
   Return DllCall("UnhookWindowsHookEx", "Uint", hHook)
}

CallNextHookEx(nCode, wParam, lParam, hHook = 0)
{
   Return DllCall("CallNextHookEx", "Uint", hHook, "int", nCode, "Uint", wParam, "Uint", lParam)
}

