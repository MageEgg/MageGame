library SystemCodes uses ServerTime,Define1

    //添加辅助技能 目标，id，时间
    function UnitTimerAddSkillFunc()
        timer t = GetExpiredTimer()
        unit wu = LoadUnitHandle(ht,GetHandleId(t),1)
        int i = LoadInteger(ht,GetHandleId(t),2)
        UnitRemoveAbility(wu,i)
        FlushChildHashtable(ht,GetHandleId(t))
        DestroyTimer(t)
        t = null
        wu = null
    endfunction
    function UnitTimerAddSkill(unit wu,int i,real time)
        timer t = CreateTimer()
        UnitAddAbility(wu,i)
        SaveUnitHandle(ht,GetHandleId(t),1,wu)
        SaveInteger(ht,GetHandleId(t),2,i)
        TimerStart(t,time,false,function UnitTimerAddSkillFunc)
        t = null
    endfunction
    
    function GetPlayerNameOfColor(int pid)->string
        return "玩家<"+PlayerColor+GetPlayerName(Player(pid))+"|r>"
    endfunction

    function IsPlaying(int pid)->bool
        if GetPlayerController(Player(pid)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(pid)) == PLAYER_SLOT_STATE_PLAYING
            return true
        else
            return false
        endif
    endfunction

    
    function PlayerSelectOneUnit(int pid,unit u)
        if  Player(pid)==GetLocalPlayer()
            ClearSelection()
            SelectUnit(u,true)
        endif
    endfunction

    function IsLocInRect(rect r,real x,real y)->bool
        return (GetRectMinX(r) <= x) and (x <= GetRectMaxX(r)) and (GetRectMinY(r) <= y) and (y <= GetRectMaxY(r))
    endfunction
    
    function SetPlayerCameraBoundsToRect(rect r)
        real minX = GetRectMinX(r)
        real minY = GetRectMinY(r)
        real maxX = GetRectMaxX(r)
        real maxY = GetRectMaxY(r)
        SetCameraBounds(minX, minY, minX, maxY, maxX, maxY, maxX, minY)
    endfunction

    function SetPlayerUnitPostion(unit u1,real x,real y) //移动单位+镜头
        if GetLocalPlayer() == GetOwningPlayer(u1)
            PanCameraToTimed( x, y, 0 )
        endif
        SetUnitPosition(u1,x,y)
    endfunction
    
     function SetPlayerUnitPostionSelectUnit(unit u1,real x,real y,unit su) //移动单位+镜头+选择单位
        if GetLocalPlayer() == GetOwningPlayer(u1)
            PanCameraToTimed( x, y, 0 )
            ClearSelection()
            SelectUnit(su,true)
        endif
        SetUnitPosition(u1,x,y)
    endfunction

    function SetPlayerMap(int id,int n)
        int pid = id
        int index = n
        TimerStart(0.05,false)
        {   
            if  GetLocalPlayer() == Player(pid)
                DzSetWar3MapMap( "war3mapMap"+I2S(index)+".blp" )
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction

    function SendPlayerUnit(int pid,real x,real y) //通用单位传送
        if  GetUnitAbilityLevel(Pu[1],'AZ98') == 0
            UnitTimerAddSkill(Pu[1],'AZ98',0.1)
        endif
        if  IsLocInRect(gg_rct_GameRect,x,y) == true
            //小图
            if  GetLocalPlayer() == Player(pid)
                SetPlayerCameraBoundsToRect(gg_rct_GameRect)
            endif
            SetPlayerMap(pid,2)
        else
            //大图
            if  IsLocInRect(gg_rct_GameRect,GetUnitX(Pu[1]),GetUnitY(Pu[1])) == true and IsLocInRect(gg_rct_GameRect,x,y) == false
                if  GetLocalPlayer() == Player(pid)
                    SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
                endif
            endif
            SetPlayerMap(pid,1)
        endif
        DestroyEffect(AddSpecialEffect("effect_az_goods_lvlup(3).mdl",GetUnitX(Pu[1]),GetUnitY(Pu[1])))
        SetPlayerUnitPostion(Pu[1],x,y)
        DestroyEffect(AddSpecialEffect("effect_effect_az_goods_tp_target_effect(4).mdl",x,y))
        PlayerSelectOneUnit(pid,Pu[1])

    endfunction

    function SendPlayerUnitBarringCamera(int pid,real x,real y) //通用单位传送
        if  GetUnitAbilityLevel(Pu[1],'AZ98') == 0
            UnitTimerAddSkill(Pu[1],'AZ98',0.1)
        endif
        if  IsLocInRect(gg_rct_GameRect,x,y) == true
            //小图
            if  GetLocalPlayer() == Player(pid)
                SetPlayerCameraBoundsToRect(gg_rct_GameRect)
            endif
            SetPlayerMap(pid,2)
        else
            //大图
            if  IsLocInRect(gg_rct_GameRect,GetUnitX(Pu[1]),GetUnitY(Pu[1])) == true and IsLocInRect(gg_rct_GameRect,x,y) == false
                if  GetLocalPlayer() == Player(pid)
                    SetPlayerCameraBoundsToRect(bj_mapInitialPlayableArea)
                endif
            endif
            SetPlayerMap(pid,1)
        endif
        DestroyEffect(AddSpecialEffect("effect_az_goods_lvlup(3).mdl",GetUnitX(Pu[1]),GetUnitY(Pu[1])))
        SetUnitPosition(Pu[1],x,y)
        DestroyEffect(AddSpecialEffect("effect_effect_az_goods_tp_target_effect(4).mdl",x,y))
        PlayerSelectOneUnit(pid,Pu[1])
    endfunction
    
    function Sdofplayer(player pp,real x ,real y,real time) //地图信号
        if pp == GetLocalPlayer()
            PingMinimap(x,y,time)
        endif
    endfunction
    
    function GetUnitZ(unit u)->real //获取高度
        location p = GetUnitLoc(u)
        real z = GetUnitFlyHeight(u)+GetLocationZ(p)
        RemoveLocation(p)
        p = null
        return z
    endfunction
    
    func GetDamageType()->damagetype
        return ConvertDamageType(EXGetEventDamageData(4))
    end
    func GetWeaponType()->weapontype
        return ConvertWeaponType(EXGetEventDamageData(5))
    end
    func GetAttackType()->attacktype
        return ConvertAttackType(EXGetEventDamageData(6))
    end
    
    function R2S0(real r)->string
        int l = StringLength(R2S(r))
        return SubString(R2S(r),0,l-4)
    endfunction

    func R2S2(real r)->string
        int l = StringLength(R2S(r))
        if r > 1000
            return I2S(R2I(r))
        endif
        return SubString(R2S(r),0,l-2)
    end
    func R2S1(real r)->string
        int l = StringLength(R2S(r))
        if r >= 10000
            return I2S(R2I(r)/10000)+"W"
        elseif r > 100
            return I2S(R2I(r))
        endif
        return SubString(R2S(r),0,l-2)
    end
    func DR2S(real r)->string
        int l = StringLength(R2S(r))
        if r >= 100000000
            return SubString(R2S(r),0,l-12)+"亿"
        elseif r >= 1000000
            return SubString(R2S(r),0,l-8)+"万"
        endif
        return SubString(R2S(r),0,l-4)
    end
    func R2SI(real r)->string
        int l = StringLength(R2S(r))
        return SubString(R2S(r),0,l-2)
    end


    //获取属性 横向拼接
    function GetTypeIdStateTips2(int id)->string
        string s = ""
        real value = 0

        value = GetTypeIdReal(id,5)
        if  value > 0
            s = s + "," + StateName[5] + "+" + I2S(R2I(value)) + StateName[5+1000]
        endif
        for i = 1,70
            if  i != 5
                value = GetTypeIdReal(id,i)
                if  value > 0
                    s = s + "," + StateName[i] + "+" + I2S(R2I(value)) + StateName[i+1000]
                endif
            endif
            
        end
        return  s
    endfunction
    //获取基础属性
    function GetTypeIdStateTips(int id)->string
        string s = ""
        real value = 0

        value = GetTypeIdReal(id,5)
        if  value > 0
            s = s + "\n" + StateName[5] + "+" + I2S(R2I(value)) + StateName[5+1000]
        endif
        for i = 1,70
            if  i != 5
                value = GetTypeIdReal(id,i)
                if  value > 0
                    s = s + "\n" + StateName[i] + "+" + I2S(R2I(value)) + StateName[i+1000]
                endif
            endif
            
        end
        return  s
    endfunction
    function GetTypeIdName(int id)->string
        string s = LoadStr(ht,id,100)
        if  s != "" and s != null
            return s
        else
            return GetObjectName(id)
        endif
    endfunction
    function GetTypeIdIcon(int id)->string
        string s = LoadStr(ht,id,101)
        if  s != "" and s != null
            //BJDebugMsg("hash"+s)
            return s
        else
            //BJDebugMsg("slk"+YDWEGetItemDataString(id, 1))
            return YDWEGetItemDataString(id, 1)
        endif
    endfunction
    function GetTypeIdTips(int id)->string
        string s = LoadStr(ht,id,102)
        if  s != "" and s != null
            return s
        else
            return YDWEGetItemDataString(id,3)
        endif
    endfunction
    function GetTypeIdColor(int id)->string
        int color = LoadInteger(ht,id,101)
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

    function KillUnitTimer(unit wu,real time)
        unit u1 = wu
        TimerStart(time,false)
        {
            if  GetUnitState(u1,UNIT_STATE_LIFE) >= 0.4
                KillUnit(u1)
            endif
            endtimer
            flush locals
        }
        flush locals
    endfunction
    function RemoveUnitTimerFunc()
        timer t = GetExpiredTimer()
        unit u1 = LoadUnitHandle(ht,GetHandleId(t),1)
        RemoveUnit(u1)
        FlushChildHashtable(ht,GetHandleId(t))
        DestroyTimer(t)
        t = null
        u1 = null
    endfunction
    function RemoveUnitTimer(unit wu,real time)
        timer t = CreateTimer()
        SaveUnitHandle(ht,GetHandleId(t),1,wu)
        TimerStart(t,time,false,function RemoveUnitTimerFunc)
        t = null
    endfunction

    function  hyred(unit u1) 
    unit u=u1
    integer i=0
        TimerStart(0.02,true)
        {
            i=i+1
            if i <=10
                SetUnitScale(u, 1+(i*0.1), 1+(i*0.1), 1+(i*0.1))
                SetUnitVertexColor(u,255, 0, 0, 255-(R2I(I2R(i)*25.5)))
            else
                RemoveUnit(u)
                u=null
                endtimer
            endif
        }
    endfunction  

    
    function Udis(unit u,unit u2)->real //单位间距离
        return Pow((GetUnitX(u)-GetUnitX(u2))*(GetUnitX(u)-GetUnitX(u2))+(GetUnitY(u)-GetUnitY(u2))*(GetUnitY(u)-GetUnitY(u2)),0.5)
    endfunction
    
    function Pdis(real x,real y,real x2,real y2)->real
        return Pow((x-x2)*(x-x2)+(y-y2)*(y-y2),0.5)
    endfunction
    function Pang(real x, real y, real x1, real y1)->real //点到点角度
        return(Atan2(y1-y,x1-x))
    endfunction
    function Uang(unit u,unit u2)->real //单位到单位角度
        return(Atan2(GetUnitY(u2)-GetUnitY(u),GetUnitX(u2)-GetUnitX(u)))
    endfunction
    
    function AddPlayerState(int pid,playerstate whichPlayerState,integer value)
        SetPlayerState(Player(pid),whichPlayerState,GetPlayerState(Player(pid),whichPlayerState)+value)
    endfunction

    //物品处理
    function AddItemCharges(unit wu,item wi)
        int ItemId = GetItemTypeId(wi)
        int num = GetItemCharges(wi)
        int thisnum = 0
        item thisitem = null
        int max = 999
        
        for i = 0,5
            thisitem = UnitItemInSlot(wu,i)
            if  GetItemTypeId(thisitem) == ItemId and wi!=thisitem
                thisnum = GetItemCharges(thisitem)+num
                if  thisnum > max
                    SetItemCharges(thisitem,max)
                    num = thisnum - max
                    SetItemCharges(wi,num)
                else
                    SetItemCharges(thisitem,thisnum)
                    RemoveItem(wi)
                    num = 0
                    exitwhen true
                endif
            endif
        end
        
        flush locals
    endfunction
    function IsUnitHasItem(unit wu,int id)->bool
        for n = 0,5
            if GetItemTypeId(UnitItemInSlot(wu,n))==id
                return true
            endif
        end
        return false
    endfunction


    
    function RemoveUnitHasItem(unit wu,int id)->bool
        for n = 0,5
            if GetItemTypeId(UnitItemInSlot(wu,n))==id
                RemoveItem(UnitItemInSlot(wu,n))
                return true
            endif
        end
        return false
    endfunction
    
    function IsUnitHasItemType(unit wu,item it)->bool
        int id = GetItemTypeId(it)
        for n = 0,5
            if  GetItemTypeId(UnitItemInSlot(wu,n)) == id and UnitItemInSlot(wu,n) != it
                return true
            endif
        end
        return false
    endfunction

    #define UnitHasItemOfType IsUnitHasItemType

    function UnitHasItemOfTypeReNum(unit u,int itid)->int
        int a = 0
        int re = -1
        for num = 0,5
            if  GetItemTypeId(UnitItemInSlot(u,num)) == itid
                re = num
                exitwhen true
            endif
        end
        return re
    endfunction

    function UnitCanGetItem(unit u)->bool //能否添加物品
        bool J = false
        for num = 0,5
            if  GetItemTypeId(UnitItemInSlot(u,num)) == 0
                J = true
            endif
        end
        return J
    endfunction


    function UnitAddItemExEx(unit u,item it)
        int pid = GetPlayerId(GetOwningPlayer(u))
        if  u == Pu[1]
            if  UnitCanGetItem(u) == true or IsItemPowerup(it) == true 
                UnitAddItem(u,it)
            else
                SetItemPosition(it,GetUnitX(Pu[2]),GetUnitY(Pu[2]))
                UnitAddItem(Pu[2],it)
                DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r英雄背包已满！物品自动传送至助手！")
            endif
        else
            UnitAddItem(u,it)
        endif

    endfunction

    function UnitAddItemEx(unit u,int itid)
        UnitAddItemExEx(u,CreateItem(itid,GetUnitX(u),GetUnitY(u)))
    endfunction

    function RemoveItemEx(unit u,int itid)//删除英雄所有可贩卖的物品
        int a = 0
        for num = 0,5
            if  GetItemTypeId(UnitItemInSlot(u,num)) == itid
                if  IsItemPawnable(UnitItemInSlot(u,num)) == true
                    SetItemPawnable(UnitItemInSlot(u,num),false)
                endif
                RemoveItem(UnitItemInSlot(u,num))
                exitwhen true
            endif
        end
    endfunction

    function UseItemEx(unit u,int itid)
        int a = 0
        int n = 0
        for num = 0,5
            if  GetItemTypeId(UnitItemInSlot(u,num)) == itid
                n = GetItemCharges(UnitItemInSlot(u,num))
                if  n > 1 
                    SetItemCharges(UnitItemInSlot(u,num),n-1)
                else
                    RemoveItem(UnitItemInSlot(u,num))
                endif
                exitwhen true
            endif
        end
    endfunction

    function ReturnPlayerBuyItemUse(int pid,int id)//返还物品资源消耗
        int gold = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_ITEM, id, "goldcost")
        int lumber = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_ITEM, id, "lumbercost")
        if  gold > 0
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,gold)
        endif
        if  lumber > 0
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,lumber)
        endif
    endfunction
    
    function ConsumePlayerBuyItemUse(int pid,int id)//扣除物品资源消耗
        int gold = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_ITEM, id, "goldcost")
        int lumber = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_ITEM, id, "lumbercost")
        if  gold > 0
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,-gold)
        endif
        if  lumber > 0
            AddPlayerState(pid,PLAYER_STATE_RESOURCE_LUMBER,-lumber)
        endif
    endfunction

    function SetGameBGM(string music) //设置音乐
        StopMusic(false)
        ClearMapMusic()
        PlayMusic(music)
    endfunction

    int IsCanFlyNum = 0
    func IsCanFlyRcetFunc()
        if  GetEnumDestructable() != null
            IsCanFlyNum = IsCanFlyNum + 1
        endif
    end
    
    func IsCanFlyRcet(real x,real y)->bool
        rect rc = Rect(x - 80, y - 80, x + 80, y + 80)
        IsCanFlyNum = 0
        EnumDestructablesInRect(rc,null,function IsCanFlyRcetFunc)
        RemoveRect(rc)
        rc = null
        return IsCanFlyNum == 0
    end

    func IsCanFlyTerrain(real x,real y)->bool
        return IsTerrainPathable(x,y,PATHING_TYPE_WALKABILITY) == false and IsCanFlyRcet(x,y) == true
    end
    
    //坐标防止溢出
    function SetUnitXEx(unit wu,real x)
        if x > GetRectMaxX(bj_mapInitialPlayableArea)
            x = GetRectMaxX(bj_mapInitialPlayableArea)
        elseif x < GetRectMinX(bj_mapInitialPlayableArea)
            x = GetRectMinX(bj_mapInitialPlayableArea)
        endif
        SetUnitX(wu,x)
    endfunction
    function SetUnitYEx(unit wu,real y)
        if y > GetRectMaxY(bj_mapInitialPlayableArea)
            y = GetRectMaxY(bj_mapInitialPlayableArea)
        elseif y < GetRectMinY(bj_mapInitialPlayableArea)
            y = GetRectMinY(bj_mapInitialPlayableArea)
        endif
        SetUnitY(wu,y)
    endfunction
    function SetUnitXY(unit wu,real x,real y)
        if x > GetRectMaxX(bj_mapInitialPlayableArea)
            x = GetRectMaxX(bj_mapInitialPlayableArea)
        elseif x < GetRectMinX(bj_mapInitialPlayableArea)
            x = GetRectMinX(bj_mapInitialPlayableArea)
        endif
        if y > GetRectMaxY(bj_mapInitialPlayableArea)
            y = GetRectMaxY(bj_mapInitialPlayableArea)
        elseif y < GetRectMinY(bj_mapInitialPlayableArea)
            y = GetRectMinY(bj_mapInitialPlayableArea)
        endif
        SetUnitPosition(wu,x,y)
    endfunction

    function SetUnitFaceOfUnit(unit wu,unit tu)
        real ang = Atan2(GetUnitY(tu)-GetUnitY(wu),GetUnitX(tu)-GetUnitX(wu))
        SetUnitFacing(wu,ang/0.01745)
    endfunction
    
    function SetUnitFaceOfAng(unit wu,real ang)
        SetUnitFacing(wu,ang/0.01745)
    endfunction
    
    function GetUnitScaleSize(unit u)->real
        return YDWEGetObjectPropertyReal(YDWE_OBJECT_TYPE_UNIT,GetUnitTypeId(u),"modelscale")
    endfunction
    
    #define GetUnitScale   GetUnitScaleSize
    
    ///////////////////////////区域注册////////////////////////////
    function CreateTrigUnitInRange(unit u,real rac,code actionFunc)
        trigger tig = null
        tig = CreateTrigger()
        TriggerRegisterUnitInRange(tig,u,rac,null)
        TriggerAddAction(tig, actionFunc)
        tig = null
        u = null
    endfunction

    ///////////////////////////异步函数////////////////////////////
    function ShowUnitOfOnlyPlayerEx(unit wu)
        int uid = GetUnitTypeId(wu)
        int r = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_UNIT,uid,"red")
        int g = 100
        int b = 100
        int ap = 100
        if  GetOwningPlayer(wu) == GetLocalPlayer()
            g = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_UNIT,uid,"green")
            b = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_UNIT,uid,"blue")
            ap = 255
        endif
        SetUnitVertexColor(wu,r,g,b,ap)
    endfunction

    function ShowUnitOfOnlyPlayer(int pid,unit wu,int value)
        int uid = GetUnitTypeId(wu)
        int r = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_UNIT,uid,"red")
        int g = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_UNIT,uid,"green")
        int b = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_UNIT,uid,"blue")
        int ap = value
        if  Player(pid) == GetLocalPlayer()
            ap = 255
        endif
        SetUnitVertexColor(wu,r,g,b,ap)
    endfunction
    
    function ShowUnitOfAllPlayer(unit wu)
        int uid = GetUnitTypeId(wu)
        int r = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_UNIT,uid,"red")
        int g = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_UNIT,uid,"green")
        int b = YDWEGetObjectPropertyInteger(YDWE_OBJECT_TYPE_UNIT,uid,"blue")
        SetUnitVertexColor(wu,r,g,b,255) 
    endfunction

    function PauseAllUnitsFunc()
        PauseUnit(GetEnumUnit(),bj_pauseAllUnitsFlag)
    endfunction
    
    function PauseAllUnits(bool pause)
        integer index = 0
        player p = null
        group g = CreateGroup()
        bj_pauseAllUnitsFlag = pause
        loop
            p = Player(index)
            if  GetPlayerController(p) == MAP_CONTROL_COMPUTER
                PauseCompAI(p,pause)
            endif
            GroupEnumUnitsOfPlayer(g,p,null)
            ForGroup(g,function PauseAllUnitsFunc)
            GroupClear( g )
            index = index + 1
            exitwhen index == bj_MAX_PLAYER_SLOTS
        endloop
        GroupClear(g)
        DestroyGroup(g)
        g = null
        p = null
    endfunction

    function RectAlocCondition()->bool
        return GetUnitAbilityLevel(GetTriggerUnit(),'Aloc') == 0
    endfunction

    function InitRctEventFunc(rect rec,bool in,code cod)
        trigger trig = CreateTrigger()
        region rectRegion = CreateRegion()
        RegionAddRect(rectRegion, rec)
        if  in == true
            TriggerRegisterEnterRegion(trig, rectRegion, null)
        else
            TriggerRegisterLeaveRegion(trig, rectRegion, null)
        endif
        TriggerAddCondition(trig,Condition(function RectAlocCondition))
        TriggerAddAction(trig, cod)
        trig = null
        rectRegion = null
    endfunction

    //////////////////////////////////顺序调整分割///////////////////////////////////////

    function HeroMoveToHome(int pid)
        SendPlayerUnit(pid,PlayerReviveX,PlayerReviveY)
    endfunction

    function SetPlayerOnlyDamage(unit u,int pid)
        UnitAddAbility(u,'AZ99')
        SetUnitAbilityLevel(u,'AZ99',pid+1)
    endfunction

    function RemovePlayerOnlyDamage(unit u,int pid)
        if  GetUnitAbilityLevel(u,'AZ99') > 0
            UnitRemoveAbility(u,'AZ99')
        endif
    endfunction

    //完成任务 奖励时渊
    function GivePlayerMissionPrize(int pid,int techid)
        if  GetPlayerTechCount(Player(pid),techid,true) == 0
            AddPlayerTechResearched(Player(pid),techid,1)
            UnitAddItem(Pu[2],CreateItem('IP01',GetUnitX(Pu[2]),GetUnitY(Pu[2])))
            DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]：|r恭喜您|cffffcc00"+GetObjectName(techid)+"|r，奖励|cffff0000时渊入场券|rx1。") 
        endif
    endfunction
    
