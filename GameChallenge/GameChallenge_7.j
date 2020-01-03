library GameChallenge7 uses GameChallengeBase

    function GameChallenge_7Flush(int pid)
        for num = 0,5
            SetUnitVertexColor(GameChallengUnit[70+num],255,255,255,0)
        end
        GameChallengInt[70] = 0
        if  GameChallengUnit[79] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[79]))
            RemoveUnit(GameChallengUnit[79])
            GameChallengUnit[79] = null
        endif
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        IsPlayerInChallenge = false
    endfunction
    
    function OpenGameChallenge_7_A_Timer(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = 2816
                        y = 3584
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf70',x,y,270)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        LocAddEffectSetSize(x,y,"effect_az-leiji.mdx",2)
                        LocAddEffectSetSize(x,y,"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r多宝道人登场！！！")
                    endif
                elseif  time == 2
                    SetUnitPositionOfGameChalleng(GameChallengUnit[num],x,3400)
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[多宝道人]：|r哼！尔等再三欺我教门人，今我师尊摆此诛仙阵，你们一个都别想跑！")
                elseif  time == 3
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击败多宝道人|r")
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_7(int pid,int ty)
        real x = 0
        real y = 0
        GameChallenge_7Flush(pid)
        if  ty == 0
            x = 2816
            y = 3168
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 7
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            OpenGameChallenge_7_A_Timer(pid)
        elseif  ty == 1
            x = -1440
            y = 7904
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 7
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
        endif
    endfunction

    function GameChallenge_7_Death(int pid,unit u2)
        int uid = GetUnitTypeId(u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        if  uid == 'uf70'
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功击败多宝道人！")
            GameChallenge_7Flush(pid)
            IsFinshChallenge(7) = true
            //奖励
            PlayerFinishPlotEx(pid,7)
        elseif  uid == 'uf62'
            if  GameChallengOperaWay[6] == 0
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功击杀申公豹！")
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengOperaWay[6] = 1
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[殷郊]：|r吾奉师尊之命，此事不可鲁莽。师尊自会给我一个答案。")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00殷郊加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00殷郊加入己方阵营！|r") 
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00殷郊加入己方阵营！|r")                                  
                else
                    GameChallengOperaWay[6] = 2
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[殷郊]：|r兄弟竟死于恶人之手，我与姜尚不共戴天！")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000殷郊加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000殷郊加入敌方阵营！|r") 
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000殷郊加入敌方阵营！|r") 
                endif
            endif
            GameChallenge_6Flush(pid)
            PlayerChallengeCosNum(6) = PlayerChallengeCosNum(6) + 1
            //奖励
            PlayerFinishPlotEx(pid,6)
        endif
    endfunction


endlibrary
