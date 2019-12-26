library SystemCodes uses ServerTime,Define1
    func IsPlaying(int pid)->bool
        if GetPlayerController(Player(pid)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(pid)) == PLAYER_SLOT_STATE_PLAYING
            return true
        else
            return false
        endif
    end
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
        elseif r >= 10000
            return SubString(R2S(r),0,l-8)+"万"
        endif
        return SubString(R2S(r),0,l-4)
    end

    //获取基础属性
    function GetTypeIdStateTips(int id)->string
        string s = ""
        real value = 0
        for i = 1,30
            value = GetTypeIdReal(id,i)
            if  value > 0
                s = s + "\n" + StateName[i] + "+" + R2S2(value) + StateName[i+1000]
            endif
            
        end
        return "|cff666666基础属性|r" + s
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
    
    function SetPlayerCameraBoundsToRect(rect r)
        real minX = GetRectMinX(r)
        real minY = GetRectMinY(r)
        real maxX = GetRectMaxX(r)
        real maxY = GetRectMaxY(r)
        SetCameraBounds(minX, minY, minX, maxY, maxX, maxY, maxX, minY)
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
    
    ////////////////////////////异步函数分割//////////////////////////////

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
    
    function PlayerSelectOneUnit(int pid,unit u)
        if  Player(pid)==GetLocalPlayer()
            ClearSelection()
            SelectUnit(u,true)
        endif
    endfunction

    
endlibrary
library UnitRanDropItem uses SystemCodes
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
            BJDebugMsg("max is "+I2S(max))
            for i = 1,max
                BJDebugMsg(I2S(i)+" is "+LoadStr(ht,GetPrizeData(page,pool,i),100))
            end

            
        endfunction

        function RegisterPrizePoolData(int page,int pool,int id)
            AddPrizePoolMax(page,pool,1)
            SetPrizeData(page,pool,GetPrizePoolMax(page,pool),id)
            
        endfunction
        
    endscope


    
    scope Dorp
        int DropUnitNum = 1
        int array DropUnitID
        int array UnitDropItemID[3][2700]
        int array UnitDropItemRan[3][2700]
        
        function UnitRanDropItemData(int u,int i1,int r1,int i2,int r2,int i3,int r3)
            DropUnitID[DropUnitNum] = u
            UnitDropItemID[0][DropUnitNum] = i1
            UnitDropItemID[1][DropUnitNum] = i2
            UnitDropItemID[2][DropUnitNum] = i3
            UnitDropItemRan[0][DropUnitNum] = r1
            UnitDropItemRan[1][DropUnitNum] = r2
            UnitDropItemRan[2][DropUnitNum] = r3
            DropUnitNum = DropUnitNum + 1
        endfunction

        function DropItemTimerFunc()
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
        endfunction

        function RanDropItem(unit wu,int pid)
            unit u1 = wu
            int max = DropUnitNum
            int ran = 0
            int Item = 0
            for i = 0,max
                if  GetUnitTypeId(u1) == DropUnitID[i]
                    for n = 0,2
                        ran = R2I(I2R(UnitDropItemRan[n][i]))
                        
                        if  GetRandomInt(1,1000) <= ran and ran != 0
                            CreateItem(UnitDropItemID[n][i],GetUnitX(u1),GetUnitY(u1))
                            Item = Item + 1
                        endif
                    end
                    exitwhen true
                endif
            end
            flush locals
        endfunction
    endscope
    
endlibrary


