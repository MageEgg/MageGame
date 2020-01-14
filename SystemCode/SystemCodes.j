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

    //获取基础属性
    function GetTypeIdStateTips(int id)->string
        string s = ""
        real value = 0
        for i = 1,60
            value = GetTypeIdReal(id,i)
            if  value > 0
                s = s + "\n" + StateName[i] + "+" + R2S2(value) + StateName[i+1000]
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

    function UnitAddItemEx(unit u,int itid)
        UnitAddItem(u,CreateItem(itid,GetUnitX(u),GetUnitY(u)))
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
        rect rc = Rect(x - 90, y - 90, x + 90, y + 90)
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

    //////////////////////////////////顺序调整分割///////////////////////////////////////



    
endlibrary
library UnitRanDropItem initializer InitAllFunc uses SystemCodes
//物品奖池 掉落

    
        scope PrizePool

        int array PrizePoolData[80][101]
        



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
            return PrizePoolData[page*20+pool][100]
        endfunction

        //设置最大值
        function SetPrizePoolMax(int page,int pool,int max)
            PrizePoolData[page*20+pool][100] = max
        endfunction


        //增加最大值
        function AddPrizePoolMax(int page,int pool,int add)
            PrizePoolData[page*20+pool][100] = GetPrizePoolMax(page,pool)+add
        endfunction

        //获取一个奖励，是否移除
        function GetPrize(int page,int pool,bool rem)->int
            int max = GetPrizePoolMax(page,pool)
            int index = GetRandomInt(1,max)
            int id = GetPrizeData(page,pool,index)
            if  rem == true
                SetPrizeData(page,pool,index,GetPrizeData(page,pool,max))
                SetPrizeData(page,pool,max,0)
                AddPrizePoolMax(page,pool,-1)
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
            if  pool >= 4 and pool <= 5
                pool = 4
            elseif  pool >= 6 and pool <= 8
                pool = 5
            endif

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
        
        func UnitRanDropItemData(int u,int i1,real r1,int i2,real r2,int i3,real r3)
            DropUnitNum = DropUnitNum + 1
            DropUnitID[DropUnitNum] = u
            UnitDropItemID[0][DropUnitNum] = i1
            UnitDropItemID[1][DropUnitNum] = i2
            UnitDropItemID[2][DropUnitNum] = i3
            UnitDropItemRan[0][DropUnitNum] = r1
            UnitDropItemRan[1][DropUnitNum] = r2
            UnitDropItemRan[2][DropUnitNum] = r3
        end

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
        unitpool HeroPool = CreateUnitPool() 

        function InitHeroPoolFunc()
            
            for i = 1,9
                UnitPoolAddUnitType( HeroPool, 'H000'+i, 1 )
            end
            for i2 = 0,9
                UnitPoolAddUnitType( HeroPool, 'H010'+i2, 1 )
                UnitPoolAddUnitType( HeroPool, 'H020'+i2, 1 )
            end
            UnitPoolAddUnitType( HeroPool, 'H030', 1 )
            UnitPoolAddUnitType( HeroPool, 'H031', 1 )
            
//UnitPoolAddUnitType( HeroPool, 'H028', 1 )
        endfunction


    endscope

    scope ItemPool
        itempool array ItemPool

        function UnitAddPoolItem(unit wu,int index)->int
            int id = 0
            bj_lastCreatedItem = PlaceRandomItem(ItemPool[index],GetUnitX(wu),GetUnitY(wu))
            id = GetItemTypeId(bj_lastCreatedItem)
            UnitAddItem(wu,bj_lastCreatedItem)
            return id
        endfunction
        function GetPoolItemId(int index)->int
            int id = 0
            bj_lastCreatedItem = PlaceRandomItem(ItemPool[index],0,0)
            id = GetItemTypeId(bj_lastCreatedItem)
            RemoveItem(bj_lastCreatedItem)
            return id
        endfunction

        function InitUnitPoolFunc()
            for i = 1,5
                ItemPool[i] = CreateItemPool()
            end

            ItemPoolAddItemType(ItemPool[1],'IN01',4)
            ItemPoolAddItemType(ItemPool[1],'IN02',4)
            ItemPoolAddItemType(ItemPool[1],'IN03',4)
            ItemPoolAddItemType(ItemPool[1],'IN04',1)
            ItemPoolAddItemType(ItemPool[1],'IN05',1)
            ItemPoolAddItemType(ItemPool[1],'IN06',1)
            ItemPoolAddItemType(ItemPool[1],'IN07',2)
            ItemPoolAddItemType(ItemPool[1],'IN08',2)
            ItemPoolAddItemType(ItemPool[1],'IN09',3)
            ItemPoolAddItemType(ItemPool[1],'IN10',2)
            ItemPoolAddItemType(ItemPool[1],'IN11',2)
            ItemPoolAddItemType(ItemPool[1],'IN12',2)
            ItemPoolAddItemType(ItemPool[1],'IN13',4)
            ItemPoolAddItemType(ItemPool[1],'IN14',1)
            ItemPoolAddItemType(ItemPool[1],'IN15',1)
            ItemPoolAddItemType(ItemPool[1],'IN16',1)
            ItemPoolAddItemType(ItemPool[1],'IN17',2)
            ItemPoolAddItemType(ItemPool[1],'IN18',2)
            ItemPoolAddItemType(ItemPool[2],'IF01',3)
            ItemPoolAddItemType(ItemPool[2],'IF02',3)
            ItemPoolAddItemType(ItemPool[2],'IF03',1)
            ItemPoolAddItemType(ItemPool[2],'IF04',1)
            ItemPoolAddItemType(ItemPool[2],'IF05',1)
            ItemPoolAddItemType(ItemPool[2],'IF06',1)
            ItemPoolAddItemType(ItemPool[2],'IF07',3)
            ItemPoolAddItemType(ItemPool[2],'IF08',3)
            ItemPoolAddItemType(ItemPool[2],'IF09',1)
            ItemPoolAddItemType(ItemPool[2],'IF10',1)
            ItemPoolAddItemType(ItemPool[2],'IF11',2)
            ItemPoolAddItemType(ItemPool[2],'IF12',1)
            ItemPoolAddItemType(ItemPool[2],'IF13',3)
            ItemPoolAddItemType(ItemPool[2],'IF14',2)
            ItemPoolAddItemType(ItemPool[2],'IF15',1)
            ItemPoolAddItemType(ItemPool[2],'IF16',2)
            ItemPoolAddItemType(ItemPool[2],'IF17',1)
            ItemPoolAddItemType(ItemPool[2],'IF18',2)
            ItemPoolAddItemType(ItemPool[2],'IF19',1)
            ItemPoolAddItemType(ItemPool[2],'IF20',3)
            ItemPoolAddItemType(ItemPool[2],'IF21',1)
            ItemPoolAddItemType(ItemPool[2],'IF22',3)
            ItemPoolAddItemType(ItemPool[2],'IF23',1)
            ItemPoolAddItemType(ItemPool[2],'IF24',2)
            ItemPoolAddItemType(ItemPool[2],'IF25',2)
            ItemPoolAddItemType(ItemPool[2],'IF26',3)
            ItemPoolAddItemType(ItemPool[2],'IF27',3)



            
        endfunction


    endscope



    function InitAllFunc()
        ExecuteFunc("InitHeroPoolFunc")
        ExecuteFunc("InitUnitPoolFunc")
    endfunction
    
endlibrary


