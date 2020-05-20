library UnitStateSet uses State
    //属性加载
    
    int MosterLevel = 0

    function SetUnitRealStateOfOtherIdAddValue(unit u,int uid,real valv)
        int pid = GetPlayerId(GetOwningPlayer(u))
        real value = 0
        for i = 1,40
            value = GetTypeIdReal(uid,i)
            value = value * valv
            if  (pid >= 4 and pid <= 7) or pid == 10 or pid == 11 or pid == PLAYER_NEUTRAL_AGGRESSIVE
            
                if  i == 17//增伤
                    value = value + GameReal[GameLevel][1]
                elseif  i == 5//生命加成
                    value = value * GameReal[GameLevel][2]
                endif
            endif

            if  value != 0
                
                if  i == 9
                    AddUnitRealState(u,i,R2I(value))
                elseif  i == 5
                    SetUnitRealState(u,i,value)
                else
                    SetUnitRealState(u,i,R2I(value))
                endif
            endif
        end
    endfunction

    
    function SetUnitRealStateOfOtherId(unit u,int uid)
        int pid = GetPlayerId(GetOwningPlayer(u))
        real value = 0
        for i = 1,40
            value = GetTypeIdReal(uid,i)

            if  (pid >= 4 and pid <= 7) or pid == 10 or pid == 11 or pid == PLAYER_NEUTRAL_AGGRESSIVE
            
                if  i == 17//增伤
                    value = value + GameReal[GameLevel][1]
                elseif  i == 5//生命加成
                    value = value * GameReal[GameLevel][2]
                endif
            endif

            if  value != 0
                
                if  i == 9
                    AddUnitRealState(u,i,R2I(value))
                elseif  i == 5
                    SetUnitRealState(u,i,value)
                else
                    SetUnitRealState(u,i,R2I(value))
                endif
            endif
        end
    endfunction

    function SetUnitRealStateOfStar(unit u,int uid,real att,real def,real life)
        int pid = GetPlayerId(GetOwningPlayer(u))
        real value = 0
        for i = 1,40
            value = GetTypeIdReal(uid,i)
            if  (pid >= 4 and pid <= 7) or pid == 10 or pid == 11 or pid == PLAYER_NEUTRAL_AGGRESSIVE
            
                if  i == 17//增伤
                    value = value + GameReal[GameLevel][1]
                elseif  i == 5//生命加成
                    value = value * GameReal[GameLevel][2]
                endif
            endif
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
                elseif  i == 5
                    SetUnitRealState(u,i,value)
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
            if  (pid >= 4 and pid <= 7) or pid == 10 or pid == 11 or pid == PLAYER_NEUTRAL_AGGRESSIVE
            
                if  i == 17//增伤
                    value = value + GameReal[GameLevel][1]
                elseif  i == 5//生命加成
                    value = value * GameReal[GameLevel][2]
                endif
            endif
            if  value != 0
                if  i == 9
                    AddUnitRealState(wu,i,R2I(value))
                elseif  i == 5
                    SetUnitRealState(wu,i,value)
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
            if  (pid >= 4 and pid <= 7) or pid == 10 or pid == 11 or pid == PLAYER_NEUTRAL_AGGRESSIVE
            
                if  i == 17//增伤
                    value = value + GameReal[GameLevel][1]
                elseif  i == 5//生命加成
                    value = value * GameReal[GameLevel][2]
                endif
            endif
            if  value != 0
                if  i == 9
                    AddUnitRealState(wu,i,R2I(value))
                elseif  i == 5
                    SetUnitRealState(wu,i,value)
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
        int AttackWN = AttackUnitInt[0][2]

        

        if  (uid >= 'm10A' and uid <= 'm10E') or  (uid >= 'm11A' and uid <= 'm11E')
            if  AttackWN < 10
                uid = 'm100'+AttackWN
            elseif  AttackWN < 20
                uid = 'm110'+(AttackWN-10)
            elseif  AttackWN < 30
                uid = 'm120'+(AttackWN-20)
            elseif  AttackWN < 40
                uid = 'm130'+(AttackWN-30)
            elseif  AttackWN < 50
                uid = 'm140'+(AttackWN-40)
            elseif  AttackWN < 60
                uid = 'm150'+(AttackWN-50)
            else
                uid = 'm160'
            endif
        elseif  uid >= 'mf0A' and uid <= 'mf0H'
            if  AttackWN >= 60
                uid = 'mf06'
            elseif  AttackWN >= 50
                uid = 'mf05'
            elseif  AttackWN >= 40
                uid = 'mf04'
            elseif  AttackWN >= 30
                uid = 'mf03'
            elseif  AttackWN >= 20
                uid = 'mf02'
            else
                uid = 'mf01' 
            endif
        endif


        for i = 1,40
            value = GetTypeIdReal(uid,i)

            if  uid >= 'mf01' and uid <= 'mf06'//超爽BOSS
                if  i == 1 or i == 5
                    BJDebugMsg("超爽BOSS 属性"+I2S(i)+"初始值:"+R2S(value))
                    real ran = GetRandomReal(0.5,2)
                    BJDebugMsg("超爽BOSS 属性倍数："+R2S(ran))
                    value = value * ran
                endif
            endif

            if  uid >= 'm11A' and uid <= 'm11E'
                if  i == 1
                    value = value * 4
                    BJDebugMsg("精英4倍攻击")
                elseif  i == 5
                    value = value * 10
                    BJDebugMsg("精英10倍生命")
                endif
            endif

            if  (pid >= 4 and pid <= 7) or pid == 10 or pid == 11 or pid == PLAYER_NEUTRAL_AGGRESSIVE

                if  i == 17//增伤
                    value = value + GameReal[GameLevel][1]
                elseif  i == 5//生命加成
                    value = value * GameReal[GameLevel][2]
                endif

                
            endif
            
            
            if  value != 0
                if  i == 9
                    AddUnitRealState(wu,i,R2I(value))
                elseif  i == 5
                    SetUnitRealState(wu,i,value)
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
                elseif  i == 5
                    SetUnitRealState(wu,i,value)
                else
                    SetUnitRealState(wu,i,R2I(value))
                endif
                //BJDebugMsg(GetUnitName(wu)+StateName[i]+"+"+R2S(value))
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
        elseif  id == 'uh01'//山
            SetUnitRealState(wu,5,700)
        elseif  id == 'uh02'
            SetUnitRealState(wu,5,100)
        elseif  id >= 'u0DA' and id <= 'u0DZ'
            //周天星辰阵
            SetMosterUnitState(wu)
            /*
            
            index = AttackUnitInt[0][2]+1//进攻波数d
            
            if  index <= 0
                index = 1
            elseif  index >= 30
                index = 30
            endif
            if  index < 10
                newid = YDWES2Id(SubString(YDWEId2S('m000'),0,3)+I2S(index))
            else
                newid = YDWES2Id(SubString(YDWEId2S('m000'),0,2)+I2S(index))
            endif

            //BJDebugMsg("进攻波数"+I2S(index)+"id"+YDWEId2S(newid))

            if  id == 'u0DF' or id == 'u0DL' or id == 'u0DR' or id == 'u0DX'
                SetUnitRealStateOfStar(wu,newid,2,1,4)
            else
                SetUnitRealStateOfStar(wu,newid,0.5,1,1)
            endif
            */
        elseif  id >= 'u000' and id <= 'uzzz'
            SetMosterUnitState(wu)
        elseif  id >= 'H000' and id <= 'H099'
            SetHeroUnitState(wu)
        elseif  id >= 'sp00' and id <= 'sp99'
            SetHeroUnitState(wu)
        endif

        //AddUnitRealState(wu,20,200)
        
    endfunction
    
    
    function LoadDzConData1()
        string con = ""
        if  GameMode == 3
            con = DzCon("ND1_7Ex")
            if  con == ""
                con = "00000000000000000000000000000090000001800030030000400450"
            endif
        else
            con = DzCon("ND1_7")
            if  con == ""
                con = "00000050000000500000006500000090000001400030021000400300"
            endif
        endif
        
        int data1 = 0 
        int data2 = 0
        int index = 0
        for i= 0,6
            index  = i * 8
            data1 = S2I(SubString(con,index,index+4))
            data2 = S2I(SubString(con,index+4,index+8))
            BJDebugMsg("难度"+I2S(i+1)+"data1:"+I2S(data1))
            BJDebugMsg("难度"+I2S(i+1)+"data2:"+I2S(data2))

            if  data1 != 0
                GameReal[i+1][1] = data1
            endif
            
            if  data2 != 0
                GameReal[i+1][2] = data2
            endif

        end
    endfunction
    function LoadDzConData2()
        string con = ""
        if  GameMode == 3
            con = DzCon("ND8_14Ex")
            if  con == ""
                con = "00400750010011000100150000000000000000000000000000000000"
            endif
        else
            con = DzCon("ND8_14")
            if  con == ""
                con = "00400420007007500070110001001500000000000000000000000000"
            endif
        endif

        int data1 = 0 
        int data2 = 0
        int index = 0
        for i= 0,6
            index  = i * 8
            data1 = S2I(SubString(con,index,index+4))
            data2 = S2I(SubString(con,index+4,index+8))
            BJDebugMsg("难度"+I2S(i+8)+"data1:"+I2S(data1))
            BJDebugMsg("难度"+I2S(i+8)+"data2:"+I2S(data2))

            if  data1 != 0
                GameReal[i+8][1] = data1
            endif
            
            if  data2 != 0
                GameReal[i+8][2] = data2
            endif

        end
    endfunction


    function InitMostetStateRatio(int level,real r1,real r2)
        GameReal[level][1] = r1
        GameReal[level][2] = r2
    endfunction
    function UnitStateSetInit()

        if  GameMode == 3
            InitMostetStateRatio(1,0,50)
            InitMostetStateRatio(2,0,50)
            InitMostetStateRatio(3,0,65)
            InitMostetStateRatio(4,0,90)
            InitMostetStateRatio(5,0,180)
            InitMostetStateRatio(6,30,300)
            InitMostetStateRatio(7,40,450)
            InitMostetStateRatio(8,40,750)
            InitMostetStateRatio(9,50,1100)
            InitMostetStateRatio(10,50,1100)
            InitMostetStateRatio(11,100,1500)
        elseif  GameMode == 4
            InitMostetStateRatio(1,0,90)
            InitMostetStateRatio(2,30,200)
            InitMostetStateRatio(3,40,300)
            InitMostetStateRatio(4,40,420)
            InitMostetStateRatio(5,50,750)
            InitMostetStateRatio(6,50,1200)
            InitMostetStateRatio(7,50,1750)
        else
            InitMostetStateRatio(1,0,50)
            InitMostetStateRatio(2,0,50)
            InitMostetStateRatio(3,0,65)
            InitMostetStateRatio(4,0,90)
            InitMostetStateRatio(5,30,140)
            InitMostetStateRatio(6,30,210)
            InitMostetStateRatio(7,40,300)

            InitMostetStateRatio(8,40,420)
            InitMostetStateRatio(9,40,750)
            InitMostetStateRatio(10,50,1100)
            InitMostetStateRatio(11,100,1500)
        endif

        if  GameMode != 4
            LoadDzConData1()
            LoadDzConData2()
        endif
    endfunction
endlibrary