endlibrary

library UnitRanDropItem initializer InitAllFunc uses SystemCodes
//物品奖池 掉落

    
        scope PrizePool

        int array PrizePoolData[80][200]

        //获取奖励id
        function GetPrizeData(int page,int pool,int index)->int
            return PrizePoolData[page*20+pool][index]
        endfunction

        //设置奖励id
        function SetPrizeData(int page,int pool,int index,int id)
            PrizePoolData[page*20+pool][index] = id
        endfunction

        //获取最大值
        function GetPrizePoolMax(int page,int pool)->int
            return PrizePoolData[page*20+pool][200]
        endfunction

        //设置最大值
        function SetPrizePoolMax(int page,int pool,int max)
            PrizePoolData[page*20+pool][200] = max
        endfunction


        //增加最大值
        function AddPrizePoolMax(int page,int pool,int add)
            PrizePoolData[page*20+pool][200] = GetPrizePoolMax(page,pool)+add
        endfunction

        //根据id寻找序号
        function FindPrizePool(int page,int pool,int id)->int
            int max = GetPrizePoolMax(page,pool)
            for i = 1,max
                if  GetPrizeData(page,pool,i) == id
                    return i
                endif
            end
            return 0
        endfunction

        //移除奖励
        function RemPrizeData(int page,int pool,int index)
            int max = GetPrizePoolMax(page,pool)
            SetPrizeData(page,pool,index,GetPrizeData(page,pool,max))
            SetPrizeData(page,pool,max,0)
            AddPrizePoolMax(page,pool,-1)
        endfunction

        //获取一个奖励，是否移除
        function GetPrize(int page,int pool,bool rem)->int
            int max = GetPrizePoolMax(page,pool)
            int index = GetRandomInt(1,max)
            int id = GetPrizeData(page,pool,index)
            int id2 = GetPrizeData(page,pool,max)
            BJDebugMsg("max id is "+GetTypeIdName(id2)+" max"+I2S(max))
            if  rem == true
                RemPrizeData(page,pool,index)
            endif
            return id
        endfunction

        function ShowPrizeList(int page,int pool)
            int max = GetPrizePoolMax(page,pool)
            //("max is "+I2S(max))
            for i = 1,max
                BJDebugMsg(I2S(i)+" is "+LoadStr(ht,GetPrizeData(page,pool,i),100))
            end

            
        endfunction


        //技能奖池修正
            
        function RecoveryPrizePoolData(int page,int pool,int id)
            BJDebugMsg(GetTypeIdName(id)+"回收"+I2S(pool))
            AddPrizePoolMax(page,pool,1)
            SetPrizeData(page,pool,GetPrizePoolMax(page,pool),id)
        endfunction

        function RegisterPrizePoolData(int page,int pool,int id)

            
            AddPrizePoolMax(page,pool,1)
            SetPrizeData(page,pool,GetPrizePoolMax(page,pool),id)
            
        endfunction
        
    endscope


    
    scope Dorp

        int DropUnitNum = 1
        int array DropUnitID
        int array UnitDropItemID[3][1000]
        real array UnitDropItemRan[3][1000]
        
        function UnitRanDropItemData(int u,int i1,real r1,int i2,real r2,int i3,real r3)
            DropUnitNum = DropUnitNum + 1
            DropUnitID[DropUnitNum] = u
            UnitDropItemID[0][DropUnitNum] = i1
            UnitDropItemID[1][DropUnitNum] = i2
            UnitDropItemID[2][DropUnitNum] = i3
            UnitDropItemRan[0][DropUnitNum] = r1
            UnitDropItemRan[1][DropUnitNum] = r2
            UnitDropItemRan[2][DropUnitNum] = r3
        endfunction

        /*function DropItemTimerFunc()
            timer t = GetExpiredTimer()
            item it = LoadItemHandle(ht,GetHandleId(t),1)
            int time = GetItemUserData(it) - 1
            
            if  time > 0 and GetItemPlayer(it)!= Player(PLAYER_NEUTRAL_PASSIVE)
                SetItemUserData(it,time)
            else
                SetItemPlayer(it,Player(PLAYER_NEUTRAL_PASSIVE),true)
                FlushChildHashtable(ht,GetHandleId(t))
                DestroyTimer(t)
            endif
            t = null
            it = null
        endfunction*/

        function RanDropItem(unit wu,int pid)
            unit u1 = wu
            int max = DropUnitNum
            real ran = 0
            for i = 0,max
                if  GetUnitTypeId(u1) == DropUnitID[i]
                    for n = 0,2
                        ran = UnitDropItemRan[n][i]
                        if  GetRandomReal(1,100) <= ran and ran != 0
                            CreateItem(UnitDropItemID[n][i],GetUnitX(u1),GetUnitY(u1))
                            DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl",u1,"origin"))
                        endif
                    end
                    exitwhen true
                endif
            end
            flush locals
        endfunction
    endscope

    scope UnitPool

        int array HeroPool
        int HeroPoolMax = 0

        function GetHeroPoolType()->int
            return HeroPool[GetRandomInt(1,HeroPoolMax)]
        endfunction

        function GetHeroPoolTypeNew(int id)->int
            int newid = GetHeroPoolType() 
            if  newid == id
                BJDebugMsg("重复递归")
                return GetHeroPoolTypeNew(id)
            endif
            return newid
        endfunction

        

        function HeroPoolAddType(int id)
            HeroPoolMax = HeroPoolMax + 1
            HeroPool[HeroPoolMax] = id
        endfunction

        function InitHeroPoolFunc()
            //开英雄别忘了开对应的熟练度
            HeroPoolAddType('H001')
            HeroPoolAddType('H002')
            HeroPoolAddType('H003')
            HeroPoolAddType('H004')
            HeroPoolAddType('H005')
            //HeroPoolAddType('H006')
            //HeroPoolAddType('H007')
            HeroPoolAddType('H008')
            HeroPoolAddType('H009')
            HeroPoolAddType('H010')
            HeroPoolAddType('H011')
            HeroPoolAddType('H012')
            HeroPoolAddType('H013')
            HeroPoolAddType('H014')
            HeroPoolAddType('H015')
            HeroPoolAddType('H016')
            HeroPoolAddType('H017')
            HeroPoolAddType('H018')
            HeroPoolAddType('H019')
            HeroPoolAddType('H020')
            HeroPoolAddType('H021')
            HeroPoolAddType('H022')
            HeroPoolAddType('H023')
            HeroPoolAddType('H024')
            HeroPoolAddType('H025')
            HeroPoolAddType('H026')
            HeroPoolAddType('H027')
            HeroPoolAddType('H028')
            HeroPoolAddType('H029')
            HeroPoolAddType('H030')
            //HeroPoolAddType('H031')

        endfunction


    endscope

    scope ItemPool
        itempool array ItemPool


        function UnitAddPoolItem(unit wu,int index)->int
            int id = 0
            bj_lastCreatedItem = PlaceRandomItem(ItemPool[index],GetUnitX(wu),GetUnitY(wu))
            id = GetItemTypeId(bj_lastCreatedItem)
            UnitAddItemExEx(wu,bj_lastCreatedItem)
            return id
        endfunction
        function GetPoolItemId(int index)->int
            int id = 0
            bj_lastCreatedItem = PlaceRandomItem(ItemPool[index],0,0)
            id = GetItemTypeId(bj_lastCreatedItem)
            RemoveItem(bj_lastCreatedItem)
            return id
        endfunction
        function RegisterItemPool(int index,int id,real r)
            ItemPoolAddItemType(ItemPool[index],id,r)
        endfunction

        function InitUnitPoolFunc()
            for i = 1,31
                ItemPool[i] = CreateItemPool()
            end
            //炽星魔盒IN31注册
            RegisterItemPool(17,'IP04',3)
            RegisterItemPool(17,'IP02',5)
            RegisterItemPool(17,'IP03',1)
            RegisterItemPool(17,'IN08',2)
            RegisterItemPool(17,'IN13',3)
            RegisterItemPool(17,'IN23',2)
            RegisterItemPool(17,'IN34',6)
            RegisterItemPool(17,'IN37',6)
            RegisterItemPool(17,'IN40',6)
            RegisterItemPool(17,'IN18',2)
            RegisterItemPool(17,'IN20',3)
            RegisterItemPool(17,'I015',3)
            RegisterItemPool(17,'CS21',2)
            RegisterItemPool(17,'CS22',2)
            RegisterItemPool(17,'IP01',2)
            RegisterItemPool(17,'CS01',3)
            
            //幸运星盒IN30注册
            RegisterItemPool(15,'IN07',3)
            RegisterItemPool(15,'IN08',1)
            RegisterItemPool(15,'IN09',5)
            RegisterItemPool(15,'IN10',3)
            RegisterItemPool(15,'IN11',2)
            RegisterItemPool(15,'IN13',1)
            RegisterItemPool(15,'IN14',2)
            RegisterItemPool(15,'IN15',1)
            RegisterItemPool(15,'IN17',6)
            RegisterItemPool(15,'IN18',2)
            RegisterItemPool(15,'IN20',2)
            RegisterItemPool(15,'IN21',14)
            RegisterItemPool(15,'IN22',5)

            RegisterItemPool(15,'IN24',14)
            RegisterItemPool(15,'IN33',4)
            RegisterItemPool(15,'IN34',2)
            RegisterItemPool(15,'IN35',14)
            RegisterItemPool(15,'IN36',4)
            RegisterItemPool(15,'IN37',2)
            RegisterItemPool(15,'IN38',14)
            RegisterItemPool(15,'IN39',4)
            RegisterItemPool(15,'IN40',2)
            RegisterItemPool(15,'CS23',3)
            RegisterItemPool(15,'CS04',3)
            RegisterItemPool(15,'CS05',3)
            
        endfunction


    endscope



    function InitAllFunc()
        ExecuteFunc("InitHeroPoolFunc")
        ExecuteFunc("InitUnitPoolFunc")
    endfunction
    
endlibrary


