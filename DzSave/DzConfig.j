library DzConfig uses SystemCodes

    int array DzConfigString[10][100]

    #define DzConA DzConfigString[0]
    #define DzConB DzConfigString[1]

    function GetDzHdToPlayer(int pid)
        int n = 0
        if  DzConA[0] == 1
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,60, "|cffffcc00[系统]：|r|cffff0000地图存档未开启！|r")
        endif
    endfunction
    
    function GetDzHD()
        int n = 0
        if  DzConA[0] == 1

        endif
    endfunction
    
    function InitDzConfig()
        string S = ""
        S = DzCon("QJ")
        if  S == ""
            S = "100000000000000000000000000000000000000000000000000000000000"
        endif
        for n = 0,59
            DzConA[n] = S2I(SubString(S,n,n+1))
            //BJDebugMsg(DzConA[n])
        end
        if  DzCon("TEST") == "1"
            DzBool = true
        elseif  DzCon("TEST") == "2"
            DzBool = true
            textbool = true
        endif
    endfunction     

    
endlibrary
