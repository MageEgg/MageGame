library GameChallenge3 uses GameChallengeBase

    function GameChallenge_3Flush(int pid)
        for num = 0,5
            SetUnitVertexColor(GameChallengUnit[30+num],255,255,255,0)
        end
        if  GameChallengUnit[39] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[39]))
            RemoveUnit(GameChallengUnit[39])
            GameChallengUnit[39] = null
        endif
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        IsPlayerInChallenge = false
    endfunction

    function OpenGameChallenge_3(int pid,int ty)
        real x = 0
        real y = 0
        if  ty == 0
            x = -6432
            y = 6752
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 3
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往黄天化|r")
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[30],0)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[31],0)
        elseif  ty == 1
            x = -4544
            y = 896
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 3
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往黄天化|r")
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[30],0)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[31],0)
        endif
    endfunction

    function GameChalleng_3_HTHDeath(int pid,unit u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[白云童子]：|r紫阳洞道德真君命弟子，来背师兄黄天化回山。")
        GameChallenge_3Flush(pid)
        IsFinshChallenge(3) = true
        //奖励
        PlayerFinishPlotEx(pid,3)
    endfunction

    function EnRctGameChalleng_3_HTHTimer(int id,int n)
        int pid = id
        int num = n
        TimerStart(1,false)
        {
            if  IsPlayerInChallenge == true
                SetUnitOwner(GameChallengUnit[num],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[黄天化]：|r吾乃开国武成王长子，黄天化。今奉姜丞相将令，特来擒你。")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击退魔礼青|r")
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_3_HTH()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int num = 0
        real x = 0
        real y = 0
        real ang = 0
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengUnit[39] == null and IsFinshChallenge(3) == false and IsPlayerInChallenge == true
                    SetUnitVertexColor(GameChallengUnit[31],255,255,255,0)
                    x = -5280
                    y = 7104
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        ang = Atan2(GetUnitY(GameChallengUnit[30])-y,GetUnitX(GameChallengUnit[30])-x)/0.01745
                        CreateUsesGameChallengUnitExOfAng(pid,num,'uf30',x,y,ang)
                        UnitAddEffect(GameChallengUnit[num],"effect_red-yumao-zhendi-paoxiao.mdx")
                        UnitAddEffect(GameChallengUnit[num],"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdx")
                        Sdofplayer(Player(pid),x,y,5)
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[魔礼青]：|r来者何人？")
                        EnRctGameChalleng_3_HTHTimer(pid,num)
                    endif
                endif
            endif
        endif
        flush locals
    endfunction

    function InitGameChallenge_3()
        trigger tig = null
        region rectRegion = null
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[30] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np09',-5824,6464,270)
                SetUnitVertexColor(GameChallengUnit[30],255,255,255,0)
                GameChallengUnit[31] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-5824,6464,0)
                SetUnitVertexColor(GameChallengUnit[31],255,255,255,0)
            endif
        end

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[30],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_3_HTH)

        /*tig = CreateTrigger() 
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion,gg_rct_ChallengeRct_1_4)
        TriggerRegisterEnterRegion(tig,rectRegion,null)
        TriggerAddAction(tig, function FuncEnterRctChallengeRct_1_4)*/


        tig = null
        rectRegion = null
    endfunction

endlibrary


