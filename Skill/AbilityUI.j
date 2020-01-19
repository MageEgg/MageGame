library AbilityUI initializer AbilityUIInit uses DamageCode

    #define AbilityUIMax 7
    real array PlayerSkillPostion[4000][2]
    
    function RefreshUnitSkill(unit u) //刷新所有技能CD
        int gid=0
        int cid=0
        for sid = 1,AbilityUIMax
            gid=sid+'AG00'
            cid=sid+'AC00'
            YDWESetUnitAbilityState(u, gid, 1,0)
            YDWESetUnitAbilityState(u, cid, 1,0)
        end
       

        u = null
    endfunction

    function GetHeroAbilityIndex(unit wu,int id)->int
        for index = 1,AbilityUIMax
            if  GetUnitIntState(wu,110+index) == id
                return index
            endif
        end
        return 0
    endfunction
    function GetHeroNullIndex(unit wu)->int
        int id = 0
        for index = 1,AbilityUIMax
            id = GetUnitIntState(wu,110+index)
            if  id == 0
                return index
            elseif GetTypeIdData(id,101) == 9
                return index
            endif
        end
        return 0
    endfunction

    func GetUnitAttack(unit wu)->real
        return GetUnitState(wu, ConvertUnitState(0x12)) + GetUnitState(wu, ConvertUnitState(0x13))
    end
    
    func GetAbilityDamage(unit wu,int id,int lv)->real
        real r1 = 0
        int chi = GetTypeIdData(id,102)     
        DBUG("lv:"+I2S(lv))
        int index = GetHeroAbilityIndex(wu,id)
        if  index == 5
            r1 = GetTypeIdReal(id,101)
        else
            r1 = GetTypeIdReal(id,100+lv)
        endif
        if  chi == 1
            return r1 * GetUnitAttack(wu)
        elseif  chi == 0
            return r1
        else
            return r1 * GetUnitRealState(wu,chi)
        endif
        flush locals
    end
    
    
    
    
    func SetPlayerSkillPostion(int pid,int index,real x,real y)
        int id = index * 12 + pid
        PlayerSkillPostion[id][1]=x
        PlayerSkillPostion[id][2]=y
    end
    func GetPlayerSkillPostionX(int pid,int index)->real
        int id = index * 12 + pid
        return PlayerSkillPostion[id][1]
    end
    func GetPlayerSkillPostionY(int pid,int index)->real
        int id = index * 12 + pid
        return PlayerSkillPostion[id][2]
    end
    
    function GetHeroAbilityID(unit wu,int index)->int
        if  GetUnitIntState(wu,110+index) != 0
            return GetUnitIntState(wu,110+index)
        endif
        return 0
    endfunction
    function GetHeroAbilityLevelByIndex(unit wu,int index)->int
        return GetUnitIntState(wu,120+index)
    endfunction
    function GetHeroAbilityLevel(unit wu,int id)->int
        for index = 1,AbilityUIMax
            
            if  GetUnitIntState(wu,110+index) == id
                return GetUnitIntState(wu,120+index)
            endif
        end
        return 0
    endfunction

    function GetAbilityCD(unit wu,int id)->real
        real r1 = GetTypeIdReal(id,100)
        real r2 = GetUnitRealState(wu,25)

        int lv = GetHeroAbilityLevel(wu,id)

        if  id == 'S521'
            if  lv >= 4
                return 30
            else
                return r1
            endif
        elseif  id == 'S527'
            return r1
        endif

        return r1 * (1-r2*0.01)
    endfunction
    
    function GetHeroAbilityName(unit wu,int index)->string
        int id = GetHeroAbilityID(wu,index)
        int lv = GetHeroAbilityLevel(wu,id)
        if  id != 0
            return GetTypeIdString(id,100)+"(Lv"+I2S(lv)+")"
            
        endif
        return "未获得技能"
    endfunction
    
    
    

    
    
        
    function IsPlayerHasAbility(unit wu,int id)->bool
        for index = 1,AbilityUIMax
            if  GetUnitIntState(wu,110+index) == id
                return true
            endif
        end
        return false
    endfunction
    
    function GetSkillNameColor(int color)->string
        if  color == 0
            return "|cffff0000"
        elseif  color == 5
            return "|cffff0033"
        elseif  color == 4
            return "|cffffff00"
        elseif  color == 3
            return "|cff00BFFF"
        elseif  color == 2
            return "|cff00FA9A"
        elseif  color == 1
            return "|cffffffff"
        endif
        return "|cffffffff"
    endfunction
    
    function GetSkillName(int id)->string
        int color = GetTypeIdData(id,101)
        string name = GetSkillNameColor(color)+GetTypeIdString(id,100)
        if  color == 0
            name = name + "\nEx级"
        elseif  color == 1
            name = name + "\nS级"
        elseif  color == 2
            name = name + "\nA级"
        elseif  color == 3
            name = name + "\nB级"
        elseif  color == 4
            name = name + "\nC级"
        elseif  color == 5
            name = name + "\nC-级"
        elseif  color == 6
            name = name + "\nD+级"
        elseif  color == 7
            name = name + "\nD级"
        elseif  color == 8
            name = name + "\nD-级"
        endif
        
        
        if  GetTypeIdData(id,100) == 1
            if  color != 9
                name = name + " |r被动"
            endif
        else
            name = name + " |r主动"
        endif
        return name
    endfunction

    function GetSkillGrade(int color)->string
        if  color == 5
            return "S级"
        elseif  color == 4
            return "A级"
        elseif  color == 3
            return "B级"
        elseif  color == 2
            return "C级"
        elseif  color == 1
            return "D级"
        endif
        return ""
    endfunction

    function GetSkillNameEx(int id,int index,int level)->string
        int color = GetTypeIdData(id,101)
        string name = ""
        if  index == 5
            name = GetSkillNameColor(level)+GetTypeIdString(id,100)+"|r Lv."+I2S(level)+StateName[300+index]
        else
            name = GetSkillNameColor(level)+GetTypeIdString(id,100)+"|r"+StateName[300+index]
        endif
        if  index == 5
            name = name + "\n天赋"
        else
            if  color == 0
                name = name + "\n神通"
            else
                name = name +"\n" +GetSkillGrade(level)
                
            endif
        endif
        
        
        if  GetTypeIdData(id,100) == 1
            if  color != 9
                name = name + " |r被动"
            endif
        else
            name = name + " |r主动"
        endif
        return name
    endfunction
    
    
    //获取基础属性
    function GetAbilityStateTips(int id,real scale)->string
        string s = ""
        real value = 0
        for i = 1,60
            value = GetTypeIdReal(id,i)
            if  value > 0
                value = value * scale
                s = s + "\n增加|Cffff8000" + I2S(R2I(value)) + StateName[i+1000] +"|r"+ StateName[i] 
            endif
            
        end
        return  s
    endfunction


    function ReHeroAbilityTips(unit wu,int index)
        int id = GetUnitIntState(wu,110+index)
        int level = GetUnitIntState(wu,120+index)
        int Type = GetTypeIdData(id,100)
        int sid1 = 'AG00'+index
        int sid2 = 'AB00'+index
        int sid3 = 'AC00'+index
        int magicid = 0
        string tip = ""
        
        
        
        if  Type == 1
            UnitAddAbility(wu,sid2)
            UnitMakeAbilityPermanent(wu,true,sid2)
        else
            UnitRemoveAbility(wu,sid2)
        endif
        SetUnitAbilityLevel(wu,sid1,Type)
        
        if  GetLocalPlayer() == GetOwningPlayer(wu)
            if  id > 0
                YDWESetUnitAbilityDataString(wu, sid1,1, 204, GetTypeIdString(id,101))
                YDWESetUnitAbilityDataString(wu, sid2,1, 204, GetTypeIdString(id,101))
                YDWESetUnitAbilityDataString(wu, sid3,1, 204, GetTypeIdString(id,101))
                YDWESetUnitAbilityDataString(wu, sid1,Type, 215, GetSkillNameEx(id,index,level) )
                YDWESetUnitAbilityDataString(wu, sid2,Type, 215, GetSkillNameEx(id,index,level) )
                YDWESetUnitAbilityDataString(wu, sid3,Type, 215, GetSkillNameEx(id,index,level) )
                
                

                if  index == 5
                    
                    if  level > 1
                        tip = tip + "\n\n|cff00ff00境界三：\n" +GetTypeIdString(id,111) + "|r"
                    else
                        tip = tip + "\n\n|cffbbbbbb境界三：\n" +GetTypeIdString(id,111) + "|r"
                    endif

                    if  level > 2
                        tip = tip + "\n\n|cff00ff00境界五：\n" +GetTypeIdString(id,112) + "|r"
                    else
                        tip = tip + "\n\n|cffbbbbbb境界五：\n" +GetTypeIdString(id,112) + "|r"
                    endif

                    if  level > 3
                        tip = tip + "\n\n|cff00ff00境界十：\n" +GetTypeIdString(id,113) + "|r"
                    else
                        tip = tip + "\n\n|cffbbbbbb境界十：\n" +GetTypeIdString(id,113) + "|r"
                    endif
                else
                    
                    int DamageType = GetTypeIdData(id,103)//伤害类型
                    int chi = GetTypeIdData(id,102)//属性类型
                    
                    real r1 = GetTypeIdReal(id,101)
                    real r2 = GetTypeIdReal(id,102) 
                    real dam = r1 + r2 * level
        
                    if  DamageType == 1
                        tip = tip + "\n\n|Cffff8000物理伤害："+StateName[chi]+"*"+I2S(R2I(dam))+"|r"
                    elseif  DamageType == 2
                        tip = tip + "\n\n|Cff00bfff法术伤害："+StateName[chi]+"*"+I2S(R2I(dam))+"|r"
                    endif

                    //结算技能额外
                    tip = tip + GetAbilityStateTips(id,dam)
                    
                endif
                
                real cd = GetTypeIdReal(id,100)//技能CD
                if  cd > 0
                    tip = tip + "\n\n|cffdddddd冷却："+R2S2(cd)+"s|r"
                endif

                magicid = GetUnitIntState(wu,125+index)
                if  magicid > 0
                    tip = tip + "\n\n附魔："+GetTypeIdStateTips(magicid)
                endif
                
                YDWESetUnitAbilityDataString(wu, sid1,Type, 218, GetTypeIdString(id,102)+tip)
                YDWESetUnitAbilityDataString(wu, sid2,Type, 218, GetTypeIdString(id,102)+tip)
                YDWESetUnitAbilityDataString(wu, sid3,Type, 218, GetTypeIdString(id,102)+tip)
            endif
        endif
        tip = ""
    endfunction


    function PlayerHeorAddSkillMagic(int pid,int index,int id)
        int now = GetUnitIntState(Pu[1],125+index)
        if  now != 0
            SetUnitIntState(Pu[1],125+index,0)
            SetEquipStateOfPlayer(Pu[1],now,-1)
        endif
        if  id != 0
            SetUnitIntState(Pu[1],125+index,id)
            SetEquipStateOfPlayer(Pu[1],id,1)
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:技能附魔成功！"+GetTypeIdStateTips(id))
        endif
        ReHeroAbilityTips(Pu[1],index)
        
    endfunction



    function SetAbilityState(unit wu,int newid,real scale,real offset)
        real value = 0
        for i = 1,70
            value = GetTypeIdReal(newid,i)
            if  value != 0
                AddUnitRealState(wu,i,value*scale*offset)
            endif
        end
    endfunction
    
    
    function RemAbilityState(unit wu,int id,int level)
        integer pid=GetPlayerId(GetOwningPlayer(wu))
        real dam = GetTypeIdReal(id,100+level)
        SetAbilityState(wu,id,dam,-1)
    endfunction


    
    function AddAbilityState(unit wu,int id,int level)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        real dam = GetTypeIdReal(id,100+level)
        SetAbilityState(wu,id,dam,1)
    endfunction
    
   
    
    function HeroSetAbilityLevelByIndex(unit wu,int index,int newlv)
        int uid = GetUnitTypeId(wu)
        int id = GetUnitIntState(wu,110+index)
        int nowlv = GetHeroAbilityLevelByIndex(wu,index)

        RemAbilityState(wu,id,nowlv)
        AddAbilityState(wu,id,newlv)

        SetUnitIntState(wu,120+index,newlv)
        ReHeroAbilityTips(wu,index)

        
        if  index == 5
            if  uid == 'H009'
                if  newlv == 2
                    AddUnitRealState(wu,12,10)
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:广成子奕剑之道，普攻伤害|Cffff8000+10%|r")
                elseif  newlv == 3
                    AddUnitRealState(wu,12,10)
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:广成子奕剑之道，普攻伤害|Cffff8000+10%|r")
                elseif  newlv == 4
                    BJDebugMsg(GetUnitName(wu)+"攻击间隔"+R2S(GetUnitState( wu, ConvertUnitState(0x25))))
                    SetUnitState(wu,ConvertUnitState(0x25),GetUnitState(wu,ConvertUnitState(0x25))-0.1)
                    BJDebugMsg(GetUnitName(wu)+"攻击间隔"+R2S(GetUnitState( wu, ConvertUnitState(0x25))))
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:广成子奕剑之道，攻击间隔降低0.1秒")
                endif
            elseif  uid == 'H017'
                if  newlv == 2
                    UnitAddItemExEx(wu,CreateItem('CS03',GetUnitX(wu),GetUnitY(wu)))
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:小哪吒天资聪颖，获得"+GetObjectName('CS03')+"x1")
                elseif  newlv == 3
                    UnitAddItemExEx(wu,CreateItem('CS04',GetUnitX(wu),GetUnitY(wu)))
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:小哪吒天资聪颖，获得"+GetObjectName('CS04')+"x1")
                elseif  newlv == 4
                    UnitAddItemExEx(wu,CreateItem('CS05',GetUnitX(wu),GetUnitY(wu)))
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:小哪吒天资聪颖，获得"+GetObjectName('CS05')+"x1")
                endif
            elseif  uid == 'H018'
                if  newlv == 4
                    UnitAddItemExEx(wu,CreateItem('IP02',GetUnitX(wu),GetUnitY(wu)))
                    UnitAddItemExEx(wu,CreateItem('IP02',GetUnitX(wu),GetUnitY(wu)))
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:太乙真人运行九转神功，获得"+GetObjectName('IP02')+"x2")
                endif
            elseif  uid == 'H021'
                if  newlv == 2
                    UnitAddItemExEx(wu,CreateItem('IN19',GetUnitX(wu),GetUnitY(wu)))
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:嫦娥突破境界，额外获得"+GetObjectName('IN19')+"x1")
                endif
            elseif  uid == 'H022'
                if  newlv == 2
                    AddUnitRealState(wu,9,20)
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:雷震子获得风雷咒术加持，攻速|Cffff8000+20%|r")
                elseif  newlv == 3
                    AddUnitRealState(wu,9,20)
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:雷震子获得风雷咒术加持，攻速|Cffff8000+20%|r")
                elseif  newlv == 4
                    AddUnitRealState(wu,9,60)
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:雷震子获得风雷咒术加持，攻速|Cffff8000+60%|r")
                endif
            elseif  uid == 'H028'
                if  newlv == 2
                    AddUnitRealState(wu,15,10)
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:纣王尚武乏谋，物理伤害|Cffff8000+10%|r")
                    
                elseif  newlv == 3
                    AddUnitRealState(wu,15,10)
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:纣王尚武乏谋，物理伤害|Cffff8000+10%|r")
                elseif  newlv == 4
                    AddUnitRealState(wu,15,20)
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:纣王尚武乏谋，物理伤害|Cffff8000+20%|r")
                endif
            elseif  uid == 'H030'
                
                if  newlv == 3
                    AddUnitRealState(wu,24,300)
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:后羿获得百发百中加持，致命倍率|Cffff8000+300%|r")
                elseif  newlv == 4
                    UnitAddAbility(wu,'AH30')
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:后羿获得百发百中加持，领悟多重射击")
                endif
            elseif  uid == 'xxxx'
                if  newlv == 2
                elseif  newlv == 3
                elseif  newlv == 4
                endif
            endif
            DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:技能"+GetTypeIdString(id,100)+"升级至|r"+I2S(newlv)+"级")
        else

        endif
        
    endfunction
    
    
    function HeroSetAbilityLevelById(unit wu,int id,int level)
        int index = GetHeroAbilityIndex(wu,id)
        HeroSetAbilityLevelByIndex(wu,index,level)
        ReHeroAbilityTips(wu,index)
    endfunction

    function HeroRandomSetAbilityLevel(unit wu,int index)
        HeroSetAbilityLevelByIndex( wu,index,GetRandomInt(1,4))
    endfunction
    


    function HeroIncAbility(unit wu,int index)
        int use = 0
        int lv = GetUnitIntState(wu,120+index)
        if  GetHeroAbilityID(wu,index) == 0
            DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]:技能升级失败！该键位无技能！|r")
        else
            HeroSetAbilityLevelByIndex(wu,index,lv+1)
        endif
    endfunction
    

    
    
    
    
    function HeroRemoveAbilityByIndex (unit wu,int index)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int level = GetUnitIntState(wu,120+index)
        int id = GetUnitIntState(wu,110+index)
        RemAbilityState(wu,GetUnitIntState(wu,110+index),level)

        if  id == 'S034'
            UnitRemoveAbility(wu,'A034'+pid)
        elseif  id == 'S067'
            UnitRemoveAbility(wu,'A067'+pid)
        endif

        SetUnitIntState(wu,110+index,0)
        SetUnitIntState(wu,120+index,0)
        PlayerHeorAddSkillMagic(pid,index,0)
        ReHeroAbilityTips(wu,index)
        DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:技能删除成功！")
    endfunction
    
    function HeroRemoveAbility(unit wu,int id)
        HeroRemoveAbilityByIndex(wu, GetHeroAbilityIndex(wu,id))
    endfunction
    
    function HeroRemoveAbilityListFunc()
        int pid = Dialog.GetPlayerid()
        int id = Dialog.GetButtonid()
        if  id <= AbilityUIMax
            if  GetHeroAbilityID(Pu[1],id)>0
                HeroRemoveAbilityByIndex(Pu[1],id)
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:技能删除失败！该位置无技能")
            endif
        endif
    endfunction
    function HeroRemoveAbilityList(unit wu)
        
        Dialog.create(GetOwningPlayer(wu),"请选择要删除的技能",GetHeroAbilityName(wu,1),GetHeroAbilityName(wu,2),GetHeroAbilityName(wu,3),GetHeroAbilityName(wu,4),"取消","","","","","","","","HeroRemoveAbilityListFunc")
    endfunction
    
    
    

    function HeroAddAbilityByIndex(unit wu,int index,int id)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        SetUnitIntState(wu,110+index,id)
        SetUnitIntState(wu,120+index,1)
        AddAbilityState(wu,id,1)

        if  GetTypeIdData(id,101) != 9
            DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:技能"+GetTypeIdString(id,100)+"学习成功！")
            
            if  GetUnitTypeId(wu) == 'H017' and id != 'S517'
                SpellS517.execute(wu) //天賦 天资聪颖   
            endif
        endif
        
        if  id == 'S104'
            SpellS104.execute(wu) //熔炉之身
        elseif  id == 'S034'
            UnitAddAbility(wu,'A034'+pid)
        elseif  id == 'S067'
            UnitAddAbility(wu,'A067'+pid)
        elseif  id == 'S102'
            SpellS102.execute(wu,GetAbilityDamage(wu,'S102',1))
        endif
        ReHeroAbilityTips(wu,index)
        
    endfunction
    
    function HeroAddNewAbility(unit wu,int id)->bool
        int index = GetHeroNullIndex(wu)
        if  index != 0
            if  IsPlayerHasAbility(wu,id) == false
                HeroAddAbilityByIndex(wu,index,id)
                return true
            else
                DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]:已学习该技能，无法重复学习！|r")
                return false
            endif
        else
            DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]:技能已满，无法学习！|r")
            return false
        endif
    endfunction
    
    function SetAbilityCD_AC(unit u,int id,real cd)//设置被动技能CD
        YDWESetUnitAbilityDataReal( u,  GetHeroAbilityIndex(u,id)+'AC00', 1, 105, cd )
        YDWESetUnitAbilityState( u, GetHeroAbilityIndex(u,id)+'AC00', 1, cd )
    endfunction
    function GetAbilityCD_AC(unit u,int id)->real//获取被动技能CD
        return YDWEGetUnitAbilityState(u, GetHeroAbilityIndex(u,id)+'AC00', 1)
    endfunction

    function SetAbilityCD_AG(unit u,int id,real cd)//设置主动技能CD
        integer lv=GetUnitAbilityLevel(u,id)
        YDWESetUnitAbilityDataReal( u,id, lv, 105, cd )
        YDWESetUnitAbilityState( u,id,1, cd )
    endfunction
    
    
    function InitAbilityStringEx(int id,string s1,string s2,string s3,string s4,string s5)
        SetTypeIdString(id,111,s1)
        SetTypeIdString(id,112,s2)
        SetTypeIdString(id,113,s3)
        SetTypeIdString(id,114,s4)
        SetTypeIdString(id,115,s5)
    endfunction

    //InitAbilityData('技能id',技能类型,品质,伤害参数,参数A,参数B,参数C,伤害类型,冷却时间,"技能名称","技能说明","技能图标")
    function InitAbilityData(int id,int Type,int color,int chi,real r1,real r2,real r3,real r4,real r5,int Damagetype,real cd,string name,string tips,string icon)
        SetTypeIdData(id,100,Type)
        SetTypeIdData(id,101,color)
        SetTypeIdData(id,102,chi)
        SetTypeIdData(id,103,Damagetype)
        SetTypeIdString(id,100,name)
        SetTypeIdString(id,101,icon)
        SetTypeIdString(id,102,tips)
        SetTypeIdReal(id,100,cd)//技能CD
        SetTypeIdReal(id,101,r1)//伤害基数
        SetTypeIdReal(id,102,r2)//伤害等级参数
        SetTypeIdReal(id,103,r3)//伤害等级参数
        SetTypeIdReal(id,104,r4)//伤害等级参数
        SetTypeIdReal(id,105,r5)//伤害等级参数
    endfunction
    
    function AbilityUIInit()
        insert InitAbilityStateData
    endfunction
    
    #undef AbilityUIMax
endlibrary

