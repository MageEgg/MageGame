library GameChallenge3 uses GameChallengeBase

    function GameChallenge_3Flush(int pid,real time)
        for num = 0,3
            SetUnitVertexColor(GameChallengUnit[30+num],255,255,255,0)
        end
        GameChallengInt[30] = 0
        if  GameChallengUnit[39] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[39]))
            RemoveUnit(GameChallengUnit[39])
            GameChallengUnit[39] = null
        endif
        GameChallenge_GlobalFlush(pid,time)
    endfunction

    function GameChalleng_3_SMJDeath(int pid,unit u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        GameChallengInt[30] = GameChallengInt[30] + 1
        if  GameChallengInt[30] == 4
            GameChallengInt[30] = 0
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功击败破魔家四将！！！",0)
            if  GameChallengOperaWay[3] == 0
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengOperaWay[3] = 1
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","自此一战，黄天化心性收敛，知进退，明时务。",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00黄天化加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00黄天化加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00黄天化加入己方阵营！|r")                                
                else
                    GameChallengOperaWay[3] = 2
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","黄天化心性草率，后于金鸡岭战败，被孔宣收服。",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000黄天化加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000黄天化加入敌方阵营！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-破魔家四将]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000黄天化加入敌方阵营！|r")
                endif
            endif
            GameChallenge_3Flush(pid,2)
            PlayerChallengeCosNum(3) = PlayerChallengeCosNum(3) + 1
            //奖励
            PlayerFinishPlotEx(pid,3)
        endif
    endfunction

    function OpenCreateOperaTextSMJ(int id)
        int pid = id
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[32],UnitAPOfPlayer)
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[33],UnitAPOfPlayer) 
        UnitAddEffectOfGameChalleng(GameChallengUnit[32])
        GameChallengUnit[39] = CreateUnit(Player(9),'np12',-5472,8064,180)
        ShowUnitOfOnlyPlayer(pid,GameChallengUnit[39],UnitAPOfPlayer)
        UnitAddEffectOfGameChalleng(GameChallengUnit[39])
        UnitAddAbility(GameChallengUnit[39],'AZ99')
        SetUnitAbilityLevel(GameChallengUnit[39],'AZ99',pid+1)
        UnitAddEffectOfGameChalleng(GameChallengUnit[39])
        IssuePointOrderById(GameChallengUnit[39],851983,GetUnitX(GameChallengUnit[32]),GetUnitY(GameChallengUnit[32]))
        SetPlayerTaskUIChatOfPlayer(pid,"黄天化","弟子为什么在这里？",0)
        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随黄天化|r",0)
        TimerStart(1,true)
        {
            if  IsPlayerInChallenge == true
                SetPlayerTaskUIChatOfPlayer(pid,"道德真君","好畜生！若不是看在子牙面上，决不救你！",0)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_3(int pid,int ty)
        real x = 0
        real y = 0
        GameChallenge_3Flush(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        if  ty == 0
            x = -6432
            y = 6752
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 3
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            SetPlayerTaskUIChatOfPlayer(pid,"任务","前往黄天化！",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往黄天化|r",0.3)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[30],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[31],UnitAPOfPlayer)
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
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        SetPlayerTaskUIChatOfPlayer(pid,"白云童子","紫阳洞道德真君命弟子，来背师兄黄天化回山。",0)
        GameChallenge_3Flush(pid,2)
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
        SetUnitFacing(GameChallengUnit[39],270)
        TimerStart(0.5,true)
        {
            if  time < 4 and IsPlayerInChallenge == true
                time = time + 1
                num = GetCanUsesGameChallengUnitID(pid)
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
                    CreateUsesGameChallengUnitExOfAng(pid,num,'uf30'+time,x,y,ang)
                    SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
                    UnitAddEffectOfGameChalleng(GameChallengUnit[num])
                    UnitAddEffectSetSize(GameChallengUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitAnimation(GameChallengUnit[num],"attack")
                endif
            else
                SetUnitXY(GameChallengUnit[39],-3776,6880)
                UnitAddEffectOfGameChalleng(GameChallengUnit[39])
                SetUnitOwner(GameChallengUnit[a],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[a],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengUnit[b],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[b],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengUnit[c],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[c],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetUnitOwner(GameChallengUnit[d],Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
                IssuePointOrderById(GameChallengUnit[d],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀四魔将|r",0)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SMJJumpTimer2Func(unit wu,real r1,real r2)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1
        real y2 = r2
        real ang = Atan2(y2-y1,x2-x1)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        SetUnitFacing(u1,ang/0.01745)
        LocAddEffectSetSize(x1,y1,"effect_blue-guagnzhu-special.mdx",1)
        SetUnitVertexColor(u1,255,255,255,0)
        TimerStart(0.03,true)
        {
            int pid = GetUnitAbilityLevel(u1,'AZ99')-1
            time = time - 1
            if  time > 0 and IsPlayerInChallenge == true
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitFacing(u1,ang/0.01745)
                SetUnitPosition(u1,x1,y1)
                SetUnitAnimation(u1,"walk")
                //if  ModuloInteger(time,2) == 0
                    LocAddEffectSetSize(x1,y1,"effect_blue-blink2.mdx",2)
                //endif
            else
                LocAddEffectSetSize(x1,y1,"effect_blue-chuansong.mdx",1)
                ShowUnitOfOnlyPlayer(pid,u1,UnitAPOfPlayer)
                OpenGameChallenge_3_SMJTimer(pid)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SMJJumpTimer2(unit wu)
        unit u1 = wu
        int pid = GetUnitAbilityLevel(u1,'AZ99')-1
        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随黄天化|r",0)
        TimerStart(0.5,false)
        {
            if  IsPlayerInChallenge == true
                SMJJumpTimer2Func(u1,-4128,6600)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SMJJumpTimer1(unit wu,real r1,real r2)
        unit u1 = wu
        real x1 = GetUnitX(u1)
        real y1 = GetUnitY(u1)
        real x2 = r1
        real y2 = r2
        real ang = Atan2(y2-y1,x2-x1)
        real xx = 30*Cos(ang)
        real yy = 30*Sin(ang)
        int time = R2I(Pdis(x1,y1,x2,y2)/30)
        SetUnitFacing(u1,ang/0.01745)
        LocAddEffectSetSize(x1,y1,"effect_blue-guagnzhu-special.mdx",1)
        SetUnitVertexColor(u1,255,255,255,0)
        TimerStart(0.03,true)
        {
            int pid = GetUnitAbilityLevel(u1,'AZ99')-1
            time = time - 1
            if  time > 0 and IsPlayerInChallenge == true
                x1 = x1 + xx
                y1 = y1 + yy
                SetUnitFacing(u1,ang/0.01745)
                SetUnitPosition(u1,x1,y1)
                SetUnitAnimation(u1,"walk")
                //if  ModuloInteger(time,2) == 0
                    LocAddEffectSetSize(x1,y1,"effect_blue-blink2.mdx",2)
                //endif
            else
                LocAddEffectSetSize(x1,y1,"effect_blue-chuansong.mdx",1)
                ShowUnitOfOnlyPlayer(pid,u1,UnitAPOfPlayer)
                SMJJumpTimer2(u1)
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
            if  u1 == GameChallengUnit[39]
                SetUnitVertexColor(GameChallengUnit[33],255,255,255,0)
                SetPlayerTaskUIChatOfPlayer(pid,"道德真君","你速往西岐，再会魔家四将，可成大功！",0)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随黄天化|r",0)
                SMJJumpTimer1(u1,-4320,7648)
            endif
        endif
        flush locals
    endfunction

    function InitGameChallenge_3()
        trigger tig = null
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[30] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np09',-5824,6464,270)
                SetUnitVertexColor(GameChallengUnit[30],255,255,255,0)
                GameChallengUnit[31] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-5824,6464,0)
                SetUnitVertexColor(GameChallengUnit[31],255,255,255,0)

                GameChallengUnit[32] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np13',-5952,8064,0)
                SetUnitVertexColor(GameChallengUnit[32],255,255,255,0)
                GameChallengUnit[33] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-5952,8064,0)
                SetUnitVertexColor(GameChallengUnit[33],255,255,255,0)
            endif
        end

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[30],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_3_HTH)

        tig = CreateTrigger() //
        for pid = 0,3
            if  IsPlaying(pid) == true
                TriggerRegisterUnitInRange(tig,GameChallengUnit[32],150,null)
            endif
        end
        TriggerAddAction(tig, function EnRctGameChalleng_3_SMJ)

        tig = null
    endfunction

endlibrary


