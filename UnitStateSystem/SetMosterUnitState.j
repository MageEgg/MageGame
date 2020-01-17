library UnitStateSet initializer UnitStateSetInit uses State //initializer UnitStateSetInit
    //属性加载
    
    int MosterLevel = 0

    
    function SetUnitRealStateOfOtherId(unit u,int uid)
        real value = 0
        for i = 1,40
            value = GetTypeIdReal(uid,i)
            if  value != 0
                if  i == 9
                    AddUnitRealState(u,i,R2I(value))
                else
                    SetUnitRealState(u,i,R2I(value))
                endif
            endif
        end
    endfunction

    function SetUnitRealStateOfStar(unit u,int uid,real att,real def,real life)
        real value = 0
        for i = 1,40
            value = GetTypeIdReal(uid,i)
            if  value != 0
                if  i == 1
                    value = value * att
                elseif  i == 2
                    value = value * def
                elseif  i == 5
                    value = value * life
                endif

                if  i == 9
                    AddUnitRealState(u,i,R2I(value))
                else
                    SetUnitRealState(u,i,R2I(value))
                endif
            endif
        end
    endfunction
    
    
    function SetMosterUnitStateById(unit wu,int newid)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int uid = newid
        real value = 0
        for i = 1,40
            value = GetTypeIdReal(uid,i)
            if  value != 0
                if  i == 9
                    AddUnitRealState(wu,i,R2I(value))
                else
                    SetUnitRealState(wu,i,R2I(value))
                endif
            endif
        end
    endfunction
    
    function SetMosterUnitState(unit wu)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int uid = GetUnitTypeId(wu)
        real value = 0
        for i = 1,40
            value = GetTypeIdReal(uid,i)
            if  value != 0
                if  i == 9
                    AddUnitRealState(wu,i,R2I(value))
                else
                    SetUnitRealState(wu,i,R2I(value))
                endif
            endif
        end
        if  GetUnitPointValue(wu) != 100
            SetUnitPointX(wu,GetUnitX(wu))
            SetUnitPointY(wu,GetUnitY(wu))
        endif
    endfunction
    
    function SetAttackUnitState(unit wu)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int uid = GetUnitTypeId(wu)
        real value = 0
        for i = 1,40
            value = GetTypeIdReal(uid,i)

            if  pid >= 8
            /*
                if  i == 5
                    value = value * GameReal[GameLevel][1]
                elseif  i == 7
                    value = value * GameReal[GameLevel][2]
                elseif  i == 11
                    value = value * GameReal[GameLevel][3]
                elseif  i == 13
                    value = value * GameReal[GameLevel][4]
                elseif  i == 14
                    value = value * GameReal[GameLevel][5]
                elseif  i == 23
                    value = value * GameReal[GameLevel][6]
                elseif  i == 24
                    value = value * GameReal[GameLevel][7]
                elseif  i == 20
                    value = value + GameReal[GameLevel][8]
                elseif  i == 26
                    value = value + GameReal[GameLevel][9]
                elseif  i == 16
                    value = value + GameReal[GameLevel][10]
                elseif  i == 21
                    value = value * GameReal[GameLevel][11]
                endif*/
            endif
            
            
            if  value != 0
                if  i == 9
                    AddUnitRealState(wu,i,R2I(value))
                else
                    SetUnitRealState(wu,i,R2I(value))
                endif
            endif
        end
        
        if  GetUnitPointValue(wu) == 1
            SetUnitPointX(wu,GetUnitX(wu))
            SetUnitPointY(wu,GetUnitY(wu))
        endif
    endfunction
    
    
    function SetHeroUnitState(unit wu)
        int uid = GetUnitTypeId(wu)
        real value = 0
        
        for i = 1,70
            value = GetTypeIdReal(uid,i)
            if  value != 0
                if  i == 9
                    AddUnitRealState(wu,i,R2I(value))
                else
                    SetUnitRealState(wu,i,R2I(value))
                endif
                BJDebugMsg(GetUnitName(wu)+StateName[i]+"+"+R2S(value))
            endif
        end
        

    endfunction
    
    function InitUnit(unit wu)
        int id = GetUnitTypeId(wu)
        int newid = 0
        int index = 0
        if  id >= 'm000' and id <= 'mzzz'
            if  id == 'm200'
                SetMosterUnitState(wu)
            else
                SetAttackUnitState(wu)
            endif
        elseif  id >= 'g001' and id <= 'g099'
            SetAttackUnitState(wu)
        elseif  id >= 'Mb00' and id <= 'Mb99'
            SetMosterUnitState(wu)
        elseif  id >= 'u0DA' and id <= 'u0DZ'
            //周天星辰阵
            index = AttackUnitInt[0][2]//进攻波数
            if  index <= 0
                index = 1
            elseif  index >= 3
                index = 30
            endif
            if  index < 10
                newid = YDWES2Id(SubString(YDWEId2S('m000'),0,3)+I2S(index))
            else
                newid = YDWES2Id(SubString(YDWEId2S('m000'),0,2)+I2S(index))
            endif
            if  id == 'u0DF' or id == 'u0DL' or id == 'u0DR' or id == 'u0DX'
                SetUnitRealStateOfStar(wu,newid,2,1,4)
            else
                SetUnitRealStateOfStar(wu,newid,0.5,1,1)
            endif
            
        elseif  id >= 'u000' and id <= 'uzzz'
            SetMosterUnitState(wu)
        elseif  id >= 'H000' and id <= 'H099'
            SetHeroUnitState(wu)
        elseif  id >= 'sp00' and id <= 'sp99'
            SetHeroUnitState(wu)
        endif
    endfunction
    
    
    难度注册；生命、攻击、防御、暴击、暴击伤害、物伤提高、法伤提高、物上见面、法伤减免、空、空

    function InitMostetStateRatio(int level,real life,real attack,real def,real bj,real bs,real ws,real fs,real wk,real fk,real r1,real r2)
        GameReal[level][1] = life
        GameReal[level][2] = attack
        GameReal[level][3] = def
        GameReal[level][4] = bj
        GameReal[level][5] = bs
        GameReal[level][6] = ws
        GameReal[level][7] = fs
        GameReal[level][8] = wk
        GameReal[level][9] = fk
        GameReal[level][10] = r1
        GameReal[level][11] = r2
    endfunction
    function UnitStateSetInit()
        InitMostetStateRatio(1,1,1,1,1,1,0,0,0,0,0,0)
        InitMostetStateRatio(2,1.6,1.6,1,1,1,0,0,0,0,0,0)
        InitMostetStateRatio(3,2.3,2.3,1.2,1.1,1,0,0,0,0,0,0)
        InitMostetStateRatio(4,3.1,3.1,1.4,1.1,1,0,0,0,0,0,0)
        InitMostetStateRatio(5,4,4,1.6,1.2,1,0,0,0,0,0,0)
    endfunction
endlibrary



