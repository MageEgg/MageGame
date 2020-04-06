library GameChallenge6 uses GameChallengeBase

    function OpenGameChallenge_6_A_ChatTimer(int id)
        int pid = id
        SetPlayerTaskUIChatOfPlayer(pid,"赤精子","贫道将一洞珍宝都给了殷洪。这孽障不知听何人唆使，中途改了念头。",0)
        TimerStart(1,false)
        {
            if  IsPlayerInChallenge == true
                SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","今殷洪背师言而助苏护征伐西岐，又有马元凶顽肆虐。我有一策可治之。",0)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff前往赤精子|r",0)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_6_B_Timer(int id)
        int pid = id
        int time = 0
        int num = 0
        real x = 0
        real y = 0
        SetPlayerTaskUIChatOfPlayer(pid,"剧情","殷郊奉命下山助西岐攻伐纣。",0)
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengeUnitID(pid)
                    if  num != 0
                        x = -1696
                        y = 8224
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf62',x,y,315)
                        SetUnitOverStateOfGameChalleng(pid,GameChallengeUnit[num],2)
                        UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                        UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengeUnit[num],"attack")
                    endif
                elseif  time == 2
                    SetPlayerTaskUIChatOfPlayer(pid,"申公豹","殷殿下，你父亲固得罪于天下，可与之为仇。但殿下弟弟，听说他下山助周，没想姜子牙欲邀功，竟用太极图把他化成灰了！",0)
                elseif  time == 3
                    SetPlayerTaskUIChatOfPlayer(pid,GetPlayerName(Player(pid)),"信口胡说！！！",0)
                elseif  time == 4
                    UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                    SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击败申公豹|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function OpenGameChallenge_6(int pid,int ty)
        real x = 0
        real y = 0
        GameChallengeFluahAll(pid,-1)
        ShowPlayerTaskUIOfPlayer(pid,true,0.01)
        SetPlayerAllianceVISION(pid,false)
        if  ty == 0
            x = -2272
            y = 6720
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 6
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[60],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[61],UnitAPOfPlayer)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[62],UnitAPOfPlayer)
            OpenGameChallenge_6_A_ChatTimer(pid)
        elseif  ty == 1
            x = -1440
            y = 7904
            IsPlayerInChallenge = true
            PlayerInChallengeNumber = 6
            SendPlayerUnit(pid,x,y)
            ShowHeroGetTask(pid)
            ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[63],UnitAPOfPlayer)
            UnitAddEffectOfGameChalleng(GameChallengeUnit[63])
            OpenGameChallenge_6_B_Timer(pid)
        endif
    endfunction

    function GameChalleng_6_JumpAttack1(int id)
        int pid = id
        int num = 0
        real x = 0
        real y = 0 
        int time = 0
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengeUnitID(pid)
                    if  num != 0
                        x = -992
                        y = 7200
                        SetPlayerTaskUIChatOfPlayer(pid,"马元","姜子牙不要跑！！！",0)
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf60',x,y,225)
                        UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                        UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengeUnit[num],"attack")
                    endif
                elseif  time == 2
                    SetUnitXY(GameChallengeUnit[69],-1312,7264)
                    UnitAddEffectOfGameChalleng(GameChallengeUnit[69])
                    SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
                    SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
                    IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀马元|r",0)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_6_JumpAttack2TimerEnd(int pid,int num)
        SetUnitXY(GameChallengeUnit[69],-64,7136)
        UnitAddEffectOfGameChalleng(GameChallengeUnit[69])
        SetUnitFaceOfUnit(GameChallengeUnit[69],GameChallengeUnit[num])
        UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
        SetUnitOwner(GameChallengeUnit[num],Player(pid+4),true)
        SetUnitColor(GameChallengeUnit[num],GetPlayerColor(Player(PLAYER_NEUTRAL_AGGRESSIVE)))
        IssuePointOrderById(GameChallengeUnit[num],851983,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
        SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff击杀殷洪|r",0)
    endfunction

    function GameChalleng_6_JumpAttack2Timer(int id,unit wu,int n,real r1,real r2)
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
        int num = n
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
                GameChalleng_6_JumpAttack2TimerEnd(pid,num)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_6_JumpAttack2(int id)
        int pid = id
        int num = 0
        real x = 0
        real y = 0 
        int time = 0
        TimerStart(1,true)
        {
            time = time + 1
            if  IsPlayerInChallenge == true
                if  time == 1
                    num = GetCanUsesGameChallengeUnitID(pid)
                    if  num != 0
                        x = -192
                        y = 7168
                        SetPlayerTaskUIChatOfPlayer(pid,"姜子牙","殷洪你可敢上桥来，和我打三回合？",0)
                        CreateUsesGameChallengeUnitExOfAng(pid,num,'uf61',x,y,225)
                        UnitAddEffectOfGameChalleng(GameChallengeUnit[num])
                        UnitAddEffectSetSize(GameChallengeUnit[num],"effect_az-leiji.mdx",2)
                        SetUnitAnimation(GameChallengeUnit[num],"attack")
                    endif
                elseif  time == 2
                    SetPlayerTaskUIChatOfPlayer(pid,"殷洪","哼！就算我师父在我也不惧，又何怕你幻术？我来了！",0)
                    GameChalleng_6_JumpAttack2Timer(pid,GameChallengeUnit[num],num,144,6400)
                    endtimer
                endif
            else
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameChalleng_6_Jump1(int id,unit wu,real r1,real r2,int fl)
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
        int flag = fl
        unit u2 = CreateTmUnit(Player(pid),"Unit_FeiMa.mdl",x1,y1,ang/0.01745,0,1.5)
        ShowUnitOfOnlyPlayer(pid,u2,UnitAPOfPlayer)
        SetUnitFacing(u1,ang/0.01745)
        UnitAddAbility(u1,'Amrf')
        SetUnitFlyHeight(u1,100,0)
        UnitRemoveAbility(u1,'Amrf')
        LocAddEffectSetSize(x1,y1,"effect_white-qiquan-juhuang.mdl",1)
        SetUnitAnimation(u2,"walk")
        TimerStart(0.035,true)
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
                if  flag == 0
                    GameChalleng_6_JumpAttack1(pid)
                elseif  flag == 1
                    GameChalleng_6_JumpAttack2(pid)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function EnRctGameChalleng_6_Way0()
        unit u1 = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u1))
        if  GetUnitAbilityLevel(u1,'Aloc') == 0
            if  u1 == Pu[1]
                if  GameChallengeUnit[69] == null and GameChallengeInt[60] == 0 and IsFinshChallenge(6) == false and IsPlayerInChallenge == true
                    GameChallengeInt[60] = 1
                    SetUnitVertexColor(GameChallengeUnit[61],255,255,255,0)
                    SetUnitVertexColor(GameChallengeUnit[51],255,255,255,0)
                    GameChallengeUnit[69] = CreateUnit(Player(9),'np07',GetUnitX(Pu[1]),GetUnitY(Pu[1]),45)
                    ShowUnitOfOnlyPlayer(pid,GameChallengeUnit[69],UnitAPOfPlayer)
                    UnitAddAbility(GameChallengeUnit[69],'AZ99')
                    SetUnitAbilityLevel(GameChallengeUnit[69],'AZ99',pid+1)
                    SetPlayerTaskUIChatOfPlayer(pid,"任务","跟随姜子牙！",0.2)
                    SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随姜子牙|r",0)
                    GameChalleng_6_Jump1(pid,GameChallengeUnit[69],-1184,7072,0)
                endif
            endif
        endif
        flush locals
    endfunction

    function GameChallenge_6_A_Death(int pid,unit u2)
        int uid = GetUnitTypeId(u2)
        GameChallengeUnit[R2I(GetUnitRealState(u2,99))] = null
        if  uid == 'uf60'
            if  GameChallengeInt[60] == 1
                GameChallengeInt[60] = 2
                GameChalleng_6_Jump1(pid,GameChallengeUnit[69],-288,7296,1)
                SetPlayerTaskUIChatOfPlayer(pid,"任务","跟随姜子牙！",0)
                SetPlayerTaskUITaskOfPlayer(pid,"|cff00ffff跟随姜子牙|r",0)
            endif
        elseif  uid == 'uf61'
            if  GameChallengeInt[60] == 2
                GameChallengeInt[60] = 0
                SetPlayerTaskUIChatOfPlayer(pid,"殷洪","老师，弟子愿保武王灭纣，望乞救命！",0)
                SetPlayerTaskUIChatOfPlayer(pid,"赤精子","此时迟了！你已犯天条，自化飞灰，莫误了进封神台时辰！",1)
                GameChallengeFluahAll(pid,1)
                IsFinshChallenge(6) = true
                //奖励
                PlayerFinishPlotEx(pid,6)
            endif
        elseif  uid == 'uf62'
            SetPlayerTaskUIChatOfPlayer(pid,"剧情","成功击杀申公豹！",0)
            if  GameChallengeOperaWay[6] == 0
                if  GetGameChallengOperaSelsect() == 0
                    GameChallengeOperaWay[6] = 1
                    SetLeagueUnit(6,true)
                    SetPlayerTaskUIChatOfPlayer(pid,"殷郊","吾奉师尊之命，此事不可鲁莽。师尊自会给我一个答案。",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00殷郊加入己方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00殷郊加入己方阵营！|r") 
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cff00ff00殷郊加入己方阵营！|r")                                  
                else
                    GameChallengeOperaWay[6] = 2
                    SetLeagueUnit(6,false)
                    SetPlayerTaskUIChatOfPlayer(pid,"殷郊","兄弟竟死于恶人之手，我与姜尚不共戴天！",1)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000殷郊加入敌方阵营！|r")   
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000殷郊加入敌方阵营！|r") 
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[时渊-愚孝愚亲]：|r"+GetPlayerNameOfColor(pid)+"完成了时渊剧情，|cffff0000殷郊加入敌方阵营！|r") 
                endif
            endif
            GameChallengeFluahAll(pid,1)
            PlayerChallengeOverCosNum = PlayerChallengeOverCosNum + 1
            PlayerChallengeTimeCosNum(6) = PlayerChallengeTimeCosNum(6) + 1
            //奖励
            PlayerFinishPlotEx(pid,6)

            /*if  GetUnitTypeId(Pu[1]) == 'H024' and IsFinshChallenge(6) == true //彩蛋
                if  DzPlayerLv(Player(pid)) >= 6
                    if  GameLevel >= 3
                        if  GetPlayerTechCount(Player(pid),'RDAP',true) == 0
                            SetDzPlayerData(pid,15,16,16)
                            SetPlayerTechResearchedEx(Player(pid),'RDAP')
                            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000销售精英|r（永久存档）！")
                        endif
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000销售精英|r，但可惜难度不够要求！")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[彩蛋]：|r恭喜您触发了|cffffcc00【彩蛋】|cffff8000销售精英|r，但可惜地图等级不够要求！")
                endif
            endif*/
        endif
    endfunction

    function InitGameChallenge_6()
        for pid = 0,3
            if  IsPlaying(pid) == true
                GameChallengeUnit[60] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np16',-2048,6368,180)
                SetUnitVertexColor(GameChallengeUnit[60],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[60],0x01)
                GameChallengeUnit[61] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ07',-2048,6368,0)
                SetUnitVertexColor(GameChallengeUnit[61],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[61],0x01)
                GameChallengeUnit[62] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-2048,6560,0)
                SetUnitVertexColor(GameChallengeUnit[62],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[62],0x01)
                GameChallengeUnit[63] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np25',-1504,8352,225)
                SetUnitVertexColor(GameChallengeUnit[63],255,255,255,0)
                EXSetUnitMoveType(GameChallengeUnit[63],0x01)
            endif
        end
        CreateTrigUnitInRangeOfGameChallenge(-2048,6368,150,function EnRctGameChalleng_6_Way0)
    endfunction


endlibrary
