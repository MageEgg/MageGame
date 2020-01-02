library GameChallenge2 uses GameChallengeBase
    
    function GameChallenge_2Flush(int pid)
        if  GameChallengUnit[29] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[29]))
            RemoveUnit(GameChallengUnit[29])
            GameChallengUnit[29] = null
        endif
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        IsPlayerInChallenge = false
    endfunction

    function OpenGameChallenge_2(int pid,int ty)
        real x = 0
        real y = 0
        if  ty == 0
            x = -5664
            y = 2496
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 1
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            GameChallengUnit[29] = CreateUnit(Player(9),'np21',GetUnitX(Pu[1]),GetUnitY(Pu[1]),270)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[29],UnitAPOfPlayer)
            UnitAddAbility(GameChallengUnit[29],'AZ99')
            SetUnitAbilityLevel(GameChallengUnit[29],'AZ99',pid+1)
            IssuePointOrderById(GameChallengUnit[29],851983,GetUnitX(GameChallengUnit[20]),GetUnitY(GameChallengUnit[20]))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff跟随哪吒|r")
        elseif  ty == 1
            x = -4544
            y = 896
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 1
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff前往文王姬昌|r")
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[14],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[15],UnitAPOfPlayer)
        endif
    endfunction

    function GameChalleng_2_WaterDeath1(int pid,unit u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        IssuePointOrderById(GameChallengUnit[29],851983,GetUnitX(GameChallengUnit[21]),GetUnitY(GameChallengUnit[21]))
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff跟随哪吒|r")
    endfunction

    function GameChalleng_2_WaterDeath2(int pid,unit u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[敖广]：|r吾儿！！！哪吒你欺人太甚！吾自去天庭讨个说法！")
        GameChallenge_2Flush(pid)
        IsFinshChallenge(2) = true
        //奖励
        PlayerFinishPlot(pid,2)
    endfunction

    function EnRctGameChalleng_2_Water1()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        int num = 0
        real x = 0
        real y = 0
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[29]
                x = -5760
                y = 3168
                SetUnitPositionOfGameChalleng(GameChallengUnit[29],x,y)
                IssueImmediateOrderById(u1, 851993 )
                num = GetCanUsesGameChallengUnitID(pid)
                if  num != 0
                    x = GetUnitX(GameChallengUnit[20])
                    y = GetUnitY(GameChallengUnit[20])
                    CreateUsesGameChallengUnit(pid,num,'uf20',x,y)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    UnitAddEffect(GameChallengUnit[num],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    UnitAddEffect(Pu[1],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    Sdofplayer(Player(pid),x,y,3)
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[巡海夜叉]：|r谁人作怪，使得龙宫摇动？！")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀巡海夜叉|r")
            endif
        endif
    endfunction

    function EnRctGameChalleng_2_Water2()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        int num = 0
        real x = 0
        real y = 0
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengUnit[29]
                x = -5184
                y = 4000
                SetUnitPositionOfGameChalleng(GameChallengUnit[29],x,y)
                IssueImmediateOrderById(u1, 851993 )
                num = GetCanUsesGameChallengUnitID(pid)
                if  num != 0
                    x = GetUnitX(GameChallengUnit[21])
                    y = GetUnitY(GameChallengUnit[21])
                    CreateUsesGameChallengUnit(pid,num,'uf21',x,y)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    UnitAddEffect(GameChallengUnit[num],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    UnitAddEffect(Pu[1],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    Sdofplayer(Player(pid),x,y,3)
                endif
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[龙王三太子]：|r好泼贼！夜叉李艮乃天王点差，你敢大胆将他打死！")
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击杀龙王三太子|r")
            endif
        endif
    endfunction

    function InitGameChallenge_2()
        trigger tig = null
        region rectRegion = null
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[20] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-6080,3072,0)
                SetUnitVertexColor(GameChallengUnit[20],255,255,255,0)
                
                GameChallengUnit[21] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-5536,3872,0)
                SetUnitVertexColor(GameChallengUnit[21],255,255,255,0)

                GameChallengUnit[22] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np22',-5536,3872,0)
                SetUnitVertexColor(GameChallengUnit[22],255,255,255,0)
            endif
        end

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[20],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_2_Water1)

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[21],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_2_Water2)

        /*tig = CreateTrigger() 
        rectRegion = CreateRegion()
        RegionAddRect(rectRegion,gg_rct_ChallengeRct_1_4)
        TriggerRegisterEnterRegion(tig,rectRegion,null)
        TriggerAddAction(tig, function FuncEnterRctChallengeRct_1_4)*/


        tig = null
        rectRegion = null
    endfunction

endlibrary


