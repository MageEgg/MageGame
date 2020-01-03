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
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        IsPlayerInChallenge = false
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

    function OpenGameChallenge_8(int pid,int ty)
        real x = 0
        real y = 0
        GameChallenge_8Flush(pid)
        if  ty == 0
            x = 2816
            y = 3168
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 8
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)

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
        if  uid == 'uf70'
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功击败多宝道人！")
            GameChallenge_7Flush(pid)
            IsFinshChallenge(7) = true
            //奖励
            PlayerFinishPlotEx(pid,7)
        elseif  uid == 'uf71'
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r绝仙阵已破，速去援助玉鼎真人破阵！")
            GameChalleng_7_Zhen_2(pid)
        elseif  uid == 'uf72'
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r陷仙阵已破，速去援助赤精子破阵！")
            GameChalleng_7_Zhen_3(pid)
        elseif  uid == 'uf73'
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r戮仙阵已破，速去援助广成子破阵！")
            GameChalleng_7_Zhen_4(pid)
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
                /*GameChallengUnit[82] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np18',4256,2624,225)
                SetUnitVertexColor(GameChallengUnit[82],255,255,255,0)
                GameChallengUnit[83] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np16',4256,4864,225)
                SetUnitVertexColor(GameChallengUnit[83],255,255,255,0)
                GameChallengUnit[84] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np19',1664,4992,225)
                SetUnitVertexColor(GameChallengUnit[84],255,255,255,0)*/
            endif
        end
    endfunction

endlibrary
