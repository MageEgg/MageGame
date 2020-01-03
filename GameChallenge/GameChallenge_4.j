library GameChallenge4 uses GameChallengeBase

    function GameChallenge_4Flush(int pid)
        for num = 0,5
            SetUnitVertexColor(GameChallengUnit[40+num],255,255,255,0)
        end
        for num = 0,6
            GameChallengInt[40+num] = 0
        end
        SetUnitAnimation(GameChallengUnit[43],"stand")
        if  GameChallengUnit[49] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[49]))
            RemoveUnit(GameChallengUnit[49])
            GameChallengUnit[49] = null
        endif
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        IsPlayerInChallenge = false
    endfunction

    function OpenGameChallenge_4(int pid,int ty)
        real x = 0
        real y = 0
        GameChallenge_4Flush(pid)
        if  ty == 0
            x = -1728
            y = -896
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 4
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r天仙赵公明助闻太师攻打西岐，神秘大能-陆压传子牙“钉头七箭书”应对。")
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往姜子牙|r")
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[40],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[41],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[42],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[43],UnitAPOfPlayer)
        elseif  ty == 1
            x = -4544
            y = 896
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 1
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往文王姬昌|r")
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[14],0)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[15],0)
        endif
    endfunction

    function GameChalleng_4_DeathA(int pid,unit u2)
        BJDebugMsg("GameChalleng_4_DeathA")
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        GameChallengInt[40] = GameChallengInt[40] + 1
        if  GameChallengInt[40] == 3
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[41],UnitAPOfPlayer)
            UnitAddItemEx(Pu[1],'IZ00')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r成功夺回箭书！！！")
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往姜子牙交换箭书|r")
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
                SetUnitOwner(GameChallengUnit[a],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[a],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengUnit[b],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[b],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀击杀陈九公和姚少司，夺回箭书|r")
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
            GameChallenge_4Flush(pid)
            IsFinshChallenge(4) = true
            //奖励
            PlayerFinishPlotEx(pid,4)
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
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r赵公明死亡！")
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
            if  u1 == Pu[1]
                if  IsFinshChallenge(4) == false and IsPlayerInChallenge == true
                    if  GameChallengInt[40] == 0 
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[姜子牙]：|r我刚才正施法，只见一声响，便不见了箭书。你快去抢回来！")
                        GameChallengInt[40] = 1
                        SetUnitVertexColor(GameChallengUnit[41],255,255,255,0)
                        EnRctGameChalleng_4_JZYTimer(pid)
                    elseif  GameChallengInt[40] == 3 and UnitHasItemOfTypeReNum(Pu[1],'IZ00') >= 0
                        GameChallengInt[40] = 4
                        RemoveItem(UnitItemInSlot(Pu[1],UnitHasItemOfTypeReNum(Pu[1],'IZ00')))
                        SetUnitVertexColor(GameChallengUnit[41],255,255,255,0)
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[姜子牙]：|r智勇双全，奇功万古！赵公明定绝今日！")
                        EnRctGameChalleng_4_ReTimer(pid)
                    endif
                endif
            endif
        endif
        flush locals
    endfunction

    function InitGameChallenge_4()
        trigger tig = null
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[40] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-2342,-960,0)
                SetUnitVertexColor(GameChallengUnit[40],255,255,255,0)
                GameChallengUnit[41] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-2342,-960,0)
                SetUnitVertexColor(GameChallengUnit[41],255,255,255,0)
                GameChallengUnit[42] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np15',-2336,-832,0)
                SetUnitVertexColor(GameChallengUnit[42],255,255,255,0)

                GameChallengUnit[43] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np23',-32,-960,180)
                SetUnitVertexColor(GameChallengUnit[43],255,255,255,0)
                GameChallengUnit[44] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np24',-256,-768,270)
                SetUnitVertexColor(GameChallengUnit[44],255,255,255,0)
                GameChallengUnit[45] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np24',192,-768,270)
                SetUnitVertexColor(GameChallengUnit[45],255,255,255,0)
                GameChallengUnit[46] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np24',-32,-640,270)
                SetUnitVertexColor(GameChallengUnit[46],255,255,255,0)

            endif
        end

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[40],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_4_JZY)


        tig = null
    endfunction

endlibrary
