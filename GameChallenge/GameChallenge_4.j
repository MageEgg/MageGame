library GameChallenge4 uses GameChallengeBase

    function GameChallenge_4Flush(int pid,real time)
        for num = 0,7
            SetUnitVertexColor(GameChallengUnit[40+num],255,255,255,0)
        end
        GameChallengInt[40] = 0
        SetUnitAnimation(GameChallengUnit[43],"stand")
        GameChallenge_GlobalFlush(pid,time)
    endfunction

    function OpenGameChallenge_4(int pid,int ty)
        real x = 0
        real y = 0
        GameChallenge_4Flush(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        SetPlayerAllianceVISION(pid,false)
        if  ty == 0
            x = -1728
            y = -896
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 4
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","天仙赵公明助闻太师攻打西岐，神秘大能-陆压传子牙“钉头七箭书”应对。",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往姜子牙|r",0.3)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[40],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[41],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[42],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[43],UnitAPOfPlayer)
        elseif  ty == 1
            x = -512
            y = -928
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 4
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            SetPlayerTaskUIChatOfPlayer(pid,"任务","前往赵公明！",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往赵公明|r",0.3)
            for num = 3,7
                ShowUnitOfOnlyPlayer(pid,GameChallengUnit[40+num],UnitAPOfPlayer)
            end
        endif
    endfunction

    function GameChalleng_4_DeathA(int pid,unit u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        GameChallengInt[40] = GameChallengInt[40] + 1
        if  GameChallengInt[40] == 3
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[41],UnitAPOfPlayer)
            UnitAddItem(Pu[1],CreateItem('IZ00',GetUnitX(Pu[1]),GetUnitY(Pu[1])))
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功夺回箭书！！！",0)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往姜子牙交换箭书|r",0)
        endif
    endfunction

    function EnRctGameChalleng_4_JZYTimerEnd(int id)
        int pid = id
        int num = 0
        real x = 0
        real y = 0
        int a = 0 
        int b = 0
        num = GetCanUsesGameChallengUnitID(pid)
        if  num != 0
            a = num
            x = -1152
            y = -800
            CreateUsesGameChallengUnitExOfAng(pid,num,'uf40',x,y,180)
            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
            SetUnitAnimation(GameChallengUnit[num],"attack")
            Sdofplayer(Player(pid),x,y,3)
        endif
        num = GetCanUsesGameChallengUnitID(pid)
        if  num != 0
            b = num
            x = -1152
            y = -1024
            CreateUsesGameChallengUnitExOfAng(pid,num,'uf41',x,y,180)
            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
            SetUnitAnimation(GameChallengUnit[num],"attack")
            Sdofplayer(Player(pid),x,y,3)
        endif
        TimerStart(1,false)
        {
            if  IsPlayerInChallenge == true
                SetUnitOwner(GameChallengUnit[a],Player(pid+4),true)
                SetUnitColor(GameChallengUnit[a],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                IssuePointOrderById(GameChallengUnit[a],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengUnit[b],Player(pid+4),true)
                SetUnitColor(GameChallengUnit[b],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                IssuePointOrderById(GameChallengUnit[b],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","击杀陈九公和姚少司，夺回箭书。",0)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀陈九公和姚少司，夺回箭书|r",0)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_4_JZYTimer(int id)
        int pid = id
        real x0 = -2342
        real y0 = -912
        real x1 = -2342
        real y1 = -912
        real x2 = -1152
        real y2 = -800
        real x3 = -1152
        real y3 = -1024
        real ang1 = Atan2(y2-y0,x2-x0)
        real ang2 = Atan2(y3-y1,x3-x1)
        unit u1 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e00C',-2342,-912,ang1/0.01745)
        unit u2 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e00C',-2342,-912,ang2/0.01745)
        real xx1 = 30*Cos(ang1)
        real yy1 = 30*Sin(ang1)
        real xx2 = 30*Cos(ang2)
        real yy2 = 30*Sin(ang2)
        int time = R2I(Pdis(x0,y0,x2,y2)/30)
        TimerStart(0.03,true)
        {
            time = time - 1
            if  time > 0 and IsPlayerInChallenge == true
                x0 = x0 + xx1
                y0 = y0 + yy1
                x1 = x1 + xx2
                y1 = y1 + yy2
                SetUnitPosition(u1,x0,y0)
                SetUnitPosition(u2,x1,y1)
            else
                KillUnit(u1)
                KillUnit(u2)
                EnRctGameChalleng_4_JZYTimerEnd(pid)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_4_ReTimer2(int id)
        int pid = id
        TimerStart(1,false)
        {   
            if  IsPlayerInChallenge == true
                GameChallenge_4Flush(pid,1)
                IsFinshChallenge(4) = true
                //奖励
                PlayerFinishPlotEx(pid,4)
                if  AttackUnitWN <= 12
                    for num = 1,3
                        UnitAddItemEx(Pu[1],'IN19')
                    end
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,20000)
                    AddPlayerTechResearched(Player(pid),'KM23',1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"达成|cffffcc00“智勇双全”|r成就，奖励3个"+GetObjectName('IN19')+"和20000金币！") 
                endif
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_4_ReTimer(int id)
        int pid = id
        real x0 = -2342
        real y0 = -912
        real x2 = -32
        real y2 = -960
        real ang1 = Atan2(y2-y0,x2-x0)
        unit u1 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e00C',-2342,-912,ang1/0.01745)
        real xx1 = 30*Cos(ang1)
        real yy1 = 30*Sin(ang1)
        int time = R2I(Pdis(x0,y0,x2,y2)/30)
        TimerStart(0.02,true)
        {
            time = time - 1
            if  time > 0 and IsPlayerInChallenge == true
                x0 = x0 + xx1
                y0 = y0 + yy1
                SetUnitPosition(u1,x0,y0)
            else
                KillUnit(u1)
                if  GameChallengInt[40] == 4
                    SetUnitAnimation(GameChallengUnit[43],"death")
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","赵公明死亡！！！",0)
                    EnRctGameChalleng_4_ReTimer2(pid)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_4_JZY()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1] or u1 == Pu[2]
                if  IsFinshChallenge(4) == false and IsPlayerInChallenge == true
                    if  GameChallengInt[40] == 0 
                        SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","我刚才正施法，只见一声响，便不见了箭书。你快去抢回来！",0)
                        GameChallengInt[40] = 1
                        SetUnitVertexColor(GameChallengUnit[41],255,255,255,0)
                        EnRctGameChalleng_4_JZYTimer(pid)
                    elseif  GameChallengInt[40] == 3 and UnitHasItemOfTypeReNum(Pu[1],'IZ00') >= 0
                        GameChallengInt[40] = 4
                        RemoveItem(UnitItemInSlot(Pu[1],UnitHasItemOfTypeReNum(Pu[1],'IZ00')))
                        SetUnitVertexColor(GameChallengUnit[41],255,255,255,0)
                        SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","智勇双全，奇功万古！赵公明定绝今日！",0)
                        EnRctGameChalleng_4_ReTimer(pid)
                    endif
                endif
            endif
        endif
        flush locals
    endfunction

    function GameChalleng_4_Zhen_9(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = -2176+928+832
        y = -128+1600
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = -256
                        y = 1632
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf50',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                        SetPlayerTaskUIChatOfPlayer(pid,"魔化杨戬","我是谁？我在哪？我要到哪去？",0)
                    endif
                elseif  time == 2
                    SetUnitOwner(GameChallengUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","突破第九阵。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff突破第九阵|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_4_Zhen_8(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        int cos = 15
        x = -2176+928
        y = -128+1600
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    for k = 1,cos
                        num = GetCanUsesGameChallengUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x = -1088
                            y = 1632
                            CreateUsesGameChallengUnitExOfAng(pid,num,'uf49',x,y,270)
                            SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengUnit[num],"attack")
                        endif
                    end
                elseif  time == 2
                    for k = 1,cos
                        SetUnitOwner(GameChallengUnit[unitcos[k]],Player(pid+4),true)
                        SetUnitColor(GameChallengUnit[unitcos[k]],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                        IssuePointOrderById(GameChallengUnit[unitcos[k]],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    end
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","突破第八阵。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff突破第八阵|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_4_Zhen_7(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = -2176
        y = -128+1600
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = -2016
                        y = 1632
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf48',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    SetUnitOwner(GameChallengUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","突破第七阵。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff突破第七阵|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_4_Zhen_6(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        int cos = 12
        x = -2176+928+832
        y = -128+800
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    for k = 1,cos
                        num = GetCanUsesGameChallengUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x = -256
                            y = 800
                            CreateUsesGameChallengUnitExOfAng(pid,num,'uf47',x,y,270)
                            SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengUnit[num],"attack")
                        endif
                    end
                elseif  time == 2
                    for k = 1,cos
                        SetUnitOwner(GameChallengUnit[unitcos[k]],Player(pid+4),true)
                        SetUnitColor(GameChallengUnit[unitcos[k]],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                        IssuePointOrderById(GameChallengUnit[unitcos[k]],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    end
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","突破第六阵。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff突破第六阵|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_4_Zhen_5(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = -2176+928
        y = -128+800
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = -1088
                        y = 800
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf46',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    SetUnitOwner(GameChallengUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","突破第五阵。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff突破第五阵|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_4_Zhen_4(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        int cos = 9
        x = -2176
        y = -128+800
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    for k = 1,cos
                        num = GetCanUsesGameChallengUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x = -2016
                            y = 800
                            CreateUsesGameChallengUnitExOfAng(pid,num,'uf45',x,y,270)
                            SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengUnit[num],"attack")
                        endif
                    end
                elseif  time == 2
                    for k = 1,cos
                        SetUnitOwner(GameChallengUnit[unitcos[k]],Player(pid+4),true)
                        SetUnitColor(GameChallengUnit[unitcos[k]],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                        IssuePointOrderById(GameChallengUnit[unitcos[k]],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    end
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","突破第四阵。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff突破第四阵|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_4_Zhen_3(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        x = -2176+928+832
        y = -128
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = -256
                        y = 32
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf44',x,y,270)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                        UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengUnit[num],"attack")
                    endif
                elseif  time == 2
                    SetUnitOwner(GameChallengUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","突破第三阵。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff突破第三阵|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_4_Zhen_2(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        int cos = 6
        x = -2176+928
        y = -128
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    for k = 1,cos
                        num = GetCanUsesGameChallengUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x = -1088
                            y = 32
                            CreateUsesGameChallengUnitExOfAng(pid,num,'uf43',x,y,270)
                            SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengUnit[num],"attack")
                        endif
                    end
                elseif  time == 2
                    for k = 1,cos
                        SetUnitOwner(GameChallengUnit[unitcos[k]],Player(pid+4),true)
                        SetUnitColor(GameChallengUnit[unitcos[k]],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                        IssuePointOrderById(GameChallengUnit[unitcos[k]],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    end
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","突破第二阵。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff突破第二阵|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_4_Zhen_1(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        int cos = 3
        x = -2176
        y = -128
        SendPlayerUnitTimer(pid,x,y)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    for k = 1,cos
                        num = GetCanUsesGameChallengUnitID(pid)
                        if  num != 0
                            unitcos[k] = num
                            x = -2016
                            y = 32
                            CreateUsesGameChallengUnitExOfAng(pid,num,'uf42',x,y,270)
                            SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                            UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                            UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                            SetUnitAnimation(GameChallengUnit[num],"attack")
                        endif
                    end
                elseif  time == 2
                    for k = 1,cos
                        SetUnitOwner(GameChallengUnit[unitcos[k]],Player(pid+4),true)
                        SetUnitColor(GameChallengUnit[unitcos[k]],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                        IssuePointOrderById(GameChallengUnit[unitcos[k]],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    end
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","突破第一阵。",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff突破第一阵|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_4_Zhen_End(int id)
        int pid = id
        TimerStart(1,false)
        {
            if  IsPlayerInChallenge == true
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","九曲黄河阵已破！！！",0)
                if  GameChallengOperaWay[4] == 0
                    if  GetGameChallengOperaSelsect() == 0
                        GameChallengOperaWay[4] = 1
                        SetLeagueUnit(4,true)
                        SetPlayerTaskUIChatOfPlayer(pid,"杨戬","方才走神，不想被魔气趁机入体，谢道兄搭救。",1)
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-九曲黄河阵]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00杨戬加入己方阵营！|r")   
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-九曲黄河阵]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00杨戬加入己方阵营！|r") 
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-九曲黄河阵]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00杨戬加入己方阵营！|r")                                
                    else
                        GameChallengOperaWay[4] = 2
                        SetLeagueUnit(4,false)
                        SetPlayerTaskUIChatOfPlayer(pid,"杨戬","你给不了我答案。",1)
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-九曲黄河阵]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000杨戬加入敌方阵营！|r")   
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-九曲黄河阵]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000杨戬加入敌方阵营！|r") 
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-九曲黄河阵]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000杨戬加入敌方阵营！|r") 
                    endif
                endif
                GameChallenge_4Flush(pid,2)
                PlayerChallengeCosNum = PlayerChallengeCosNum + 1
                //奖励
                PlayerFinishPlotEx(pid,4)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction
    
    function GameChalleng_4_Zhen_Death(int pid,unit u2)
        int uid = GetUnitTypeId(u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        if  uid == 'uf42'
            GameChallengInt[40] = GameChallengInt[40] + 1
            if  GameChallengInt[40] == 4
                GameChallengInt[40] = 1
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功突破第一阵！！！",0)
                GameChalleng_4_Zhen_2(pid)
            endif
        elseif  uid == 'uf43'
            GameChallengInt[40] = GameChallengInt[40] + 1
            if  GameChallengInt[40] == 7
                GameChallengInt[40] = 1
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功突破第二阵！！！",0)
                GameChalleng_4_Zhen_3(pid)
            endif
        elseif  uid == 'uf44'
            if  GameChallengInt[40] == 1
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功突破第三阵！！！",0)
                GameChalleng_4_Zhen_4(pid)
            endif
        elseif  uid == 'uf45'
            GameChallengInt[40] = GameChallengInt[40] + 1
            if  GameChallengInt[40] == 10
                GameChallengInt[40] = 1
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功突破第四阵！！！",0)
                GameChalleng_4_Zhen_5(pid)
            endif
        elseif  uid == 'uf46'
            if  GameChallengInt[40] == 1
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功突破第五阵！！！",0)
                GameChalleng_4_Zhen_6(pid)   
            endif
        elseif  uid == 'uf47'
            GameChallengInt[40] = GameChallengInt[40] + 1
            if  GameChallengInt[40] == 13
                GameChallengInt[40] = 1
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功突破第六阵！！！",0)
                GameChalleng_4_Zhen_7(pid)
            endif  
        elseif  uid == 'uf48'
            if  GameChallengInt[40] == 1
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功突破第七阵！！！",0)
                GameChalleng_4_Zhen_8(pid)   
            endif
        elseif  uid == 'uf49'
            GameChallengInt[40] = GameChallengInt[40] + 1
            if  GameChallengInt[40] == 16
                GameChallengInt[40] = 1
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功突破第八阵！！！",0)
                GameChalleng_4_Zhen_9(pid)
            endif
        elseif  uid == 'uf50'
            if  GameChallengInt[40] == 1
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功突破第九阵！！！",0)
                GameChalleng_4_Zhen_End(pid)
            endif
        endif
    endfunction

    function EnRctGameChalleng_4_ZGM()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  IsPlayerInChallenge == true and GameChallengInt[40] == 0 
                    GameChallengInt[40] = 1
                    SetUnitVertexColor(GameChallengUnit[47],255,255,255,0)
                    SetPlayerTaskUIChatOfPlayer(pid,"云霄娘娘","既杀吾兄赵公明，便看你等能破得此阵不！",0)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff突破九曲黄河阵|r",0)
                    GameChalleng_4_Zhen_1(pid)
                endif
            endif
        endif
    endfunction

    function InitGameChallenge_4()
    
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[40] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-2342,-960,0)
                SetUnitVertexColor(GameChallengUnit[40],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[40],0x01)
                GameChallengUnit[41] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',-2342,-960,0)
                SetUnitVertexColor(GameChallengUnit[41],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[41],0x01)
                GameChallengUnit[42] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np15',-2336,-832,0)
                SetUnitVertexColor(GameChallengUnit[42],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[42],0x01)
                GameChallengUnit[43] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np23',-32,-960,180)
                SetUnitVertexColor(GameChallengUnit[43],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[43],0x01)
                GameChallengUnit[44] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np24',-256,-768,270)
                SetUnitVertexColor(GameChallengUnit[44],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[44],0x01)
                GameChallengUnit[45] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np24',192,-768,270)
                SetUnitVertexColor(GameChallengUnit[45],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[45],0x01)
                GameChallengUnit[46] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np24',-32,-640,270)
                SetUnitVertexColor(GameChallengUnit[46],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[46],0x01)

                GameChallengUnit[47] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',-32,-960,0)
                SetUnitVertexColor(GameChallengUnit[47],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[47],0x01)

            endif
        end

        CreateTrigUnitInRange(-2342,-960,150,function EnRctGameChalleng_4_JZY)
        CreateTrigUnitInRange(-32,-960,150,function EnRctGameChalleng_4_ZGM)

    endfunction

endlibrary
