library GameChallenge2 uses GameChallengeBase
    
    function GameChallenge_2Flush(int pid)
        SetUnitVertexColor(GameChallengUnit[22],255,255,255,0)
        if  GameChallengUnit[29] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[29]))
            RemoveUnit(GameChallengUnit[29])
            GameChallengUnit[29] = null
        endif
        GameChallengInt[20] = 0
        GameChallengCanUsesUnitFlush(pid)
        ShowUnitOfAllPlayer(Pu[1])
        RemoveUnit(PlayerInChallengeShowUnit)
        PlayerInChallengeShowUnit = null
        PlayerInChallengeNumber = 0
        IsPlayerInChallenge = false
    endfunction

    function GameChalleng_2_WaterDeath3(int pid,unit u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        GameChallengInt[20] = GameChallengInt[20] + 1
        if  GameChallengInt[20] == 4
            GameChallengInt[20] = 0
            if  GameChallengOperaWay[2] == 0
                if  GetRandomInt(0,1) == 0
                    GameChallengOperaWay[2] = 1
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[哪吒]：|r一人做事一人当，岂有连累父母之理！今我削肉剔骨，不累双亲。")
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[剧情]：|r后太乙真人以莲花化身复活哪吒，并化去哪吒杀性。")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00哪吒加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00哪吒加入己方阵营！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00哪吒加入己方阵营！|r")                                   
                else
                    GameChallengOperaWay[2] = 2
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[李靖]：|r住手！你这孽障！造事多端，还嫌害得我不够么？！")
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[哪吒]：|r哼！你们多次无故欺压于我，不打一顿是不知道小爷厉害的！既如此待薄厌恶，小爷也不再奉陪！")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000哪吒加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000哪吒加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000哪吒加入敌方阵营！|r")   
                endif
            endif
            GameChallenge_2Flush(pid)
            //奖励
            PlayerFinishPlot(pid,2)
        endif
    endfunction

    function OpenGameChallenge_2_BTimer(int id)
        int pid = id
        int num = 0
        int a = 0
        int b = 0
        int c = 0
        int d = 0
        real x = 0
        real y = 0 
        real ang = 0
        int time = 0
        TimerStart(0.5,true)
        {
            if  time < 4
                time = time + 1
                num = GetCanUsesGameChallengUnitID(pid)
                if  num != 0
                    if  time == 1
                        a = num
                        x = -3968
                        y = 3552
                    elseif  time == 2
                        b = num
                        x = -4320
                        y = 3424
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[敖广]：|r李靖，你生出此等恶子！")
                    elseif  time == 3
                        c = num
                        x = -4608
                        y = 3136
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[敖广]：|r我儿乃一方正神，夜叉李艮亦御笔点差，却被你父子无故打死！")
                    elseif  time == 4
                        d = num
                        x = -4768
                        y = 2816
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[敖广]：|r我等已奏明玉帝，捉拿你夫妇问罪！")
                    endif
                    ang = Atan2(GetUnitY(GameChallengUnit[19])-y,GetUnitX(GameChallengUnit[19])-x)/0.01745
                    CreateUsesGameChallengUnitExOfAng(pid,num,'uf23',x,y,ang)
                    UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                    UnitAddEffect(GameChallengUnit[num],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    SetUnitAnimation(GameChallengUnit[num],"attack")
                endif
            else
                SetUnitOwner(GameChallengUnit[a],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[a],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengUnit[b],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[b],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengUnit[c],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[c],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengUnit[d],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[d],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff击败四海龙王|r")
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_2(int pid,int ty)
        real x = 0
        real y = 0
        if  ty == 0
            x = -5664
            y = 2496
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 2
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            GameChallengUnit[29] = CreateUnit(Player(9),'np21',GetUnitX(Pu[1]),GetUnitY(Pu[1]),270)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[29],UnitAPOfPlayer)
            UnitAddAbility(GameChallengUnit[29],'AZ99')
            SetUnitAbilityLevel(GameChallengUnit[29],'AZ99',pid+1)
            UnitAddEffectOfGameChalleng(GameChallengUnit[29])
            IssuePointOrderById(GameChallengUnit[29],851983,GetUnitX(GameChallengUnit[20]),GetUnitY(GameChallengUnit[20]))
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[任务目标]：|r|cff00ffff跟随哪吒|r")
        elseif  ty == 1
            x = -4128
            y = 2912
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 2
            SendPlayerUnit(pid,x+150,y)
            ShowHeroGetTask(pid)
            GameChallengUnit[29] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np21',x,y,135)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[29],UnitAPOfPlayer)
            UnitAddAbility(GameChallengUnit[29],'AZ99')
            SetUnitAbilityLevel(GameChallengUnit[29],'AZ99',pid+1)
            UnitAddEffectOfGameChalleng(GameChallengUnit[29])
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[22],UnitAPOfPlayer)
            UnitAddEffectOfGameChalleng(GameChallengUnit[22])
            OpenGameChallenge_2_BTimer(pid)
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
                    CreateUsesGameChallengUnit(pid,num,'uf21',x,y)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    UnitAddEffect(GameChallengUnit[num],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    UnitAddEffect(Pu[1],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    Sdofplayer(Player(pid),x,y,3)
                endif
                for n = 1,4
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = GetUnitX(GameChallengUnit[20])+GetRandomReal(-380,380)
                        y = GetUnitY(GameChallengUnit[20])+GetRandomReal(-380,380)
                        CreateUsesGameChallengUnit(pid,num,'uf20',x,y)
                        IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                        UnitAddEffect(GameChallengUnit[num],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    endif
                end
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
                    CreateUsesGameChallengUnit(pid,num,'uf22',x,y)
                    IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    UnitAddEffect(GameChallengUnit[num],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    UnitAddEffect(Pu[1],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    Sdofplayer(Player(pid),x,y,3)
                endif
                for n = 1,4
                    num = GetCanUsesGameChallengUnitID(pid)
                    if  num != 0
                        x = GetUnitX(GameChallengUnit[21])+GetRandomReal(-380,380)
                        y = GetUnitY(GameChallengUnit[21])+GetRandomReal(-380,380)
                        CreateUsesGameChallengUnit(pid,num,'uf20',x,y)
                        IssuePointOrderById(GameChallengUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                        UnitAddEffect(GameChallengUnit[num],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    endif
                end
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

                GameChallengUnit[22] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np22',-3712,2880,180)
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


