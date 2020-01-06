library DamageCode uses UnitStateSet
    int DAMAGE_TYPE_UNKNOWNa       =0
    int DAMAGE_TYPE_NORMALa        =4
    int DAMAGE_TYPE_ENHANCEDa      =5
    int DAMAGE_TYPE_FIREa          =8
    int DAMAGE_TYPE_COLDa          =9
    int DAMAGE_TYPE_LIGHTNINGa     =10
    int DAMAGE_TYPE_POISONa        =11
    int DAMAGE_TYPE_DISEASEa       =12
    int DAMAGE_TYPE_DIVINEa        =13
    int DAMAGE_TYPE_MAGICa         =14
    int DAMAGE_TYPE_SONICa         =15
    int DAMAGE_TYPE_ACIDa          =16
    int DAMAGE_TYPE_FORCEa         =17
    int DAMAGE_TYPE_DEATHa         =18
    int DAMAGE_TYPE_MINDa          =19
    int DAMAGE_TYPE_PLANTa         =20
    int DAMAGE_TYPE_DEFENSIVEa     =21
    int DAMAGE_TYPE_DEMOLITIONa    =22
    int DAMAGE_TYPE_SLOW_POISONa   =23
    int DAMAGE_TYPE_SPIRIT_LINKa   =24
    int DAMAGE_TYPE_SHADOW_STRIKEa =25
    int DAMAGE_TYPE_UNIVERSALa     =26
    
    int ATTACK_TYPE_NORMALa         =0 //正常
    int ATTACK_TYPE_MELEEa          =1 //
    int ATTACK_TYPE_PIERCEa         =2 //穿刺
    int ATTACK_TYPE_SIEGEa          =3 //攻城
    int ATTACK_TYPE_MAGICa          =4 //
    int ATTACK_TYPE_CHAOSa          =5 //混乱
    int ATTACK_TYPE_HEROa           =6 //英雄
    
    
    
    
    
    //闪避
    function GetUnitSbState(unit wu)->real
        real s = GetUnitRealState(wu,10)
        if  s > 70
            s = 70
        endif
        return s
    endfunction
    function GetUnitSb(unit wu)->real
        real s = GetUnitSbState(wu)
        s = s * 0.01
        return s
    endfunction
    
    //免伤
    function GetUnitMsState(unit wu)->real
        real s = GetUnitRealState(wu,11)
        int lv = 0
        if  s > 70
            s = 70
        endif
        return s
    endfunction
    function GetUnitMs(unit wu)->real
        real s = GetUnitMsState(wu)
        s = s * 0.01
        return s
    endfunction
    
    //普攻伤害加强
    function GetUnitPsState(unit wu)->real
        real s = GetUnitRealState(wu,12)
        int lv = 0
        return s
    endfunction
    function GetUnitPs(unit wu)->real
        real s = GetUnitPsState(wu)
        s = s * 0.01
        return s
    endfunction
    
    
    
    
    //物理穿透
    function GetUnitWcState(unit wu)->real
        real s = GetUnitRealState(wu,13)
        if  s > 80
            s = 80
        endif
        return s
    endfunction
    function GetUnitWc(unit wu)->real
        real s = (GetUnitWcState(wu))
        return s*0.01
    endfunction
    
    //法术穿透
    function GetUnitFcState(unit wu)->real
        real s = GetUnitRealState(wu,14)
        if  s > 80
            s = 80
        endif
        return s
    endfunction
    function GetUnitFc(unit wu)->real
        real s = (GetUnitFcState(wu))
        return s*0.01
    endfunction
    
    //获取物理加成结算
    function GetUnitWsState(unit wu)->real
        real s = GetUnitRealState(wu,15)
        real lv = 0
        int uid = GetUnitTypeId(wu)

        if  uid == 'H009'
            if  GetUnitPsState(wu)>= 120
                s = s + 30
            endif
        endif

        return s
    endfunction
    function GetUnitWs(unit wu)->real
        real s = GetUnitWsState(wu)
        
        return s * 0.01
    endfunction
    
    //获取法术加成结算
    function GetUnitFsState(unit wu)->real
        real s = GetUnitRealState(wu,16)
        real lv = 0

        return s
    endfunction
    function GetUnitFs(unit wu)->real
        real s = GetUnitFsState(wu)
        
        return s * 0.01
    endfunction
    
    //获取伤害加成结算
    function GetUnitShState(unit wu)->real
        real s = GetUnitRealState(wu,17)
        if  s > 90
            s = 90
        endif
        return s
    endfunction
    function GetUnitSh(unit wu)->real
        real s = GetUnitShState(wu)
        
        return s * 0.01
    endfunction
    
    
    //获取抵抗加成结算
    function GetUnitDkState(unit wu)->real
        real s = GetUnitRealState(wu,18)
        if  s > 90
            s = 90
        endif
        return s
    endfunction
    function GetUnitDk(unit wu)->real
        real s = GetUnitDkState(wu)
    
        return s * 0.01
    endfunction
    
    
    //暴击
    function GetUnitBjState(unit wu)->real
        real s = GetUnitRealState(wu,19)
        if  s > 100
            s = 100
        endif
        return s
    endfunction
    function GetUnitBj(unit wu)->real
        real s = GetUnitBjState(wu)
        s = s * 0.01
        return s
    endfunction
    
    //暴击伤害
    function GetUnitBsState(unit wu)->real
        real s = GetUnitRealState(wu,20)+150
        return s
    endfunction
    
    function GetUnitBs(unit wu)->real
        real s = GetUnitBsState(wu)
        return s*0.01
    endfunction
    
    //吸血
    function GetUnitWxState(unit wu)->real
        real s = GetUnitRealState(wu,21)
        real lv = 0
        return s
    endfunction
    function GetUnitWx(unit wu)->real
        real s = GetUnitWxState(wu)
        return s*0.01
    endfunction
    
    
    //分裂
    function GetUnitFLState(unit wu)->real
        real s = GetUnitRealState(wu,22)
        return s
    endfunction
    function GetUnitFL(unit wu)->real
        real s = GetUnitFLState(wu)
        return s*0.01
    endfunction
    
    
    //致命概率
    function GetUnitZmState(unit wu)->real
        real s = GetUnitRealState(wu,23)

        
        if  s > 100
            s = 100
        endif
        return s
    endfunction
    function GetUnitZm(unit wu)->real
        real s = GetUnitZmState(wu)
        return s*0.01
    endfunction
    //致命伤害
    function GetUnitZsState(unit wu)->real
        real s = GetUnitRealState(wu,23)+150
        
        return s
    endfunction
    function GetUnitZs(unit wu)->real
        real s = GetUnitZsState(wu)
        return s*0.01
    endfunction
    

    
    //冷却缩减
    function GetUnitLsState(unit wu)->real
        real s = GetUnitRealState(wu,25)
        if  s > 80
            s = 80
        endif
        return s
    endfunction
    function GetUnitLs(unit wu)->real
        real s = GetUnitLsState(wu)
        return 1+s*0.01
    endfunction
    
    //冷却降低
    function GetUnitLjState(unit wu)->real
        real s = GetUnitRealState(wu,26)
        return s
    endfunction
    function GetUnitLj(unit wu)->real
        real s = GetUnitLjState(wu)
        return s
    endfunction
    
    function GetUnitChanceState(unit wu)->real
        real s = GetUnitRealState(wu,27)
        return s
    endfunction
    function GetUnitChance(unit wu)->real
        real s = GetUnitChanceState(wu)
        return s*0.01
    endfunction
    
    function Chance(unit wu,real gl)->bool
        real s = GetUnitChance(wu)
        gl=gl*0.01
        return GetRandomReal(0, 1) <= gl+s
    endfunction
    



    function GetPerHPState(unit wu)->real
        real s = GetUnitRealState(wu,31)
        return s
    endfunction

    function GetPerAPState(unit wu)->real
        real s = GetUnitRealState(wu,32)
        return s
    endfunction

    function GetPerSPState(unit wu)->real
        real s = GetUnitRealState(wu,33)
        return s
    endfunction

    function GetPerASState(unit wu)->real
        real s = GetUnitRealState(wu,34)
        return s
    endfunction

    function GetPerSSState(unit wu)->real
        real s = GetUnitRealState(wu,35)
        return s
    endfunction

    function GetPercentage(unit wu,int index)->real
        if  index == 1
            return  GetPerHP(wu)*0.01
        elseif  index == 2
            return  GetPerAP(wu)*0.01
        elseif  index == 3
            return  GetPerSP(wu)*0.01
        elseif  index == 4
            return  GetPerAS(wu)*0.01
        elseif  index == 5
            return  GetPerSS(wu)*0.01
        endif
        return 0
    endfunction


    
   
 
    
    
    
    
    function SetEquipStateOfPlayer(unit wu,int newid,real offset)
        real value = 0
        
        for i = 1,70
            value = GetTypeIdReal(newid,i)
            if  value != 0
                AddUnitRealState(wu,i,value*offset)
            endif
        end
    endfunction
    
    function SetEquipLvStateOfPlayer(unit wu,int newid,real lv,real offset)
        real value = 0
        
        for i = 1,70
            value = GetTypeIdReal(newid,i)
            if  value != 0
                AddUnitRealState(wu,i,value*offset*lv)
            endif
        end
    endfunction
    
    function RemoveEquipState(unit wu,int eid)
        SetEquipStateOfPlayer(wu,eid,-1)
    end
    function AddEquipState(unit wu,int eid)
        SetEquipStateOfPlayer(wu,eid,1)
    end
    
    function SetPlayerTechResearchedEx(player p,int id)
        int pid = GetPlayerId(p)
        SetPlayerTechResearched(p,id, 1)
        AddEquipState(Pu[1],id)
    end
    
    function IsPlayerHasTech(player whichPlayer,int techid)->boolean
        if  techid == 0
            return true
        endif
        //BJDebugMsg("科技"+GetObjectName(techid)+I2S(GetPlayerTechCount(whichPlayer, techid, true)))
        return GetPlayerTechCount(whichPlayer, techid, true) > 0
    endfunction


    function GetTypeIdIndex(int uid,int minid)->int
        int index = 0
        
        if  uid >= minid + 0x100
            index = uid - minid - 0xF6
        else
            index = uid - minid
        endif

        return index
    endfunction
    function GetUnitLucky(unit wu,real r)->boolean
        int i = R2I(r)
        return GetRandomInt(1,100)<=i
    end
    
    function CalculationNewId(int id,int index)->int //计算新ID
        if  index >= 10
            return id + index + 0xF6
        elseif  index == 0
            return 0
        endif
        return id + index
    endfunction
    
    
    function KillTechMosterFunc(unit wu,int now,int last)->boolean
        int pid = GetPlayerId(GetOwningPlayer(wu))
        if  IsPlayerHasTech(GetOwningPlayer(wu),last) == true//如果拥有上一个
            if  IsPlayerHasTech(GetOwningPlayer(wu),now) == false//如果当前是没有的
                SetPlayerTechResearchedEx(GetOwningPlayer(wu),now)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]|r：恭喜您！"+GetObjectName(now)+"激活成功！")
                return true
            else
                return false
                BJDebugMsg("该科技已经解锁"+GetObjectName(now))
            endif
        else
            BJDebugMsg("不满足解锁条件"+GetObjectName(last)+I2S(last))
            return false
        endif
    endfunction
endlibrary

