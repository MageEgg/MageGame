library State initializer StateLibraryInit uses ejtimer,System,Define2
    
    
    
    func InitTypeIdStrings(int id,string name,string icon,string tips)
        SetTypeIdString(id,100,name)
        SetTypeIdString(id,101,icon)
        SetTypeIdString(id,102,tips)
    end
    func InitTypeIdTips(int id,string tip1,string tip2,string tip3,string tip4,string tip5)
        SetTypeIdString(id,111,tip1)
        SetTypeIdString(id,112,tip2)
        SetTypeIdString(id,113,tip3)
        SetTypeIdString(id,114,tip4)
        SetTypeIdString(id,115,tip5)
    end
    
    func InitTypeIdJbState(int id,int use1,string tip1,int use2,string tip2,int use3,string tip3,string tip0)
        SetTypeIdString(id,120,tip0)
        SetTypeIdString(id,121,tip1)
        SetTypeIdString(id,122,tip2)
        SetTypeIdString(id,123,tip3)
        SetTypeIdData(id,121,use1)
        SetTypeIdData(id,122,use2)
        SetTypeIdData(id,123,use3)
    end
    func InitTypeIdJbStateOnec(int id,string tip1,string tip2,string tip3)
        SetTypeIdString(id,131,tip1)
        SetTypeIdString(id,132,tip2)
        SetTypeIdString(id,133,tip3)
    end
    
    
    func InitEquipData(int id,int Type,int color,int gold,int wood,int kill,int NextId,int x,int y)
        int max = 0
        SetTypeIdData(id,100,Type)
        SetTypeIdData(id,101,color)
        SetTypeIdData(id,103,gold)
        SetTypeIdData(id,104,wood)
        SetTypeIdData(id,105,kill)
        SetTypeIdData(id,106,NextId)
        
        SetTypeIdData(id,151,x)
        SetTypeIdData(id,152,y)
    end
    
    
    
    func InitTypeIdData(int id,int Type,int color,int data1,int data2,int data3,int data4,int data5,int data6,int data7,int data8,int data9,int data10)
        SetTypeIdData(id,100,Type)
        SetTypeIdData(id,101,color)
        
        SetTypeIdData(id,111,data1)
        SetTypeIdData(id,112,data2)
        SetTypeIdData(id,113,data3)
        SetTypeIdData(id,114,data4)
        SetTypeIdData(id,115,data5)
        SetTypeIdData(id,116,data6)
        SetTypeIdData(id,117,data7)
        SetTypeIdData(id,118,data8)
        SetTypeIdData(id,119,data9)
        SetTypeIdData(id,120,data10)
        
    end
    
    function InitTypeState1(int id,real data1,real data2,real data3,real data4,real data5,real data6,real data7,real data8,real data9,real data10)
        SetTypeIdReal(id,1,data1)
        SetTypeIdReal(id,2,data2)
        SetTypeIdReal(id,3,data3)
        SetTypeIdReal(id,4,data4)
        SetTypeIdReal(id,5,data5)
        SetTypeIdReal(id,6,data6)
        SetTypeIdReal(id,7,data7)
        SetTypeIdReal(id,8,data8)
        SetTypeIdReal(id,9,data9)
        SetTypeIdReal(id,10,data10)
    endfunction
    function InitTypeState2(int id,real data1,real data2,real data3,real data4,real data5,real data6,real data7,real data8,real data9,real data10)
        SetTypeIdReal(id,11,data1)
        SetTypeIdReal(id,12,data2)
        SetTypeIdReal(id,13,data3)
        SetTypeIdReal(id,14,data4)
        SetTypeIdReal(id,15,data5)
        SetTypeIdReal(id,16,data6)
        SetTypeIdReal(id,17,data7)
        SetTypeIdReal(id,18,data8)
        SetTypeIdReal(id,19,data9)
        SetTypeIdReal(id,20,data10)
    endfunction
    
    function InitTypeState3(int id,real data1,real data2,real data3,real data4,real data5,real data6,real data7,real data8,real data9,real data10)
        SetTypeIdReal(id,21,data1)
        SetTypeIdReal(id,22,data2)
        SetTypeIdReal(id,23,data3)
        SetTypeIdReal(id,24,data4)
        SetTypeIdReal(id,25,data5)
        SetTypeIdReal(id,26,data6)
        SetTypeIdReal(id,27,data7)
        SetTypeIdReal(id,28,data8)
        SetTypeIdReal(id,29,data9)
        SetTypeIdReal(id,30,data10)
    endfunction
    
    function InitTypeState4(int id,real data1,real data2,real data3,real data4,real data5,real data6,real data7,real data8,real data9,real data10)
        SetTypeIdReal(id,31,data1)
        SetTypeIdReal(id,32,data2)
        SetTypeIdReal(id,33,data3)
        SetTypeIdReal(id,34,data4)
        SetTypeIdReal(id,35,data5)
        SetTypeIdReal(id,36,data6)
        SetTypeIdReal(id,37,data7)
        SetTypeIdReal(id,38,data8)
        SetTypeIdReal(id,39,data9)
        SetTypeIdReal(id,40,data10)
    endfunction
    
    function InitTypeState5(int id,real data1,real data2,real data3,real data4,real data5,real data6,real data7,real data8,real data9,real data10)
        SetTypeIdReal(id,41,data1)
        SetTypeIdReal(id,42,data2)
        SetTypeIdReal(id,43,data3)
        SetTypeIdReal(id,44,data4)
        SetTypeIdReal(id,45,data5)
        SetTypeIdReal(id,46,data6)
        SetTypeIdReal(id,47,data7)
        SetTypeIdReal(id,48,data8)
        SetTypeIdReal(id,49,data9)
        SetTypeIdReal(id,50,data10)
    endfunction
    function InitTypeState6(int id,real data1,real data2,real data3,real data4,real data5,real data6,real data7,real data8,real data9,real data10)
        SetTypeIdReal(id,51,data1)
        SetTypeIdReal(id,52,data2)
        SetTypeIdReal(id,53,data3)
        SetTypeIdReal(id,54,data4)
        SetTypeIdReal(id,55,data5)
        SetTypeIdReal(id,56,data6)
        SetTypeIdReal(id,57,data7)
        SetTypeIdReal(id,58,data8)
        SetTypeIdReal(id,59,data9)
        SetTypeIdReal(id,60,data10)
    endfunction
    function InitTypeState7(int id,real data1,real data2,real data3,real data4,real data5,real data6,real data7,real data8,real data9,real data10)
        SetTypeIdReal(id,61,data1)
        SetTypeIdReal(id,62,data2)
        SetTypeIdReal(id,63,data3)
        SetTypeIdReal(id,64,data4)
        SetTypeIdReal(id,65,data5)
        SetTypeIdReal(id,66,data6)
        SetTypeIdReal(id,67,data7)
        SetTypeIdReal(id,68,data8)
        SetTypeIdReal(id,69,data9)
        SetTypeIdReal(id,70,data10)
    endfunction

    
    function StateLibraryInit()

        StateName[1]="攻击"
        StateName[2]="法强"
        StateName[3]="护甲"
        StateName[4]="法抗"
        StateName[5]="生命值"
        StateName[6]="魔法值"
        StateName[7]="生命回复"
        StateName[8]="魔法回复"
        StateName[9]="攻速"
        StateName[10]="闪避"
        StateName[11]="免伤"
        StateName[12]="普攻伤害"
        StateName[13]="物穿"
        StateName[14]="法穿"
        StateName[15]="物理伤害"
        StateName[16]="法术伤害"
        StateName[17]="伤害加成"
        StateName[18]="伤害减免"
        StateName[19]="暴击"
        StateName[20]="暴伤"
        StateName[21]="伤害吸取"
        StateName[22]="分裂"
        StateName[23]="致命概率"
        StateName[24]="致命倍率"
        StateName[25]="冷却缩减"
        StateName[26]="冷却降低"
        StateName[27]=""
        StateName[28]=""
        StateName[29]=""
        StateName[30]=""
        StateName[31]="生命%"
        StateName[32]="攻击%"
        StateName[33]="法强%"
        StateName[1001]=""
        StateName[1002]=""
        StateName[1003]=""
        StateName[1004]=""
        StateName[1005]=""
        StateName[1006]=""
        StateName[1007]=""
        StateName[1008]=""
        StateName[1009]="%"
        StateName[1010]="%"
        StateName[1011]="%"
        StateName[1012]="%"
        StateName[1013]="%"
        StateName[1014]="%"
        StateName[1015]="%"
        StateName[1016]="%"
        StateName[1017]="%"
        StateName[1018]="%"
        StateName[1019]="%"
        StateName[1020]="%"
        StateName[1021]="%"
        StateName[1022]="%"
        StateName[1023]="%"
        StateName[1024]="%"
        StateName[1025]="%"
        StateName[1026]=""
        StateName[1027]=""
        StateName[1028]=""
        StateName[1029]=""
        StateName[1030]=""
        StateName[1031]="%"
        StateName[1032]="%"
        StateName[1033]="%"
                
    endfunction
    
    function GetUnitIntState(unit wu,int StateId)->int
        return GetUnitData(wu,StateId)
    endfunction

    


    
    function SetUnitIntState(unit wu,int StateId,int value)
        if  StateId < 100
            //StateId = 0/0
            //BJDebugMsg(I2S(StateId)+"错误的属性类型请检查")
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]:错误的属性类型请检查"+I2S(StateId)+StateName[StateId]+"+"+I2S(value))
        endif
        SetUnitData(wu,StateId,value)
    endfunction
    
    function AddUnitIntState(unit wu,int StateId,int value)
        SetUnitIntState(wu,StateId,GetUnitIntState(wu,StateId)+value)
    endfunction
    
    function GetUnitRealState(unit wu,int StateId)->real
        real value = GetUnitReal(wu,StateId)
        if  StateId == 1
            value = GetUnitState(wu, ConvertUnitState(0x12))
        elseif  StateId == 2
            value = GetHeroStr(wu,false)
        elseif  StateId == 3
            value = GetUnitState(wu, ConvertUnitState(0x20))
        elseif  StateId == 5
            value = GetUnitState(wu,UNIT_STATE_MAX_LIFE)
        elseif  StateId == 6
            value = GetUnitState(wu,UNIT_STATE_MAX_MANA)
        elseif  StateId == 9
            value = GetUnitState(wu, ConvertUnitState(0x51))*10000
        endif
        return value
    endfunction
    
    

    function SetUnitRealState(unit wu,int StateId,real value)
        real r1 = 0
        real r2 = 0
        if  StateId > 99
            DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,5,"|cffffcc00[系统]:错误的属性类型请检查"+I2S(StateId))
        endif
        
        SetUnitReal(wu,StateId,value)
        if  StateId == 1
            SetUnitState( wu, ConvertUnitState(0x12), value )
        elseif  StateId == 2
            SetHeroStr(wu,R2I(value),true)
        elseif  StateId == 3
            SetUnitState( wu, ConvertUnitState(0x20), value )
        elseif  StateId == 5
            r1 = GetUnitState( wu, UNIT_STATE_LIFE)/GetUnitState( wu, UNIT_STATE_MAX_LIFE)
            SetUnitState( wu, UNIT_STATE_MAX_LIFE, value)
            SetUnitState( wu, UNIT_STATE_LIFE, r1 * GetUnitState( wu, UNIT_STATE_MAX_LIFE))
        elseif  StateId == 6
            r1 = GetUnitState( wu, UNIT_STATE_MANA)/GetUnitState( wu, UNIT_STATE_MAX_MANA)
            SetUnitState( wu, UNIT_STATE_MAX_MANA, value)
            SetUnitState( wu, UNIT_STATE_MANA, r1 * GetUnitState( wu, UNIT_STATE_MAX_MANA))
        elseif  StateId == 9
            SetUnitState( wu, ConvertUnitState(0x51), value*0.0001 )
            if  IsUnitType(wu, UNIT_TYPE_HERO) == true
                SetHeroAgi(wu,R2I(value/100+0.1)-100,true)
            endif
        elseif  StateId == 25
            if  value > 80
                SetHeroInt(wu,80,true)
            else
                SetHeroInt(wu,R2I(value),true)
            endif
        elseif  StateId == 32
            DzFrameSetText(BUTTON_Text[161],"|cffffcc00攻击：|r"+I2S(R2I(value))+"%")
        elseif  StateId == 33
            DzFrameSetText(BUTTON_Text[162],"|cffffcc00法强：|r"+I2S(R2I(value))+"%")
        elseif  StateId == 31
            DzFrameSetText(BUTTON_Text[163],"|cffffcc00生命：|r"+I2S(R2I(value))+"%")
        elseif  StateId == 13
            DzFrameSetText(BUTTON_Text[164],"|cffffcc00物穿：|r"+I2S(R2I(value))+"%")
        elseif  StateId == 14
            DzFrameSetText(BUTTON_Text[165],"|cffffcc00法穿：|r"+I2S(R2I(value))+"%")
        elseif  StateId == 19
            DzFrameSetText(BUTTON_Text[166],"|cffffcc00暴击：|r"+I2S(R2I(value))+"%")
        /*elseif  StateId == 33
            DzFrameSetText(BUTTON_Text[167],"|cffffcc00金币加成：|r"+R2I(value)+"%")*/
        elseif  StateId == 10
            DzFrameSetText(BUTTON_Text[168],"|cffffcc00闪避：|r"+I2S(R2I(value))+"%")
        elseif  StateId == 18
            DzFrameSetText(BUTTON_Text[169],"|cffffcc00减伤：|r"+I2S(R2I(value))+"%")
        elseif  StateId == 21
            DzFrameSetText(BUTTON_Text[170],"|cffffcc00吸血：|r"+I2S(R2I(value))+"%")
        elseif  StateId == 17
            DzFrameSetText(BUTTON_Text[171],"|cffffcc00增伤：|r"+I2S(R2I(value))+"%")
        elseif  StateId == 20
            DzFrameSetText(BUTTON_Text[172],"|cffffcc00暴伤：|r"+I2S(R2I(value))+"%")
        endif

        if  StateId == 5
            RePercentageState.execute(wu,1)
        elseif  StateId == 1
            RePercentageState.execute(wu,2)
        elseif  StateId == 2
            RePercentageState.execute(wu,3)
        elseif  StateId == 9
            RePercentageState.execute(wu,4)
        elseif  StateId == 25
            RePercentageState.execute(wu,5)
        endif
    endfunction
    
    function AddUnitRealState(unit wu,int StateId,real value)
        
        if  StateId == 9
            SetUnitRealState(wu,9,GetUnitRealState(wu,9)+value*100)
        else
            SetUnitRealState(wu,StateId,GetUnitRealState(wu,StateId)+value)
        endif
    endfunction
    
    
    
    
    function RemoveUnitStateEx(unit wu,int StateId,real value)
        if  StateId == 9
            SetUnitRealState(wu,9,GetUnitRealState(wu,9)-value*100)
        else
            SetUnitRealState(wu,StateId,GetUnitRealState(wu,StateId)-value)
        endif
    endfunction
    
    
    
    
    function InitHeroAddStateAbility(unit wu)
        int skill = 0
        for i = 0,30
            skill = i
            if  i > 9
                skill = skill + 7
            endif
            UnitAddAbility(wu,'AQ10'+skill)
            UnitAddAbility(wu,'AQ20'+skill)
            UnitAddAbility(wu,'AQ30'+skill)
            UnitAddAbility(wu,'AQ40'+skill)
        end
    endfunction
    
    function SetUnitAddStateLevel(unit wu,int index,int value)
        int id = 'AQ00'+index*0x100
        int skill = 0
        if  value < 0
            value = 1073741824+value
            BJDebugMsg("负数"+I2S(value))
            SetUnitAbilityLevel(wu,id,2)
        else
            SetUnitAbilityLevel(wu,id,1)
        endif
        for i = 1,30
            skill = id + i
            if  i > 9
                skill = skill + 7
            endif
            if  value - (value/2) * 2 == 1
                SetUnitAbilityLevel(wu,skill,2)
            else
                SetUnitAbilityLevel(wu,skill,1)
            endif
            value = value / 2
        end
    endfunction



    
    
    
    
    func AddUnitStateExTimer(unit wu,int id,real v,real t)
        unit u1 = wu
        int StateId = id
        real value = v
        real time = t
        AddUnitRealState(u1,StateId,value)
        TimerStart(time,false)
        {
            AddUnitRealState(u1,StateId,-value)
            endtimer
            flush locals
        }
        flush locals
    end
    
    
endlibrary


    
    