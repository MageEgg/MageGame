library GameChallenge10 uses GameChallengeBase

    /*texttag array AttackTexttag
AttackTexttag[pid] = CreateTextTag()
                SetTextTagText(AttackTexttag[pid],"0/400",0.03)
                SetTextTagPos(AttackTexttag[pid],x+176,y+412,0)*/

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

        GameChalleng_MJ_BOSS = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'ut21',11488,-7536,270)
        UnitAddAbility(GameChalleng_MJ_BOSS,'Avul')

        for j = 0,4
            for k = 0,3
                x = GetRectMinX(ChallengeRct_MJ[0])+xlength+xs*j
                y = GetRectMaxY(ChallengeRct_MJ[0])-ylength-ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,270)
            end
        end

        for j = 0,4
            for k = 0,3
                x = GetRectMaxX(ChallengeRct_MJ[1])-xlength-xs*j
                y = GetRectMaxY(ChallengeRct_MJ[1])-ylength-ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,270)
            end
        end

        for j = 0,4
            for k = 0,3
                x = GetRectMaxX(ChallengeRct_MJ[2])-xlength-xs*j
                y = GetRectMinY(ChallengeRct_MJ[2])+ylength+ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,90)
            end
        end

        for j = 0,4
            for k = 0,3
                x = GetRectMinX(ChallengeRct_MJ[3])+xlength+xs*j
                y = GetRectMinY(ChallengeRct_MJ[3])+ylength+ys*k
                CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),'ut20',x,y,90)
            end
        end

    endfunction

endlibrary
