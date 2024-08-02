#Requires AutoHotkey v2.0
#SingleInstance

_windowTitle := "ahk_exe M1-Win64-Shipping.exe"
_flag := false

_moveKeys := Map("W", "W", "A", "A", "S", "S", "D", "D")
_abilityKeys := Map("1", "1", "2", "2", "3", "3", "4", "4")
_runKey := "LShift"
_jumpKey := "Space"
_fireKey := "LButton"
_escKey := "Esc"

#HotIf WinActive(_windowTitle)
~$*XButton1::
{   
    if (_flag)
    {
        return
    }

    global _flag := true

    Bunny_Jump_Abort()

    global _flag := false
}
~$*F5::
{
    if (!_flag)
    {
        return
    }

    global _flag := false
    SendInput(_moveKeys["W"]["U"])
    SendInput(_runKey["U"])
}
#HotIf
Bunny_Jump()
{
    time := DateAdd(A_Now, 30, "S")

    SendInput(_runKey["D"])
    Sleep(5)
    SendInput(_abilityKeys["2"]["D"])
    Sleep(5)
    SendInput(_abilityKeys["2"]["U"])

    while(_flag && WinActive(_windowTitle))
    {
        if(DateDiff(time, A_Now, "S") < 0)
        {
            SendInput(_abilityKeys["2"]["D"])
            Sleep(50)
            SendInput(_abilityKeys["2"]["U"])
            Sleep(50)

            time := DateAdd(A_Now, 30, "S")
        }
        SendInput(_abilityKeys["3"]["D"])
        Sleep(50)
        SendInput(_abilityKeys["3"]["U"])
        Sleep(50)
        SendInput(_jumpKey["D"])
        Sleep(50)
        SendInput(_jumpKey["U"])
        Sleep(50)
    }

    SendInput(_runKey["U"])
}

_abort := Map("X", 222, "Y", 444)
Bunny_Jump_Abort()
{
    time := DateAdd(A_Now, 12, "S")

    SendInput(_runKey["D"])
    Sleep(5)
    SendInput(_abilityKeys["2"]["D"])
    Sleep(5)
    SendInput(_abilityKeys["2"]["U"])

    while(_flag && WinActive(_windowTitle))
    {
        if(DateDiff(time, A_Now, "S") < 0)
        {
            Abort(_abort["X"], _abort["Y"])
            
            time := DateAdd(A_Now, 12, "S")
        }

        SendInput(_abilityKeys["3"]["D"])
        Sleep(50)
        SendInput(_abilityKeys["3"]["U"])
        Sleep(50)
        SendInput(_jumpKey["D"])
        Sleep(50)
        SendInput(_jumpKey["U"])
        Sleep(50)
    }

    SendInput(_runKey["U"])
}
Abort(_abort_X, _abort_Y)
{
    SendInput(_escKey["D"])
    Sleep(100)
    SendInput(_escKey["U"])
    Sleep(100)
    MouseMove(_abort_X, _abort_Y, 0)
    Sleep(100)
    SendInput(_fireKey["D"])
    Sleep(100)
    SendInput(_fireKey["U"])
    Sleep(100)
    SendInput(_jumpKey["D"])
    Sleep(100)
    SendInput(_jumpKey["U"])
    Sleep(400)
}
_moveKeys["W"] := GetMap(_moveKeys["W"])
_moveKeys["A"] := GetMap(_moveKeys["A"])
_moveKeys["S"] := GetMap(_moveKeys["S"])
_moveKeys["D"] := GetMap(_moveKeys["D"])
_abilityKeys["1"] := GetMap(_abilityKeys["1"])
_abilityKeys["2"] := GetMap(_abilityKeys["2"])
_abilityKeys["3"] := GetMap(_abilityKeys["3"])
_abilityKeys["4"] := GetMap(_abilityKeys["4"])
_runKey := GetMap(_runKey)
_jumpKey := GetMap(_jumpKey)
_fireKey := GetMap(_fireKey)
_escKey := GetMap(_escKey)

GetMap(key)
{
    _map := Map()

    key := GetKeyVK(key)
    
    _map["K"] := Format("{Blind}{VK{:X}}", key)
    _map["D"] := Format("{Blind}{VK{:X} Down}", key)
    _map["U"] := Format("{Blind}{VK{:X} Up}", key)
    
    return _map
}