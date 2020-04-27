library DzConfig uses SystemCodes

    int array DzConfigString[10][100]

    #define DzConA DzConfigString[0]
    #define DzConB DzConfigString[1]

    function GetDzHdToPlayer(int pid)
        int n = 0
        if  DzConA[0] == 1
            n = DzConA[11]
            if  GameMode == 2
                n = n - 1
            endif
            if  n > 0
                if  TimeHour >= 14 and TimeHour <= 21 and DzConA[10] == 1
                    DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cffffcc00[活动]：|r|cff00ff00战争号角活动开启中！通关积分+"+I2S(50*n)+"%|r")
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,10, "|cffffcc00[活动]：|r|cff00ff00通关积分活动开启中！通关积分+"+I2S(50*n)+"%|r")
                endif
            endif

            if  DzConA[24] == 1
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10, "|cffffcc00[活动]：|r|cff00ff00劳动节狂欢活动开启中！")
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,60, "|cffffcc00[系统]：|r|cffff0000地图存档未开启！|r")
        endif
    endfunction
    
    function GetDzHD()
        int n = 0
        if  DzConA[0] == 1
            if  TimeHour >= 14 and TimeHour <= 21 and DzConA[10] == 1
                DzConA[11] = DzConA[11] + 1
            endif
            n = DzConA[11]
            if  n > 0
                if  TimeHour >= 14 and TimeHour <= 21 and DzConA[10] == 1
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10, "|cffffcc00[活动]：|r|cff00ff00战争号角活动开启中！通关积分+"+I2S(50*n)+"%|r")
                else
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10, "|cffffcc00[活动]：|r|cff00ff00通关积分活动开启中！通关积分+"+I2S(50*n)+"%|r")
                endif
            endif

            if  DzConA[24] == 1
                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10, "|cffffcc00[活动]：|r|cff00ff00劳动节狂欢活动开启中！")
            endif
        endif
    endfunction
    
    function InitDzConfig()
        string S = ""
        S = DzCon("QJ")
        if  S == ""
            S = "110000000000111110000000110000000000000000000000000000000000"
        endif
        for n = 0,59
            DzConA[n] = S2I(SubString(S,n,n+1))
            //BJDebugMsg(I2S(n)+"@@@@@"+I2S(DzConA[n]))
        end
        if  DzConA[1] == 1
            QQNumber = "735968074"
        elseif  DzConA[1] == 2
            QQNumber = "809082095"
        elseif  DzConA[1] == 3
            QQNumber = "1035838574"
        elseif  DzConA[1] == 4
            QQNumber = "784736238"
        elseif  DzConA[1] == 4
            QQNumber = "798103390"
        endif

        if  DzCon("TEST") == "1"
            DzBool = true
        elseif  DzCon("TEST") == "2"
            DzBool = true
            textbool = true
        endif

        
    endfunction     

    
endlibrary
