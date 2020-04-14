library GameChallenge10 uses GameChallengeBase

    function SendToGameChallenge_10_End()
        unit u = GetTriggerUnit()
        int pid = GetPlayerId(GetOwningPlayer(u))
        if  u == Pu[1]
            if  DzConA[14] == 1
                if  GameLevel >= 4
                    if  GetUnitTypeId(GameChallenge_MJ_BOSS) != 'ut21'
                        OpenChallengeWM.execute(pid)
                    else
                        DisplayTimedTextToPlayer(Player(pid),0,0,2,"|cffffcc00[万魔窟]：|r|cffff0000未解除万魔窟的封印，请击杀秘境领主解除！|r")
                    endif
                else
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r该团本难度4或以上才能激活！！！")
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[万魔窟]：|r|cffff0000当前万魔窟暂未开放！！！|r")
            endif
        endif
        flush locals
    endfunction

    function OpenGameChallenge10_BOSS()
        int time = 30
        SetUnitOwner(GameChallenge_MJ_BOSS,Player(PLAYER_NEUTRAL_AGGRESSIVE),true)
        OpenGameTeamChallengeTimer(time,20)
        SetUnitIntState(GameChallenge_MJ_BOSS,'ut21',time)
        DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[秘境领主]：|r|cffff0000竟然敢打扰我睡觉！！！|r")
        TimerStart(1,true)
        {
            time = time - 1
            if  time > 0 and GetUnitTypeId(GameChallenge_MJ_BOSS) == 'ut21'
                SetUnitIntState(GameChallenge_MJ_BOSS,'ut21',time)
            else
                if  GetUnitTypeId(GameChallenge_MJ_BOSS) == 'ut21'
                    SetTextTagText(GameChallengeTexttag[0],"|cffffff00领主睡觉中！ "+I2S(GameTeamChallengeInt(2))+"/150|r",0.045)
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffff0000未在时间内击杀秘境领主，秘境领主回去睡觉了！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffff0000未在时间内击杀秘境领主，秘境领主回去睡觉了！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffff0000未在时间内击杀秘境领主，秘境领主回去睡觉了！！！|r")
                    SetUnitOwner(GameChallenge_MJ_BOSS,Player(PLAYER_NEUTRAL_PASSIVE),true)
                    SetUnitState(GameChallenge_MJ_BOSS,UNIT_STATE_LIFE,GetUnitState(GameChallenge_MJ_BOSS,UNIT_STATE_MAX_LIFE))
                    SetUnitState(GameChallenge_MJ_BOSS,UNIT_STATE_MANA,GetUnitState(GameChallenge_MJ_BOSS,UNIT_STATE_MAX_MANA))
                    SetUnitIntState(GameChallenge_MJ_BOSS,'ut21',0)
                    SetUnitPosition(GameChallenge_MJ_BOSS,11488,-7536)
                    SetUnitFacing(GameChallenge_MJ_BOSS,270)
                    UnitAddAbility(GameChallenge_MJ_BOSS,'Avul')
                    UnitAddAbility(GameChallenge_MJ_BOSS,'AZ8A')
                    UnitAddEffectOfGameChalleng(GameChallenge_MJ_BOSS)
                endif
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function GameTeamChallengDeath_B(unit u2)
        int uid = GetUnitTypeId(u2)
        real x = 0
        real y = 0
        unit u = null
        if  uid == 'ut20'
            if  GetUnitTypeId(GameChallenge_MJ_BOSS) == 'ut21' and GetUnitAbilityLevel(GameChallenge_MJ_BOSS,'AZ8A') > 0
                GameTeamChallengeInt(2) = GameTeamChallengeInt(2) + 1
                SetTextTagText(GameChallengeTexttag[0],"|cffffff00领主睡觉中！ "+I2S(GameTeamChallengeInt(2))+"/150|r",0.045)
                if  GameTeamChallengeInt(2) == 150
                    SetTextTagText(GameChallengeTexttag[0],"",0.045)
                    UnitRemoveAbility(GameChallenge_MJ_BOSS,'Avul')
                    UnitRemoveAbility(GameChallenge_MJ_BOSS,'AZ8A')
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cffffcc00[团队副本-寻宝秘境]：|r累积击杀"+I2S(GameTeamChallengeInt(2))+"只秘境小怪，|cffff0000秘境领主苏醒了！！！击杀领主可进入万魔窟！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cffffcc00[团队副本-寻宝秘境]：|r累积击杀"+I2S(GameTeamChallengeInt(2))+"只秘境小怪，|cffff0000秘境领主苏醒了！！！击杀领主可进入万魔窟！！！|r")
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,15,"|cffffcc00[团队副本-寻宝秘境]：|r累积击杀"+I2S(GameTeamChallengeInt(2))+"只秘境小怪，|cffff0000秘境领主苏醒了！！！击杀领主可进入万魔窟！！！|r")
                    GameTeamChallengeInt(2) = 0
                elseif  ModuloInteger(GameTeamChallengeInt(2),50) == 0
                    DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,8,"|cffffcc00[团队副本-寻宝秘境]：|r|cffffff00已击杀"+I2S(GameTeamChallengeInt(2))+"只秘境小怪，累积击杀150只可唤醒秘境领主！|r")
                endif
            endif
        elseif  uid == 'ut21'
            for num = 0,1
                SetUnitVertexColor(GameTeamChallengUnit(30+num),255,255,255,0)
                UnitRemoveAbility(GameTeamChallengUnit(30+num),'AZ99')
            end
            SetTextTagLifespan(GameChallengeTexttag[0],2.00)
            SetTextTagFadepoint(GameChallengeTexttag[0],0.50)
            GameChallenge_MJ_BOSS = null
            x = 11488
            y = -7536
            GameChallenge_MJ_BOSS = CreateTmUnit(Player(PLAYER_NEUTRAL_PASSIVE),"effect_az_goods_tp_target(3).mdl",x,y,270,0,1.8)
            EXSetUnitMoveType(GameChallenge_MJ_BOSS,0x01)
            EXSetUnitMoveType(CreateTmUnit(Player(PLAYER_NEUTRAL_PASSIVE),"sunwell.mdl",x,y,270,0,1.98),0x01)
            CreateTrigUnitInRange(GameChallenge_MJ_BOSS,198,function SendToGameChallenge_10_End)

            u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x-420,y,0)
            EXSetUnitMoveType(u,0x01)
            SetUnitColor(u,PLAYER_COLOR_YELLOW)
            u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x-590,y,0)
            EXSetUnitMoveType(u,0x01)
            SetUnitColor(u,PLAYER_COLOR_YELLOW)

            u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x+420,y,180)
            EXSetUnitMoveType(u,0x01)
            SetUnitColor(u,PLAYER_COLOR_YELLOW)
            u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x+590,y,180)
            EXSetUnitMoveType(u,0x01)
            SetUnitColor(u,PLAYER_COLOR_YELLOW)

            u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y+420,270)
            EXSetUnitMoveType(u,0x01)
            SetUnitColor(u,PLAYER_COLOR_YELLOW)
            u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y+590,270)
            EXSetUnitMoveType(u,0x01)
            SetUnitColor(u,PLAYER_COLOR_YELLOW)

            u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y-420,90)
            EXSetUnitMoveType(u,0x01)
            SetUnitColor(u,PLAYER_COLOR_YELLOW)
            u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'eZ09',x,y-590,90)
            EXSetUnitMoveType(u,0x01)
            SetUnitColor(u,PLAYER_COLOR_YELLOW)

            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffffff80成功击杀秘境领主，领主死前解除了万魔窟封印！！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffffff80成功击杀秘境领主，领主死前解除了万魔窟封印！！！！|r")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[团队副本-寻宝秘境]：|r|cffffff80成功击杀秘境领主，领主死前解除了万魔窟封印！！！！|r")
        endif
        u = null
    endfunction

    function SendToGameChallenge_10(int pid)
        real x = 0
        real y = 0
        if  pid == 0
            x = GetRectMaxX(ChallengeRct_MJ[pid])
            y = GetRectMinY(ChallengeRct_MJ[pid])
        elseif  pid == 1
            x = GetRectMinX(ChallengeRct_MJ[pid])
            y = GetRectMinY(ChallengeRct_MJ[pid])
        elseif  pid == 2
            x = GetRectMinX(ChallengeRct_MJ[pid])
            y = GetRectMaxY(ChallengeRct_MJ[pid])
        elseif  pid == 3
            x = GetRectMaxX(ChallengeRct_MJ[pid])
            y = GetRectMaxY(ChallengeRct_MJ[pid])
        endif
        SendPlayerUnit(pid,x,y)
        if  GetUnitTypeId(GameChallenge_MJ_BOSS) == 'ut21'
            DisplayTimedTextToPlayer(Player(pid),0,0,8,"|cffffcc00[团队副本-寻宝秘境]：|r进入寻宝秘境，累积击杀150只秘境小怪可唤醒秘境领主！")
        endif
    endfunction

    function InitGameChallenge_10()
        real x = 0
        real y = 0
        real xlength = 192
        real ylength = 224
        real xs = 320
        real ys = 288
        ChallengeRct_MJ[0] = gg_rct_ChallengeRct_MJ_M_0
        ChallengeRct_MJ[1] = gg_rct_ChallengeRct_MJ_M_1
        ChallengeRct_MJ[2] = gg_rct_ChallengeRct_MJ_M_2
        ChallengeRct_MJ[3] = gg_rct_ChallengeRct_MJ_M_3

        GameChallenge_MJ_BOSS = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut21',11488,-7536,270)
        SetUnitOwner(GameChallenge_MJ_BOSS,Player(PLAYER_NEUTRAL_PASSIVE),true)
        UnitAddAbility(GameChallenge_MJ_BOSS,'Avul')
        UnitAddAbility(GameChallenge_MJ_BOSS,'AZ8A')

        GameChallengeTexttag[0] = CreateTextTag()
        SetTextTagText(GameChallengeTexttag[0],"|cffffff00领主睡觉中！ 0/150|r",0.045)
        SetTextTagPos(GameChallengeTexttag[0],11488-320,-7536+200,0)

        for j = 0,3
            for k = 0,2
                x = GetRectMinX(ChallengeRct_MJ[0])+xlength+xs*j
                y = GetRectMaxY(ChallengeRct_MJ[0])-ylength-ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,270)
            end
        end

        for j = 0,3
            for k = 0,2
                x = GetRectMaxX(ChallengeRct_MJ[1])-xlength-xs*j
                y = GetRectMaxY(ChallengeRct_MJ[1])-ylength-ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,270)
            end
        end

        for j = 0,3
            for k = 0,2
                x = GetRectMaxX(ChallengeRct_MJ[2])-xlength-xs*j
                y = GetRectMinY(ChallengeRct_MJ[2])+ylength+ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,90)
            end
        end

        for j = 0,3
            for k = 0,2
                x = GetRectMinX(ChallengeRct_MJ[3])+xlength+xs*j
                y = GetRectMinY(ChallengeRct_MJ[3])+ylength+ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,90)
            end
        end

        GameTeamChallengUnit(30) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',11414,-7536,270)
        GameTeamChallengUnit(31) = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',11562,-7536,270)
        for j = 0,1
            SetUnitScale(GameTeamChallengUnit(30+j),10.5,10.5,10.5)
            SetUnitVertexColor(GameTeamChallengUnit(30+j),255,255,255,0)
            SetUnitFlyHeight(GameTeamChallengUnit(30+j),10,10000)
        end
    endfunction

endlibrary
