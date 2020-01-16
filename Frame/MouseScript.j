library Mouse  uses TipsTool
    int MouseLeftState = 0
    function MouseDown()
        MouseLeftState = 1
    endfunction
    function MouseUp()
        MouseLeftState = 0
    endfunction
    
    function MouseMove()
        int pid = GetPlayerId(GetLocalPlayer())
        int id = 0
        
    endfunction
    
    function MouseInit()
        
        DzTriggerRegisterMouseMoveEvent(null, false, "MouseMove")
        DzTriggerRegisterMouseEventByCode( null, 1, 1, false, function MouseDown)
        DzTriggerRegisterMouseEventByCode( null, 1, 0, false, function MouseUp)
        
    endfunction
endlibrary
