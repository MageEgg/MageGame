library GameChallenge3 uses GameChallengeBase

    function GameChalleng_3_SMJDeath(int pid,unit u2)
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        GameChallengeInt[30] = GameChallengeInt[30] + 1
        if  GameChallengeInt[30] == 4
            GameChallengeInt[30] = 0
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功击败破魔家四将！！！",0)
            if  GameChallengeOperaWay[3] == 0
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengeOperaWay[3] = 1
                    SetLeagueUnit(3,true)
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","自此一战，黄天化心性收敛，知进退，明时务。",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00黄天化加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00黄天化加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00黄天化加入己方阵营！|r")                                
                else
                    GameChallengeOperaWay[3] = 2
                    SetLeagueUnit(3,false)
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","黄天化心性草率，后于金鸡岭战败，被孔宣收服。",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000黄天化加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000黄天化加入敌方阵营！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000黄天化加入敌方阵营！|r")
                endif
            endif
            GameChallengeFluahAll(pid,1)
            PlayerChallengeOverCosNum = PlayerChallengeOverCosNum + 1
            PlayerChallengeTimeCosNum(3) = PlayerChallengeTimeCosNum(3) + 1
            //奖励
            PlayerFinishPlotEx(pid,3)

            if  GetUnitTypeId(Pu[1]) == 'H025' //彩蛋
                if  DzPlayerLv(Player(pid)) >= 4
                    if  GameLevel >= 2
                        if  GetPlayerTechCount(Player(pid),'RDAN',true) == 0
                            SetDzPlayerData(pid,15,14,14)
                            SetPlayerTechResearchedEx(Player(pid),'RDAN')
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000报仇雪恨|r（永久存档）！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000报仇雪恨|r，但可惜难度不够要求！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000报仇雪恨|r，但可惜地图等级不够要求！")
                endif
            endif
        endif
    endfunction

    function OpenCreateOperaTextSMJ(int id)
        int pid = id
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[32],UnitAPOfPlayer)
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[33],UnitAPOfPlayer) 
        UnitAddEffectOfGameChalleng(GameChallengeUnit[32])
        GameChallengeUnit[39] = CreateUnit(Player(9),'np12',-5472,8064,180)
        ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[39],UnitAPOfPlayer)
        UnitAddEffectOfGameChalleng(GameChallengeUnit[39])
        UnitAddAbility(GameChallengeUnit[39],'AZ99')
        SetUnitAbilityLevel(GameChallengeUnit[39],'AZ99',pid+1)
        UnitAddEffectOfGameChalleng(GameChallengeUnit[39])
        IssuePointOrderById(GameChallengeUnit[39],851983,GetUnitX(GameChallengeUnit[32]),GetUnitY(GameChallengeUnit[32]))
        SetPlayerTaskUIChatOfPlayer(pid,"黄天化","弟子为什么在这里？",0)
        SetPlayerTaskUIChatOfPlayer(pid,"道德真君","好畜生！若不是看在子牙面上，决不救你！",1)
        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随黄天化|r",0)
    endfunction

    function OpenGameChallenge_3(int pid,int ty)
        real x = 0
        real y = 0
        GameChallengeFluahAll(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        SetPlayerAllianceVISION(pid,false)
        if  ty == 0
            x = -6176
            y = 6944
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 3
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            SetPlayerTaskUIChatOfPlayer(pid,"任务","前往黄天化！",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往黄天化|r",0.3)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[30],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[31],UnitAPOfPlayer)
        elseif  ty == 1
            x = -5440
            y = 8160
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 3
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            OpenCreateOperaTextSMJ(pid)
        endif
    endfunction

    function GameChalleng_3_HTHDeath(int pid,unit u2)
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        SetPlayerTaskUIChatOfPlayer(pid,"白云童子","紫阳洞道德真君命弟子，来背师兄黄天化回山。",0)
        GameChallengeFluahAll(pid,1)
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
                SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
                SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetPlayerTaskUIChatOfPlayer(pid,"黄天化","吾乃开国武成王长子，黄天化。今奉姜丞相将令，特来擒你。",0)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击退魔礼青|r",0)       
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
                if  GameChallengeUnit[39] == null and GameChallengeInt[30] == 0 and IsFinshChallenge(3) == false and IsPlayerInChallenge == true
                    SetUnitVertexColor(GameChallengeUnit[31],255,255,255,0)
                    x = -5280
                    y = 7104
                    GameChallengeInt[30] = 1
                    num = GetCanUsesGameChallengeUnitID(pid)
                    if  num != 0
                        ang = Atan2(GetUnitY(GameChallengeUnit[30])-y,GetUnitX(GameChallengeUnit[30])-x)/0.01745
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf30',x,y,ang)
                        UnitAddEffect(GameChallengeUnit[num],"effect_red-yumao-zhendi-paoxiao.mdx")
                        UnitAddEffect(GameChallengeUnit[num],"effect_by_wood_effect_d2_shadowfiend_shadowraze_1.mdx")
                        Sdofplayer(Player(pid),x,y,5)
                        SetPlayerTaskUIChatOfPlayer(pid,"魔礼青","来者何人？",0)
                        EnRctGameChalleng_3_HTHTimer(pid,num)
                    endif
                endif
            endif
        endif
        flush locals
    endfunction

    function OpenGameChallenge_3_SMJTimer(int id)
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
        SetUnitFacing(GameChallengeUnit[39],270)
        TimerStart(0.5,true)
        {
            if  time < 4 and IsPlayerInChallenge == true
                time = time + 1
                num = GetCanUsesGameChallengeUnitID(pid)
                if  num != 0
                    if  time == 1
                        a = num
                        x = -4672
                        y = 6368
                    elseif  time == 2
                        b = num
                        x = -4416
                        y = 6080
                    elseif  time == 3
                        c = num
                        x = -3936
                        y = 6080
                    elseif  time == 4
                        d = num
                        x = -3680
                        y = 6368
                        SetPlayerTaskUIChatOfPlayer(pid,"黄天化","今日定见雌雄！",0)
                    endif
                    ang = Atan2(6816-y,-4128-x)/0.01745
                    CreateUsesGameChallengeUnitExOfAng(pid,num,'uf30'+time,x,y,ang)
                    SetUnitOverStateOfGameChalleng(pid,GameChallengeUnit[num],2)
                    UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                    UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitAnimation(GameChallengeUnit[num],"attack")
                endif
            else
                SetUnitXY(GameChallengeUnit[39],-3776,6880)
                UnitAddEffectOfGameChalleng(GameChallengeUnit[39])
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
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀四魔将|r",0)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SMJJumpTimer2Func(int id,unit wu,real r1,real r2)
        int pid = id
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1
        real y2 = r2
        real ang = Atan2(y2-y1,x2-x1)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        unit u2 = CreateTmUnit(Player(pid),"Unit_FeiMa.mdl",x1,y1,ang/0.01745,0,1.5)
        ShowUnitOfOnlyPlayer(pid,u2,UnitAPOfPlayer)
        SetUnitFacing(u1,ang/0.01745)
        UnitAddAbility(u1,'Amrf')
        SetUnitFlyHeight(u1,100,0)
        UnitRemoveAbility(u1,'Amrf')
        LocAddEffectSetSize(x1,y1,"effect_white-qiquan-juhuang.mdl",1)
        SetUnitAnimation(u2,"walk")
        TimerStart(0.03,true)
        {
            time = time - 1
            if  time > 0 and IsPlayerInChallenge == true
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitPosition(u1,x1,y1)
                SetUnitPosition(u2,x1,y1)
            else
                LocAddEffectSetSize(x1,y1,"effect_white-qiquan-juhuang.mdl",1)
                SetUnitFlyHeight(u1,0,100000)
                RemoveUnit(u2)
                OpenGameChallenge_3_SMJTimer(pid)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SMJJumpTimer2(int id,unit wu)
        unit u1 = wu
        int pid = id
        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随黄天化|r",0)
        TimerStart(0.5,false)
        {
            if  IsPlayerInChallenge == true
                SMJJumpTimer2Func(pid,u1,-4128,6600)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SMJJumpTimer1(int id,unit wu,real r1,real r2)
        int pid = id
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1
        real y2 = r2
        real ang = Atan2(y2-y1,x2-x1)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        unit u2 = CreateTmUnit(Player(pid),"Unit_FeiMa.mdl",x1,y1,ang/0.01745,0,1.5)
        ShowUnitOfOnlyPlayer(pid,u2,UnitAPOfPlayer)
        SetUnitFacing(u1,ang/0.01745)
        UnitAddAbility(u1,'Amrf')
        SetUnitFlyHeight(u1,100,0)
        UnitRemoveAbility(u1,'Amrf')
        LocAddEffectSetSize(x1,y1,"effect_white-qiquan-juhuang.mdl",1)
        SetUnitAnimation(u2,"walk")
        TimerStart(0.03,true)
        {
            time = time - 1
            if  time > 0 and IsPlayerInChallenge == true
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitPosition(u1,x1,y1)
                SetUnitPosition(u2,x1,y1)
            else
                LocAddEffectSetSize(x1,y1,"effect_white-qiquan-juhuang.mdl",1)
                SetUnitFlyHeight(u1,0,100000)
                RemoveUnit(u2)
                SMJJumpTimer2(pid,u1)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_3_SMJ()
        unit u1 = GetTriggerUnit()
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == GameChallengeUnit[39]
                SetUnitVertexColor(GameChallengeUnit[33],255,255,255,0)
                SetPlayerTaskUIChatOfPlayer(pid,"道德真君","你速往西岐，再会魔家四将，可成大功！",2.5)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随黄天化|r",0)
                SMJJumpTimer1(pid,u1,-4320,7648)
            endif
        endif
        flush locals
    endfunction

    function InitGameChallenge_3()
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengeUnit[30] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np12',-5824,6464,270)
                SetUnitVertexColor(GameChallengeUnit[30],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[30],0x01)
                GameChallengeUnit[31] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',-5824,6464,0)
                SetUnitVertexColor(GameChallengeUnit[31],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[31],0x01)

                GameChallengeUnit[32] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np13',-5952,8064,0)
                SetUnitVertexColor(GameChallengeUnit[32],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[32],0x01)
                GameChallengeUnit[33] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',-5952,8064,0)
                SetUnitVertexColor(GameChallengeUnit[33],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[33],0x01)
            endif
        end

        CreateTrigUnitInRangeOfGameChallenge(-5824,6464,150,function EnRctGameChalleng_3_HTH)
        CreateTrigUnitInRangeOfGameChallenge(-5952,8064,150,function EnRctGameChalleng_3_SMJ)

    endfunction

endlibrary


