library GameChallenge2 uses GameChallengeBase
    
    function GameChallenge_2Flush(int pid,real time)
        SetUnitVertexColor(GameChallengUnit[22],255,255,255,0)
        if  GameChallengUnit[29] != null
            FlushChildHashtable(ht,GetHandleId(GameChallengUnit[29]))
            RemoveUnit(GameChallengUnit[29])
            GameChallengUnit[29] = null
        endif
        GameChallengInt[20] = 0
        if  GetUnitAbilityLevel(Pu[1],'AZ04') > 0
            UnitRemoveAbility(Pu[1],'AZ04')
        endif
        GameChallenge_GlobalFlush(pid,time)
    endfunction

    function GameChalleng_2_WaterDeath3(int pid,unit u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        GameChallengInt[20] = GameChallengInt[20] + 1
        if  GameChallengInt[20] == 4
            GameChallengInt[20] = 0
            if  GameChallengOperaWay[2] == 0
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengOperaWay[2] = 1
                    SetLeagueUnit(2,true)
                    SetPlayerTaskUIChatOfPlayer(pid,"哪吒","一人做事一人当，岂有连累父母之理！今我削肉剔骨，不累双亲。",0)
                    SetPlayerTaskUIChatOfPlayer(pid,"剧情","后太乙真人以莲花化身复活哪吒，并化去哪吒杀性。",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00哪吒加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00哪吒加入己方阵营！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-哪吒闹海]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00哪吒加入己方阵营！|r")                                   
                else
                    GameChallengOperaWay[2] = 2
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
            GameChallenge_2Flush(pid,2)
            PlayerChallengeCosNum(2) = PlayerChallengeCosNum(2) + 1
            //奖励
            PlayerFinishPlotEx(pid,2)
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
                    ang = Atan2(GetUnitY(GameChallengUnit[19])-y,GetUnitX(GameChallengUnit[19])-x)/0.01745
                    CreateUsesGameChallengUnitExOfAng(pid,num,'uf22',x,y,ang)
                    SetUnitOverStateOfGameChalleng(pid,GameChallengUnit[num],2)
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
        GameChallenge_2Flush(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        if  ty == 0
            x = -5664
            y = 2496
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 2
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            UnitAddAbility(Pu[1],'AZ04')
            GameChallengUnit[29] = CreateUnit(Player(9),'np21',GetUnitX(Pu[1]),GetUnitY(Pu[1]),270)
            ShowUnitOfOnlyPlayer(pid,GameChallengUnit[29],UnitAPOfPlayer)
            UnitAddAbility(GameChallengUnit[29],'AZ99')
            SetUnitAbilityLevel(GameChallengUnit[29],'AZ99',pid+1)
            UnitAddEffectOfGameChalleng(GameChallengUnit[29])
            IssuePointOrderById(GameChallengUnit[29],851983,GetUnitX(GameChallengUnit[20]),GetUnitY(GameChallengUnit[20]))
            SetPlayerTaskUIChatOfPlayer(pid,"任务","跟随哪吒！",0.3)
            SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随哪吒|r",0.3)
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
        SetPlayerTaskUIChatOfPlayer(pid,"任务","跟随哪吒！",0)
        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随哪吒|r",0)
    endfunction

    function GameChalleng_2_WaterDeath2(int pid,unit u2)
        GameChallengUnit[R2I(GetUnitRealState(u2,99))] = null
        SetPlayerTaskUIChatOfPlayer(pid,"敖广","吾儿！！！哪吒你欺人太甚！吾自去天庭讨个说法！",0)
        GameChallenge_2Flush(pid,2)
        IsFinshChallenge(2) = true
        //奖励
        PlayerFinishPlotEx(pid,2)
        if  AttackUnitWN <= 5
            for num = 1,2
                UnitAddItemEx(Pu[1],'IN19')
            end
            AddPlayerTechResearched(Player(pid),'KM21',1)
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[系统]：|r"+GetPlayerNameOfColor(pid)+"达成|cffffcc00“熊孩子”|r成就，奖励2个"+GetObjectName('IN19')+"！") 
        endif
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
                SetUnitFaceOfUnit(u1,Pu[1])
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
            if  u1 == GameChallengUnit[29]
                x = -5184
                y = 4000
                SetUnitPositionOfGameChalleng(GameChallengUnit[29],x,y)
                IssueImmediateOrderById(u1, 851993 )
                SetUnitFaceOfUnit(u1,Pu[1])
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
                SetPlayerTaskUIChatOfPlayer(pid,"龙王三太子","好泼贼！夜叉李艮乃天王点差，你敢大胆将他打死！",0.5)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀龙王三太子|r",0)
            endif
        endif
    endfunction

    function InitGameChallenge_2()
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengUnit[20] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-6080,3072,0)
                SetUnitVertexColor(GameChallengUnit[20],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[20],0x01)
                
                GameChallengUnit[21] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',-5536,3872,0)
                SetUnitVertexColor(GameChallengUnit[21],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[21],0x01)

                GameChallengUnit[22] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np22',-3712,2880,180)
                SetUnitVertexColor(GameChallengUnit[22],255,255,255,0)
                EXSetUnitMoveType(GameChallengUnit[22],0x01)
            endif
        end

        CreateTrigUnitInRange(-6080,3072,150,function EnRctGameChalleng_2_Water1)
        CreateTrigUnitInRange(-5536,3872,150,function EnRctGameChalleng_2_Water2)
        
    endfunction

endlibrary


