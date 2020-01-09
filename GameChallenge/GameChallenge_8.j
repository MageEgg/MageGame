library GameChallenge8 uses GameChallengeBase

    function GameChallenge_8Flush(int pid)
        for num = 0,3
            SetUnitVertexColor(GameChallengUnit[80+num],255,255,255,0)
        end
        GameChallengInt[80] = 0
        if  GameChallengUnit[89] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[89]))
            RemoveUnit(GameChallengUnit[89])
            GameChallengUnit[89] = null
        endif
        GameChallenge_GlobalFlush(pid)
    endfunction

    function GameChallenge_8_BTimer(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        TimerStart(1,true)
        {
            time = time + 1
            real ang = 0
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = 1952
                        y = 6720
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf87',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r袁洪进攻！！！")
                    endif
                elseif  time == 2
                    ang = Atan2(GetUnitY(Pu[1])-y,GetUnitX(Pu[1])-x)
                    x = x + 300*Cos(ang)
                    y = y + 300*Sin(ang)
                    SetUnitPositionOfGameChalleng(GameChallengUnit[num],x,y)
                    SetUnitFacing(GameChallengUnit[num],ang/0.01745)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[姜子牙]：|r似此恶怪，害人无厌。情殊痛恨，推出斩之！")
                elseif  time == 3
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀袁洪|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChallenge_8_A_1(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        TimerStart(1,true)
        {
            real ang = 0
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[袁洪]：|r成汤相传数十世，尔等世受国恩，无故造反。快快下马投降，尚待你等不死。")
                elseif  time == 2
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[姜子牙]：|r无知匹夫！")
                elseif  time == 3
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = 2208
                        y = 7808
                        ang = Atan2(GetUnitY(Pu[1])-y,GetUnitX(Pu[1])-x)
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf80',x,y,ang/0.01745)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 4
                    SetUnitVertexColor(GameChallengUnit[82],255,255,255,0)
                    SetUnitVertexColor(GameChallengUnit[83],255,255,255,0)
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀梅山第一怪|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChallenge_8_A_2(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = 2688+120  
        y = 8224-300    
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            real ang = 0
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = 2688
                        y = 8224
                        ang = Atan2(GetUnitY(Pu[1])-y,GetUnitX(Pu[1])-x)
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf81',x,y,ang/0.01745)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀梅山第二怪|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChallenge_8_A_3(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = 3328-50
        y = 8064-300  
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            real ang = 0
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = 3328
                        y = 8064
                        ang = Atan2(GetUnitY(Pu[1])-y,GetUnitX(Pu[1])-x)
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf82',x,y,ang/0.01745)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀梅山第三怪|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChallenge_8_A_4(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = 3840-250   
        y = 7584-250  
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            real ang = 0
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = 3840
                        y = 7584
                        ang = Atan2(GetUnitY(Pu[1])-y,GetUnitX(Pu[1])-x)
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf83',x,y,ang/0.01745)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀梅山第四怪|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChallenge_8_A_5(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = 3904-250 
        y = 6880-200
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            real ang = 0
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = 3904
                        y = 6880
                        ang = Atan2(GetUnitY(Pu[1])-y,GetUnitX(Pu[1])-x)
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf84',x,y,ang/0.01745)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀梅山第五怪|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChallenge_8_A_6(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = 3520-250 
        y = 6464-100
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            real ang = 0
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = 3520
                        y = 6464
                        ang = Atan2(GetUnitY(Pu[1])-y,GetUnitX(Pu[1])-x)
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf85',x,y,ang/0.01745)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀梅山第六怪|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChallenge_8_A_7(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = 4128-200 
        y = 8448-200
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            real ang = 0
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = 4128
                        y = 8448
                        ang = Atan2(GetUnitY(Pu[1])-y,GetUnitX(Pu[1])-x)
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf86',x,y,ang/0.01745)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀袁洪|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_8(int pid,int ty)
        real x = 0
        real y = 0
        GameChallenge_8Flush(pid)
        ShowPlayerTaskUIOfPlayer(pid,true,0)
        if  ty == 0
            x = 2336
            y = 7488
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 8
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            GameChallengInt[80] = 1
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[82],UnitAPOfPlayer)
            UnitAddEffectOfGameChalleng(GameChallengUnit[82])
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[83],UnitAPOfPlayer)
            GameChallenge_8_A_1(pid)
        elseif  ty == 1
            x = 1952
            y = 6368
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 8
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            GameChallengInt[80] = 100
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[80],UnitAPOfPlayer)
            UnitAddEffectOfGameChalleng(GameChallengUnit[80])
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[81],UnitAPOfPlayer)
            GameChallenge_8_BTimer(pid)
        endif
    endfunction

    function GameChallenge_8_Death(int pid,unit u2)
        int uid = GetUnitTypeId(u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        if  uid == 'uf80'
            if  GameChallengInt[80] == 1
                GameChallengInt[80] = GameChallengInt[80] + 1
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功击杀梅山第一怪！")
                GameChallenge_8_A_2(pid)
            endif
        elseif  uid == 'uf81'
            if  GameChallengInt[80] == 2
                GameChallengInt[80] = GameChallengInt[80] + 1
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功击杀梅山第二怪！")
                GameChallenge_8_A_3(pid)
            endif
        elseif  uid == 'uf82'
            if  GameChallengInt[80] == 3
                GameChallengInt[80] = GameChallengInt[80] + 1
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功击杀梅山第三怪！")
                GameChallenge_8_A_4(pid)
            endif
        elseif  uid == 'uf83'
            if  GameChallengInt[80] == 4
                GameChallengInt[80] = GameChallengInt[80] + 1
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功击杀梅山第四怪！")
                GameChallenge_8_A_5(pid)
            endif
        elseif  uid == 'uf84'
            if  GameChallengInt[80] == 5
                GameChallengInt[80] = GameChallengInt[80] + 1
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功击杀梅山第五怪！")
                GameChallenge_8_A_6(pid)
            endif
        elseif  uid == 'uf85'
            if  GameChallengInt[80] == 6
                GameChallengInt[80] = GameChallengInt[80] + 1
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r梅山六怪已除，就此入成汤营劫杀袁洪！！！")
                GameChallenge_8_A_7(pid)
            endif
        elseif  uid == 'uf86'
            if  GameChallengInt[80] == 7
                GameChallengInt[80] = 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r袁洪已被擒获，胜利在望！！！")
                GameChallenge_8Flush(pid)
                IsFinshChallenge(8) = true
                //奖励
                PlayerFinishPlotEx(pid,8)
            endif
        elseif  uid == 'uf87'
            if  GameChallengOperaWay[8] == 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功击杀袁洪！")
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengOperaWay[8] = 1
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[姜子牙]：|r果然如此，此怪采天地灵气，炼日月精华，故斩之不尽。幸陆压老师已将斩仙飞刀传授于我，专克元神。")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-收梅山七怪]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00姜子牙加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-收梅山七怪]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00姜子牙加入己方阵营！|r")  
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-收梅山七怪]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00姜子牙加入己方阵营！|r")                                 
                else
                    GameChallengOperaWay[8] = 2
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[姜子牙]：|r气煞我也，怎得给他逃脱了呢？！")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-收梅山七怪]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000袁洪加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-诛仙阵斗法]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000袁洪加入敌方阵营！|r") 
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-诛仙阵斗法]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000袁洪加入敌方阵营！|r")  
                endif
            endif
            GameChallenge_8Flush(pid)
            PlayerChallengeCosNum(8) = PlayerChallengeCosNum(8) + 1
            //奖励
            PlayerFinishPlotEx(pid,8)
        endif
    endfunction

    function InitGameChallenge_8()
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[80] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',1728,6112,45)
                SetUnitVertexColor(GameChallengUnit[80],255,255,255,0)
                GameChallengUnit[81] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e008',1728,6112,0)
                SetUnitVertexColor(GameChallengUnit[81],255,255,255,0)
                GameChallengUnit[82] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',2592,7800,270)
                SetUnitVertexColor(GameChallengUnit[82],255,255,255,0)
                GameChallengUnit[83] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e008',2592,7800,0)
                SetUnitVertexColor(GameChallengUnit[83],255,255,255,0)
            endif
        end
    endfunction

endlibrary
