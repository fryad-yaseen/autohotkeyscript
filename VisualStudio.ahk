#Requires AutoHotkey v2.0

A_MaxHotkeysPerInterval := 2000
A_HotkeyInterval := 2000

SetCapsLockState "AlwaysOff" ; Keep Caps Lock permanently disabled
CapsLock::Esc

; Method to handle the keys with selection
HandleSelection(Key) {
    if GetKeyState("Control", "P") && GetKeyState("Shift", "P") ; Control + Shift
        Send("{Control down}{Shift down}" Key "{Shift up}{Control up}")
    else if GetKeyState("Shift", "P") && GetKeyState("Alt", "P") ; Shift + Alt
        Send("{Shift down}{Alt down}" Key "{Alt up}{Shift up}")
    else if GetKeyState("Control", "P") && GetKeyState("Alt", "P") ; Control + Alt
        Send("{Control down}{Alt down}" Key "{Alt up}{Control up}")
    else if GetKeyState("Shift", "P") ; Shift
        Send("{Shift down}" Key "{Shift up}")
    else if GetKeyState("Alt", "P") ; Alt
        Send("{Alt down}" Key "{Alt up}")
    else if GetKeyState("Control", "P") ; Control
        Send("{Control down}" Key "{Control up}")
    else
        Send(Key)
}

; Using CapsLock with ESC to reset CapsLock state
CapsLock & Esc:: {
    SetCapsLockState "AlwaysOff"
    ToolTip "CapsLock Reset - Always Off"
    SetTimer () => ToolTip(), -1000  ; Clear tooltip after 1 second
}

; Using CapsLock with BackSpace and Delete and BackSpace + Shift to delete word from right and left
{
    CapsLock & Backspace:: {
        if GetKeyState("Alt", "p") {
            Send("{Home}+{End}")
        }
        else if GetKeyState("Shift", "p") {
            Send("^{Right}^+{Left}")
        }
        else {
            Send("^{Left}^+{Right}")
        }
        Send("{Backspace}")
    }

    CapsLock & Delete:: {
        Send("^{Right}^+{Left}{Backspace}")
    }
}

; Using CapsLock with 1, 2, 3, 4, 5 to move curser to lines
{
    CapsLock & 1:: HandleKey(1)
    CapsLock & 2:: HandleKey(2)
    CapsLock & 3:: HandleKey(3)
    CapsLock & 4:: HandleKey(4)
    CapsLock & 5:: HandleKey(5)

    SendRepeatedKey(count, key) {
        loop count {
            Send(key)
        }
    }

    HandleKey(count) {
        if GetKeyState("Shift", "P")
            SendRepeatedKey(count, "{Down}")
        else
            SendRepeatedKey(count, "{Up}")
    }
}

; Using CapsLock with h, j, k, l as vim arrow keys
{
    CapsLock & h:: HandleSelection("{Left}")
    CapsLock & j:: HandleSelection("{Down}")
    CapsLock & k:: HandleSelection("{Up}")
    CapsLock & l:: HandleSelection("{Right}")
}

; Using CapsLock with u, o as HOME and END
{
    CapsLock & u:: HandleSelection("{Home}")
    CapsLock & o:: HandleSelection("{End}")
}

; Using CapsLock with Q and Z as ScrollUp and Down
{
    CapsLock & q:: Send("{WheelUp 1}")
    CapsLock & z:: Send("{WheelDown 1}")
}

; Using CapsLock with Q and Z as PageUp and Down
{
    CapsLock & w:: HandleSelection("{PgUp}")
    CapsLock & x:: HandleSelection("{PgDn}")
}

; Using CpasLock with p to pause media
{
    CapsLock & p:: Send("{Media_Play_Pause}")
}

; Using CapsLock with Volume keys for scrolling and zooming
{
    ; === CapsLock + Volume Up ===
    CapsLock & Volume_Up:: {
        if GetKeyState("Control", "P")
            Send("^{WheelUp}")      ; Zoom in
        else if GetKeyState("Shift", "P") {
            Send("{WheelRight}")    ; Scroll right
        }
        else
            Send("{WheelDown}")     ; Scroll down (default)
        SetCapsLockState "AlwaysOff"
    }

    ; === CapsLock + Volume Down ===
    CapsLock & Volume_Down:: {
        if GetKeyState("Control", "P")
            Send("^{WheelDown}")    ; Zoom out
        else if GetKeyState("Shift", "P") {
            Send("{WheelLeft}")     ; Scroll left
        }
        else
            Send("{WheelUp}")       ; Scroll up (default)
        SetCapsLockState "AlwaysOff"
    }
}

#MaxThreadsPerHotkey 2

; global toggle := false  ; Declare toggle as a global variable

; F1:: {
;     global toggle
;     toggle := !toggle
;     while toggle {
;         Click
;         Sleep 1 ; Adjust delay (milliseconds) between clicks
;     }
; }


