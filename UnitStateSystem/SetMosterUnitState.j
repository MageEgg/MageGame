library UnitStateSet initializer UnitStateSetInit uses State //initializer UnitStateSetInit
    //属性加载
    
    int MosterLevel = 0
    
    
    func SetMosterUnitStateById(unit wu,int newid)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int uid = newid
        real value = 0
        for i = 1,40
            value = GetTypeIdReal(uid,i)
            if  value > 0
                SetUnitRealState(wu,i,R2I(value))
            endif
        end
    end
    
    func SetMosterUnitState(unit wu)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int uid = GetUnitTypeId(wu)
        real value = 0
        for i = 1,40
            value = GetTypeIdReal(uid,i)
            if  value > 0
                SetUnitRealState(wu,i,R2I(value))
            endif
        end
        if  GetUnitPointValue(wu) != 100
            SetUnitPointX(wu,GetUnitX(wu))
            SetUnitPointY(wu,GetUnitY(wu))
        endif
    end
    
    func SetAttackUnitState(unit wu)
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
            
            
            if  value > 0
                SetUnitRealState(wu,i,R2I(value))
            endif
        end
        
        if  GetUnitPointValue(wu) == 1
            SetUnitPointX(wu,GetUnitX(wu))
            SetUnitPointY(wu,GetUnitY(wu))
        endif
    end
    
    
    func SetHeroUnitState(unit wu)
        int uid = GetUnitTypeId(wu)
        real value = 0
        
        for i = 1,70
            value = GetTypeIdReal(uid,i)
            if  value > 0
                
                SetUnitRealState(wu,i,R2I(value))
            endif
        end
        

    end
    
    func InitUnit(unit wu)
        int id = GetUnitTypeId(wu)
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
        elseif  id >= 'u000' and id <= 'uzzz'
            SetMosterUnitState(wu)
            BJDebugMsg("uzzzuzzzuzzzuzzzuzzzuzzz")
        elseif  id >= 'H000' and id <= 'Hzzz'
            SetHeroUnitState(wu)
        elseif  id >= 'sp00' and id <= 'sp99'
            SetHeroUnitState(wu)
        endif
    end
    
    
    
    function InitMostetStateRatio(int level,real life,real attack,real def,real wb,real wbs,real fb,real fbs,real gs,real r1,real r2,real r3)
        GameReal[level][1] = life
        GameReal[level][2] = attack
        GameReal[level][3] = def
        GameReal[level][4] = wb
        GameReal[level][5] = wbs
        GameReal[level][6] = fb
        GameReal[level][7] = fbs
        GameReal[level][8] = gs
        GameReal[level][9] = r1
        GameReal[level][10] = r2
        GameReal[level][11] = r3
    endfunction
    function UnitStateSetInit()
    endfunction
endlibrary


