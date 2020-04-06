library GameChallenge2 uses GameChallengeBase

    function GameChalleng_2_WaterDeath3(int pid,unit u2)
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        GameChallengeInt[20] = GameChallengeInt[20] + 1
        if  GameChallengeInt[20] == 4
            GameChallengeInt[20] = 0
            if  GameChallengeOperaWay[2] == 0
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengeOperaWay[2] = 1
                    SetLeagueUnit(2,true)
                    SetPlayerTaskUIChatOfPlayer(pid,"哪吒","一人做事一人当，岂有连累父母之理！今我削肉剔骨，不累双亲。",0)
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","后太乙真人以莲花化身复活哪吒，并化去哪吒杀性。",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00哪吒加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00哪吒加入己方阵营！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00哪吒加入己方阵营！|r")                                   
                else
                    GameChallengeOperaWay[2] = 2
                    SetLeagueUnit(2,false)
                    SetPlayerTaskUIChatOfPlayer(pid,"李靖","住手！你这孽障！造事多端，还嫌害得我不够么？！",0)
                    SetPlayerTaskUIChatOfPlayer(pid,"哪吒","哼！你们多次无故欺压于我，不打一顿是不知道小爷厉害的！既如此待薄厌恶，小爷也不再奉陪！",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000哪吒加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000哪吒加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000哪吒加入敌方阵营！|r")   
                endif
            else
                SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功击败四海龙王！！！",0)
            endif
            GameChallengeFluahAll(pid,1)
            PlayerChallengeOverCosNum = PlayerChallengeOverCosNum + 1
            PlayerChallengeTimeCosNum(2) = PlayerChallengeTimeCosNum(2) + 1
            //奖励
            PlayerFinishPlotEx(pid,2)

            if  GetUnitTypeId(Pu[1]) == 'H012' and IsFinshChallenge(2) == true  //彩蛋
                if  DzPlayerLv(Player(pid)) >= 4
                    if  GameLevel >= 2
                        if  GetPlayerTechCount(Player(pid),'RDAI',true) == 0
                            SetDzPlayerData(pid,15,9,9)
                            SetPlayerTechResearchedEx(Player(pid),'RDAI')
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000护犊子|r（永久存档）！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000护犊子|r，但可惜难度不够要求！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000护犊子|r，但可惜地图等级不够要求！")
                endif
            endif

            if  GetUnitTypeId(Pu[1]) == 'H026' //彩蛋
                if  DzPlayerLv(Player(pid)) >= 2
                    if  GetPlayerTechCount(Player(pid),'RDAK',true) == 0
                        SetDzPlayerData(pid,15,11,11)
                        SetPlayerTechResearchedEx(Player(pid),'RDAK')
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000穿越回来还打你！|r（永久存档）！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000穿越回来还打你|r，但可惜地图等级不够要求！")
                endif
            endif

            if  PlayerChallengeTimeCosNum(2) >= 3 //彩蛋
                if  DzPlayerLv(Player(pid)) >= 6
                    if  GetPlayerTechCount(Player(pid),'RDAX',true) == 0
                        SetDzPlayerData(pid,15,24,24)
                        SetPlayerTechResearchedEx(Player(pid),'RDAX')
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000龙王出来喷水|r（永久存档）！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000龙王出来喷水|r，但可惜地图等级不够要求！")
                endif
            endif
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
            if  time < 4 and IsPlayerInChallenge == true
                time = time + 1
                num = GetCanUsesGameChallengeUnitID(pid)
                if  num != 0
                    if  time == 1
                        a = num
                        x = -3968
                        y = 3552
                    elseif  time == 2
                        b = num
                        x = -4320
                        y = 3424
                        SetPlayerTaskUIChatOfPlayer(pid,"敖广","李靖，你生出此等恶子！",0)
                    elseif  time == 3
                        c = num
                        x = -4608
                        y = 3136
                        SetPlayerTaskUIChatOfPlayer(pid,"敖广","我儿乃一方正神，夜叉李艮亦御笔点差，却被你父子无故打死！",0.5)
                    elseif  time == 4
                        d = num
                        x = -4768
                        y = 2816
                        SetPlayerTaskUIChatOfPlayer(pid,"敖广","我等已奏明玉帝，捉拿你夫妇问罪！",0.5)
                    endif
                    ang = Atan2(GetUnitY(GameChallengeUnit[19])-y,GetUnitX(GameChallengeUnit[19])-x)/0.01745
                    CreateUsesGameChallengeUnitExOfAng(pid,num,'uf22',x,y,ang)
                    SetUnitOverStateOfGameChalleng(pid,GameChallengeUnit[num],2)
                    UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                    UnitAddEffect(GameChallengeUnit[num],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    SetUnitAnimation(GameChallengeUnit[num],"attack")
                endif
            else
                SetUnitOwner(GameChallengeUnit[a],Player(pid+4),true)
                SetUnitColor(GameChallengeUnit[a],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                IssuePointOrderById(GameChallengeUnit[a],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengeUnit[b],Player(pid+4),true)
                SetUnitColor(GameChallengeUnit[b],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                IssuePointOrderById(GameChallengeUnit[b],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengeUnit[c],Player(pid+4),true)
                SetUnitColor(GameChallengeUnit[c],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                IssuePointOrderById(GameChallengeUnit[c],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengeUnit[d],Player(pid+4),true)
                SetUnitColor(GameChallengeUnit[d],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                IssuePointOrderById(GameChallengeUnit[d],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击败四海龙王|r",0)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_2(int pid,int ty)
        real x = 0
        real y = 0
        GameChallengeFluahAll(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        SetPlayerAllianceVISION(pid,false)
        if  ty == 0
            x = -5664
            y = 2496
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 2
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            UnitAddAbility(Pu[1],'AZ04')
            GameChallengeUnit[29] = CreateUnit(Player(9),'np21',GetUnitX(Pu[1]),GetUnitY(Pu[1]),270)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[29],UnitAPOfPlayer)
            UnitAddAbility(GameChallengeUnit[29],'AZ99')
            SetUnitAbilityLevel(GameChallengeUnit[29],'AZ99',pid+1)
            UnitAddEffectOfGameChalleng(GameChallengeUnit[29])
            IssuePointOrderById(GameChallengeUnit[29],851983,GetUnitX(GameChallengeUnit[20]),GetUnitY(GameChallengeUnit[20]))
            SetPlayerTaskUIChatOfPlayer(pid,"任务","跟随哪吒！",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随哪吒|r",0.3)
        elseif  ty == 1
            x = -4128
            y = 2912
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 2
            SendPlayerUnit(pid,x+150,y)
            ShowHeroGetTask(pid)
            GameChallengeUnit[29] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np21',x,y,135)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[29],UnitAPOfPlayer)
            UnitAddAbility(GameChallengeUnit[29],'AZ99')
            SetUnitAbilityLevel(GameChallengeUnit[29],'AZ99',pid+1)
            UnitAddEffectOfGameChalleng(GameChallengeUnit[29])
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[22],UnitAPOfPlayer)
            UnitAddEffectOfGameChalleng(GameChallengeUnit[22])
            OpenGameChallenge_2_BTimer(pid)
        endif
    endfunction

    function GameChalleng_2_WaterDeath1(int pid,unit u2)
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        IssuePointOrderById(GameChallengeUnit[29],851983,GetUnitX(GameChallengeUnit[21]),GetUnitY(GameChallengeUnit[21]))
        SetPlayerTaskUIChatOfPlayer(pid,"任务","跟随哪吒！",0)
        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随哪吒|r",0)
    endfunction

    function GameChalleng_2_WaterDeath2(int pid,unit u2)
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        SetPlayerTaskUIChatOfPlayer(pid,"敖广","吾儿！！！哪吒你欺人太甚！吾自去天庭讨个说法！",0)
        GameChallengeFluahAll(pid,1)
        IsFinshChallenge(2) = true
        //奖励
        PlayerFinishPlotEx(pid,2)

        if  GetUnitTypeId(Pu[1]) == 'H018' //彩蛋
            if  DzPlayerLv(Player(pid)) >= 8
                if  GameLevel >= 4
                    if  GetPlayerTechCount(Player(pid),'RDAF',true) == 0
                        SetDzPlayerData(pid,15,6,6)
                        SetPlayerTechResearchedEx(Player(pid),'RDAF')
                        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000我也护犊子|r（永久存档）！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000我也护犊子|r，但可惜难度不够要求！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000我也护犊子|r，但可惜地图等级不够要求！")
            endif
        endif
    endfunction

    function EnRctGameChalleng_2_Water1()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        int num = 0
        real x = 0
        real y = 0
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengeUnit[29]
                x = -5760
                y = 3168
                SetUnitPositionOfGameChalleng(GameChallengeUnit[29],x,y)
                IssueImmediateOrderById(u1, 851993 )
                SetUnitFaceOfUnit(u1,Pu[1])
                num = GetCanUsesGameChallengeUnitID(pid)
                if  num != 0
                    x = GetUnitX(GameChallengeUnit[20])
                    y = GetUnitY(GameChallengeUnit[20])
                    CreateUsesGameChallengeUnit(pid,num,'uf20',x,y)
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    UnitAddEffect(GameChallengeUnit[num],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    UnitAddEffect(Pu[1],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    Sdofplayer(Player(pid),x,y,3)
                endif
                SetPlayerTaskUIChatOfPlayer(pid,"巡海夜叉","谁人作怪，使得龙宫摇动？！",0)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀巡海夜叉|r",0)
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
            if  u1 == GameChallengeUnit[29]
                x = -5184
                y = 4000
                SetUnitPositionOfGameChalleng(GameChallengeUnit[29],x,y)
                IssueImmediateOrderById(u1, 851993 )
                SetUnitFaceOfUnit(u1,Pu[1])
                num = GetCanUsesGameChallengeUnitID(pid)
                if  num != 0
                    x = GetUnitX(GameChallengeUnit[21])
                    y = GetUnitY(GameChallengeUnit[21])
                    CreateUsesGameChallengeUnit(pid,num,'uf21',x,y)
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    UnitAddEffect(GameChallengeUnit[num],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    UnitAddEffect(Pu[1],"Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl")
                    Sdofplayer(Player(pid),x,y,3)
                endif
                SetPlayerTaskUIChatOfPlayer(pid,"龙王三太子","好泼贼！夜叉李艮乃天王点差，你敢大胆将他打死！",0.5)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀龙王三太子|r",0)
            endif
        endif
    endfunction

    function InitGameChallenge_2()
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengeUnit[20] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-6080,3072,0)
                SetUnitVertexColor(GameChallengeUnit[20],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[20],0x01)
                
                GameChallengeUnit[21] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-5536,3872,0)
                SetUnitVertexColor(GameChallengeUnit[21],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[21],0x01)

                GameChallengeUnit[22] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np22',-3712,2880,180)
                SetUnitVertexColor(GameChallengeUnit[22],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[22],0x01)
            endif
        end

        CreateTrigUnitInRangeOfGameChallenge(-6080,3072,150,function EnRctGameChalleng_2_Water1)
        CreateTrigUnitInRangeOfGameChallenge(-5536,3872,150,function EnRctGameChalleng_2_Water2)
        
    endfunction

endlibrary


