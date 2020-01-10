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


   func GetUnitAttack(unit wu)->real
        return GetUnitState(wu, ConvertUnitState(0x12)) + GetUnitState(wu, ConvertUnitState(0x13))
    end
    
    func GetAbilityDamage(unit wu,int id,real lv)->real
        real r1 = GetTypeIdReal(id,101)
        real r2 = GetTypeIdReal(id,102)
        int chi = GetTypeIdData(id,102)     
        //BJDebugMsg(GetUnitName(wu))
        if  chi == 99
            return r1 * (GetUnitAttack(wu)+GetUnitRealState(wu,2))
        elseif  chi == 1
            return  r1 * GetUnitAttack(wu)
        else
            return r1 * GetUnitRealState(wu,chi)
        endif
        flush locals
    end
    
    function GetAbilityCD(unit wu,int id)->real
        real r1 = GetTypeIdReal(id,100)
        real r2 = GetUnitRealState(wu,25)
        return r1 * (1-r2*0.01)
    endfunction
    
    
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
    
    function GetHeroAbilityName(unit wu,int index)->string
        int id = GetHeroAbilityID(wu,index)
        int lv = GetHeroAbilityLevel(wu,id)
        if  id != 0
            return GetTypeIdString(id,100)+"(Lv"+I2S(lv)+")"
            
        endif
        return "未获得技能"
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
        elseif  color == 1
            return "|cffff0033"
        elseif  color == 2
            return "|cffffff00"
        elseif  color == 3
            return "|cff00BFFF"
        elseif  color == 4
            return "|cff00FA9A"
        elseif  color == 5
            return "|cff00FA9A"
        elseif  color == 6
            return "|cffffffff"
        elseif  color == 7
            return "|cffffffff"
        elseif  color == 8
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
                YDWESetUnitAbilityDataString(wu, sid1,Type, 215, GetSkillName(id) )
                YDWESetUnitAbilityDataString(wu, sid2,Type, 215, GetSkillName(id) )
                YDWESetUnitAbilityDataString(wu, sid3,Type, 215, GetSkillName(id) )
                
                
                
                
                real cd = GetTypeIdReal(id,100)//技能CD
                if  cd > 0
                    tip = tip + "|n|cffdddddd冷却："+R2S2(cd)+"s|r"
                endif

                magicid = GetUnitIntState(wu,125+index)
                if  magicid > 0
                    tip = tip + "\n\n附魔："+GetObjectName(magicid)+GetTypeIdStateTips(magicid)
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
            SetEquipStateOfPlayer(Pu[1],now,-1)
        endif
        SetUnitIntState(Pu[1],125+index,id)
        SetEquipStateOfPlayer(Pu[1],id,-1)
        ReHeroAbilityTips(Pu[1],index)
    endfunction
    
   
    
    function IncHeroAbilityLevelByIndex(unit wu,int index)
        int id = GetUnitIntState(wu,110+index)
        AddUnitIntState(wu,120+index,1)
        ReHeroAbilityTips(wu,index)
        DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:技能"+GetTypeIdString(id,100)+"升级至|r"+I2S(GetUnitIntState(wu,120+index))+"级")
    endfunction
    
    function IncHeroAbilityLevelById(unit wu,int id)
        int index = GetHeroAbilityIndex(wu,id)
        IncHeroAbilityLevelByIndex(wu,index)
    endfunction
    
    
    function HeroIncAbility(unit wu,int index)
        int lv = GetHeroAbilityLevel(wu,GetHeroAbilityID(wu,index))
        int use = 0
        if  GetHeroAbilityID(wu,index) == 0
            DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]:技能升级失败！该键位无技能！|r")
        else
            if  lv < 15
                if  lv <= 4
                    use = lv * 100
                elseif  lv <= 9
                    use = lv * 500
                elseif  lv <= 14
                    use = lv * 1000
                endif
                
                if  GetPlayerState(GetOwningPlayer(wu),PLAYER_STATE_RESOURCE_LUMBER) >= use
                    AdjustPlayerStateBJ(-use, GetOwningPlayer(wu), PLAYER_STATE_RESOURCE_LUMBER )
                    IncHeroAbilityLevelByIndex(wu,index)
                else
                    DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]:木材不足"+I2S(use)+"，无法升级！")
                endif
                
            else
                DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]:技能"+GetHeroAbilityName(wu,index)+"升级失败！该技能已经满级！|r")
            endif
        endif
    endfunction
    
    
    function RemAbilityState(unit wu,int id)
        integer pid=GetPlayerId(GetOwningPlayer(wu))
        SetEquipStateOfPlayer(wu,id,-1)
        if      id == 'S034'
            UnitRemoveAbility(wu,'A034'+pid)
        elseif  id == 'S067'
            UnitAddAbility(wu,'A067'+pid)
        endif
    endfunction


    
    function AddAbilityState(unit wu,int id)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        SetEquipStateOfPlayer(wu,id,1)

        if  GetTypeIdData(id,101) != 9
            DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,5,"|cffffcc00[系统]|r:技能"+GetTypeIdString(id,100)+"学习成功！")
            if  GetUnitTypeId(wu) == 'H017'
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
        
    endfunction
    
    
    
    function HeroRemoveAbilityByIndex (unit wu,int index)
        RemAbilityState(wu,GetUnitIntState(wu,110+index))
        SetUnitIntState(wu,110+index,0)
        SetUnitIntState(wu,120+index,0)
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
        SetUnitIntState(wu,110+index,id)
        SetUnitIntState(wu,120+index,1)
        AddAbilityState(wu,id)
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

function SetAbilityCD_AG(unit u,int id,real cd)//设置主动技能CD
    integer lv=GetUnitAbilityLevel(u,id)
    YDWESetUnitAbilityDataReal( u,id, lv, 105, cd )
    YDWESetUnitAbilityState( u,id,1, cd )
endfunction
    


    //InitAbilityData('技能id',技能类型,品质,伤害参数,参数A,参数B,参数C,伤害类型,冷却时间,"技能名称","技能说明","技能图标")
    function InitAbilityData(int id,int Type,int color,int chi,real r1,real r2,real r3,int Damagetype,real cd,string name,string tips,string icon)
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
    endfunction
    
    function AbilityUIInit()
        insert InitAbilityStateData
    endfunction
    
    #undef AbilityUIMax
endlibrary

