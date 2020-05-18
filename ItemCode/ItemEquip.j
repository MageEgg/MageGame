library ItemEquip uses DamageCode,ItemGameFunc

    

    function ReEquipTips(int pid,item it)
        int id = GetItemTypeId(it)
        int index = GetItemLevel(it)
        int gl = 0
        int gold = 0
        int next = 0
        string s = "|Cffbbbbbb属性：|r"

        int fmid = GetItemIntState(it,'FMID')
        
        real value = 0

        for i = 1,70
            value = GetTypeIdReal(id,i)
            if  value > 0
                s = s + "\n" + StateName[i] + "+" + I2S(R2I(value)) + StateName[i+1000]
            endif
        end


        if  index == 1
            if  id == 'E035'
                s = s + "\n\n攻击|Cffffc92610%|r概率附加|Cffffc926业力*400%|r攻击伤害\n|Cffffc926武器技升级为虚空湮灭，伤害提升50%。|r"
            else
                s = s + "\n\n攻击|Cffffc92610%|r概率附加|Cffffc926业力*400%|r攻击伤害"
            endif
        elseif  index == 2
            if  id == 'E135'
                s = s + "\n\n|Cffffc926轮回之心：每10%冷却缩减提升1%伤害加成。|r"
            endif
        elseif  index == 3
            if  id == 'E235'
                s = s + "\n\n|Cffffc926祖龙庇佑：被攻击8%概率回复15%最大生命值，3秒内免疫任何伤害。冷却60秒。|r"
            endif
        endif

        if  fmid > 0
            s = s + "\n\n"+GetTypeIdTips(fmid)
        endif


        next = GetTypeIdData(id,106)
        if  next > 0
            if  index == 2
                gold = GetTypeIdData(id,100)
            else
                gold = GetTypeIdData(id,103)
            endif
            gl = GetTypeIdData(id,104)

            if  gold > 0 and gl > 0
                if  index == 1 or index == 3
                    if  gl == 100
                        s = s + "\n\n|Cff00ff7f点击消耗"+I2S(gold)+"金币进行晋阶挑战"
                    else
                        s = s + "\n\n|Cff00ff7f点击消耗"+I2S(gold)+"金币进行强化\n成功率"+I2S(gl)+"%"
                    endif
                else
                    s = s + "\n\n|Cff00ff7f击杀"+I2S(gold)+"只怪有"+I2S(gl)+"%概率升级|r"
                endif
            else
                if  GetTypeIdData(next,106) != 0
                    s = s + "\n\n可以使用|cffff0000虚空神石|r进行升级"
                else
                    s = s + "\n\n可以使用|cffff0033创世碎片|r进行升级"
                endif
            endif
        endif



        if  GetLocalPlayer() == Player(pid)
            YDWESetItemDataString(id,3,s)
        endif
    
    endfunction

    function SetMagicStateEx(unit wu,int id,real offset)
        int state = 0
        real value = 0
        if  id == 'FM1A'
            state = 74
            value = 40*offset
        elseif  id == 'FM1B'
            state = 73
            value = 30*offset
        elseif  id == 'FM1C'
            state = 72
            value = 30*offset
        elseif  id == 'FM1D'
            state = 75
            value = 40*offset
        elseif  id == 'FM1E'
            state = 71
            value = 25*offset
        elseif  id == 'FM2E'
            state = 74
            value = 70*offset
        elseif  id == 'FM2F'
            state = 73
            value = 60*offset
        elseif  id == 'FM2G'
            state = 72
            value = 60*offset
        elseif  id == 'FM2H'
            state = 75
            value = 80*offset
        elseif  id == 'FM2I'
            state = 71
            value = 45*offset
        endif

        if  state != 0
            AddUnitRealState(wu,state,value)
        endif
    endfunction
    

    function HeroEquipRemMagic(unit wu,item it)
        int id = GetItemIntState(it,'FMID')
        AddUnitIntState(wu,id,-1)
        SetMagicStateEx(wu,id,-1)
        SetEquipStateOfPlayer(wu,id,-1)
        SetItemIntState(it,'FMID',0)
    endfunction
    function HeroEquipAddMagic(unit wu,item it,int id)
        int now = GetItemIntState(it,'FMID')

        if  now > 0
            HeroEquipRemMagic(wu,it)
        endif

        AddUnitIntState(wu,id,1)
        SetMagicStateEx(wu,id,1)
        SetEquipStateOfPlayer(wu,id,1)
        SetItemIntState(it,'FMID',id)

        ReEquipTips(GetPlayerId(GetOwningPlayer(wu)),it)
        DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,10,"|cffffcc00[系统]|r："+GetTypeIdTips(id)+"附魔成功！")
    endfunction


    
    function HeroUseAddMagicItem(unit wu,item it,int itemid)
        int id = GetItemTypeId(it)
        real ran = GetRandomReal(1,100)
        int index = 0

        if  itemid == 'CS51'
            if  ran <= 60
                index = 1
            elseif  ran <= 95
                index = 2
            else
                index = 3
            endif
        elseif  itemid == 'CS52'
            if  ran <= 30
                index = 1
            elseif  ran <= 90
                index = 2
            else
                index = 3
            endif
        elseif  itemid == 'CS53'
            if  ran <= 70
                index = 2
            else
                index = 3
            endif
        endif

        
        if  (id >= 'E016' and id <= 'E035') or (id >= 'E116' and id <= 'E135') or (id >= 'E216' and id <= 'E235')
            HeroEquipAddMagic(wu,it,GetTypePoolType(index))
        else
            UnitAddItemById(wu,itemid)
            DisplayTimedTextToPlayer(GetOwningPlayer(wu),0,0,10,"|cffff0000[系统]：附魔目标不正确！|r")
        endif
    endfunction




    //装备升级
    function GetEquipIndex(int id)->int
        if  id >= 'E001' and id <= 'E025'
            return 1
        elseif  id >= 'E101' and id <= 'E125'
            return 2
        elseif  id >= 'E201' and id <= 'E225'
            return 3
        endif
        return 0
    endfunction

    function IsHeroEquipCanOpenPlot(unit wu)->bool
        int id = 0
        int e1 = 0
        int e2 = 0
        for n = 0,5
            id = GetItemTypeId(UnitItemInSlot(wu,n))
            if  id >= 'E006' and id <= 'E025'
                e1 = 1
                exitwhen true
            endif
        end
        for n = 0,5
            id = GetItemTypeId(UnitItemInSlot(wu,n))
            if  id >= 'E206' and id <= 'E225'
                e2 = 1
                exitwhen true
            endif
        end
        return e1 == 1 and e2 == 1
    endfunction

    function IncEquipKillUnitFunc(unit u1,unit u2)
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int uid = GetUnitTypeId(u2)
        int next = 0
        int itemid = 0
        int fmid = 0
        for i = 0,5
            itemid = GetItemTypeId(UnitItemInSlot(Pu[1],i))
            if  GetTypeIdData(itemid,105) == uid
                next = GetTypeIdData(itemid,106)
                fmid = GetItemIntState(UnitItemInSlot(Pu[1],i),'FMID')
                RemoveItem(UnitItemInSlot(Pu[1],i))

                bj_lastCreatedItem = CreateItem(next,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                SetItemIntState(bj_lastCreatedItem,'FMID',fmid)
                UnitAddItem(Pu[1],bj_lastCreatedItem)
                UnitAddEffect(Pu[1],"effect_e_buffyellow2.mdx")
                bj_lastCreatedItem = null
                

                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r装备"+GetObjectName(itemid)+"突破成功！")
                
                if  Pu[24] == null
                    if  IsHeroEquipCanOpenPlot(Pu[1]) == true
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r装备均达到|Cff00ff7f绿色|r，解锁|Cffff0000剧情副本挑战|r|Cfff0f0f0。|r")

                        
                        //LocAddEffect(GetUnitX(Pu[24]),GetUnitY(Pu[24]),"effect_az-blue-lizi-shangsheng.mdl")
                        
                        //PlayerUnLockPlot(pid,1)
                    endif
                endif
            endif
        end
    endfunction

    



    function IncEquipFunc(unit u1,item it)
        int pid = GetPlayerId(GetOwningPlayer(u1))
        int id = GetItemTypeId(it)
        int gold = GetTypeIdData(id,103)
        int next = GetTypeIdData(id,106)
        int uid = GetTypeIdData(id,105)
        int index = 0
        real gl = GetTypeIdData(id,104)//概率
        int fmid = 0
        real x = 0
        real y = 0

        if  id >= 'E001' and id <= 'E029'
            BJDebugMsg("强化概率+"+I2S(IncEquipAddition1))
            gl = gl + IncEquipAddition1
        else
            BJDebugMsg("强化概率+"+I2S(IncEquipAddition2))
            gl = gl + IncEquipAddition2
        endif
        if  GameSaveClose == 0
            if  GetPlayerTechCount(Player(pid),'RDAP',true) > 0
                gl = gl + 1.25
            endif
            if  GetPlayerTechCount(Player(pid),'RDAY',true) > 0
                gl = gl + 1.25
            endif
            if  GetPlayerTechCount(Player(pid),'RGBA',true) > 0
                gl = gl + 1.25
            endif

            if  GetPlayerTechCount(Player(pid),'RG1H',true) > 0
                gl = gl + 3
            endif
            
            if  GetPlayerTechCount(Player(pid),'RSHF',true) > 0
                gl = gl + 3
                BJDebugMsg("13件套+3")
            endif
            if  GetPlayerTechCount(Player(pid),'RDBB',true) > 0
                gl = gl + 3
                BJDebugMsg("万匹斯件套+3")
            endif
        endif
        

        BJDebugMsg("强化成功率"+R2S(gl))
        if  next > 0
            
            if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_GOLD)>=gold
                if  uid > 0
                    if  IsCanMoveToRoom(pid) == true
                        index = GetEquipIndex(id)
                        if  index != 0
                            if  GetUnitTypeId(Pu[100+index]) == 0
                                AdjustPlayerStateBJ(-gold, Player(pid), PLAYER_STATE_RESOURCE_GOLD )

                                if  GameMode == 4
                                    if  pid == 0
                                        x = -6016
                                        y = 13728
                                    elseif  pid == 1
                                        x = -2144
                                        y = 13728
                                    elseif  pid == 2
                                        x = -2144
                                        y = 9824
                                    elseif  pid == 3
                                        x = -6016
                                        y = 9824
                                    endif
                                else
                                    x = AttackRoomPostion[pid][1]-512
                                    y = AttackRoomPostion[pid][2]+384
                                endif
                                Pu[100+index] = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),uid,x,y,270)
                                
                                AddAttackSummonUnit(pid,Pu[100+index])

                                SetPlayerOnlyDamage(Pu[100+index],pid)
                                IssuePointOrderById( Pu[100+index], 851983, GetUnitX(Pu[1]), GetUnitY(Pu[1]) )
                                HeroMoveToRoom(pid)

                            else
                                HeroMoveToRoom(pid)
                                if  id >= 'E001' and id <= 'E029'
                                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r武器晋升正在挑战中！")
                                elseif  id >= 'E201' and id <= 'E229'
                                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r防具晋升正在挑战中！")
                                endif
                            endif
                        endif
                    else   
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r当前无法升级装备")
                    endif
                else
                    AdjustPlayerStateBJ(-gold, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                    if  GetRandomReal(1,100)<= gl

                        fmid = GetItemIntState(it,'FMID')
                        RemoveItem(it)

                        bj_lastCreatedItem = CreateItem(next,GetUnitX(Pu[1]),GetUnitY(Pu[1]))
                        SetItemIntState(bj_lastCreatedItem,'FMID',fmid)

                        UnitAddItem(u1,bj_lastCreatedItem)
                        bj_lastCreatedItem = null

                        UnitAddEffect(Pu[1],"effect_e_buffyellow2.mdx")
                        IncEquipModelFunc(pid,1)
                        DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cff00ff00[系统]：装备升级成功！|r")
                        if  id >= 'E001' and id <= 'E029'
                            IncEquipAddition1 = 0
                        else
                            IncEquipAddition2 = 0
                        endif
                    else
                        if  id >= 'E001' and id <= 'E029'
                            IncEquipAddition1 = IncEquipAddition1 + 5
                        else
                            IncEquipAddition2 = IncEquipAddition2 + 5
                        endif
                        


                        if  IncEquipAddition1 + IncEquipAddition2 >= 25
                            if  GetPlayerTechCount(Player(pid),'RDAY',true) == 0
                                SetDzPlayerData(pid,15,25,25)
                                SetPlayerTechResearchedEx(Player(pid),'RDAY')
                                DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,10,"|cffffcc00[彩蛋]：|r恭喜"+GetPlayerNameOfColor(pid)+"激活|cffffcc00【彩蛋】|cffff8000今天爆率真高啊|r（永久存档）！")
                            endif

                        endif

                        if  GetPlayerTechCount(Player(pid),'RJ1U',true) > 0 and  GameSaveClose == 0
                            AdjustPlayerStateBJ(gold/5, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：装备升级失败！下次强化|cff00ff00成功率+5%")
                            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cff00ff00[系统]：拥有封神礼包！返还|cffffcc00"+I2S(gold/5)+"金币|r")
                        else
                            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：装备升级失败！下次强化|cff00ff00成功率+5%")
                        endif
                        //IncEquipModelFunc(pid,2)
                        
                    endif
                    
                endif
            else
                
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r升级失败！金币不足"+I2S(gold))
            endif
            
        else    
            BJDebugMsg("next"+I2S(next))
        endif
    endfunction



    function GetIncEquipId(int pid,int index)->int
        int minid = 0
        int maxid = 0
        int id = 0
        if  index == 0
            minid = 'E026'
            maxid = 'E033'
        elseif  index == 1
            minid = 'E126'
            maxid = 'E133'
        elseif  index == 2
            minid = 'E226'
            maxid = 'E233'
        endif
        if  minid != 0
            for n = 0,5
                id = GetItemTypeId(UnitItemInSlot(Pu[1],n))
                if  id >= minid and id <= maxid
                    return id
                endif
            end
        endif
        return 0
    endfunction
    function GetIncEquipIdEx(int pid,int index)->int
        int useid = 0
        int id = 0
        if  index == 0
            useid = 'E034'
        elseif  index == 1
            useid = 'E134'
        elseif  index == 2
            useid = 'E234'
        endif
        if  useid != 0
            for n = 0,5
                id = GetItemTypeId(UnitItemInSlot(Pu[1],n))
                if  id == useid
                    return id
                endif
            end
        endif
        return 0
    endfunction
    function GetIncEquipName(int id,int index)->string
        if  id == 0
            if  index == 0
                return "[武器]不符合升级条件"
            elseif  index == 1
                return "[饰品]不符合升级条件"
            elseif  index == 2
                return "[防具]不符合升级条件"
            endif
        endif
        return GetObjectName(id)
    endfunction


    
                        

                        


    function GemIncEquip(unit wu,int itemid)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int next = GetTypeIdData(itemid,106)
        int id = 0
        int fmid = 0
        for i = 0,5
            id = GetItemTypeId(UnitItemInSlot(wu,i))
            if  id == itemid
                fmid = GetItemIntState(UnitItemInSlot(wu,i),'FMID')
                RemoveItem(UnitItemInSlot(wu,i))
                bj_lastCreatedItem = CreateItem(next,GetUnitX(wu),GetUnitY(wu))
                SetItemIntState(bj_lastCreatedItem,'FMID',fmid)

                UnitAddItem(wu,bj_lastCreatedItem)
                bj_lastCreatedItem = null

                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cff00ff00[系统]：装备升级成功！|r")
                exitwhen true
            endif
        end

    endfunction

    function PlayerUseIncEquipGemFunc1()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()

        int id = GetIncEquipId(pid,i-1)

        if  PlayerDeathBool == false
            if  i == 4
                UnitAddItemById(Pu[1],'CS41')
            else
                if  id > 0
                    GemIncEquip(Pu[1],id)
                else
                    UnitAddItemById(Pu[1],'CS41')
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：当前没有可升级的装备！|r")
                endif
            endif
        else
            UnitAddItemById(Pu[2],'CS41')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：死亡状态无法使用！|r")
        endif
    endfunction

    function PlayerUseIncEquipGemFunc2()
        int pid = Dialog.GetPlayerid()
        int i = Dialog.GetButtonid()

        int id = GetIncEquipIdEx(pid,i-1)
        if  PlayerDeathBool == false
            if  i == 4
                UnitAddItemById(Pu[1],'CS42')
            else
                if  id > 0
                    GemIncEquip(Pu[1],id)
                else
                    UnitAddItemById(Pu[1],'CS42')
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：当前没有可升级的装备！|r")
                endif
            endif
        else
            UnitAddItemById(Pu[2],'CS42')
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：死亡状态无法使用！|r")
        endif
    endfunction


    function PlayerUseIncEquipGem(unit wu,int itemid)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int id1 = 0
        int id2 = 0
        int id3 = 0
        if  PlayerDeathBool == false
            if  itemid == 'CS41'
                id1 = GetIncEquipId(pid,0)
                id2 = GetIncEquipId(pid,1)
                id3 = GetIncEquipId(pid,2)
            else
                id1 = GetIncEquipIdEx(pid,0)
                id2 = GetIncEquipIdEx(pid,1)
                id3 = GetIncEquipIdEx(pid,2)
            endif

            if  id1 != 0 or id2 != 0 or id3 != 0
                if  itemid == 'CS41'
                    Dialog.create(Player(pid),"请选择要升级的装备",GetIncEquipName(id1,0),GetIncEquipName(id2,1),GetIncEquipName(id3,2),"取消","","","","","","","","","PlayerUseIncEquipGemFunc1")
                else
                    Dialog.create(Player(pid),"请选择要升级的装备",GetIncEquipName(id1,0),GetIncEquipName(id2,1),GetIncEquipName(id3,2),"取消","","","","","","","","","PlayerUseIncEquipGemFunc2")
                endif
            else
                UnitAddItemById(wu,itemid)
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：当前没有可升级的装备！|r")
            endif
        else
            UnitAddItemById(wu,itemid)
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：死亡状态无法使用！|r")
        endif
    endfunction





    
    //读取饰品
    function GetHeroOrnamentsItem(int pid)->item
        int id = 0
        for n = 0,5
            id = GetItemTypeId(UnitItemInSlot(Pu[1],n))
            if  id >= 'E101' and id <= 'E129'
                return UnitItemInSlot(Pu[1],n)
            endif
        end
        return null
    endfunction
    //手动升级饰品
    function IncOrnaments(int pid,unit wu)
        item it = GetHeroOrnamentsItem(pid)
        int next = 0
        int id = 0
        int use = 0
        int fmid = 0
        if  PlayerDeathBool == false
            if  it != null
                id = GetItemTypeId(it)
                if  id >= 'E101' and id <= 'E105'
                    use = 5000
                elseif  id >= 'E106' and id <= 'E110'
                    use = 10000
                elseif  id >= 'E111' and id <= 'E115'
                    use = 20000
                elseif  id >= 'E116' and id <= 'E120'
                    use = 40000
                elseif  id >= 'E121' and id <= 'E125'
                    use = 60000
                else
                    use = 100000
                endif
                if  GameSaveClose == 0
                    if  GetPlayerTechCount(Player(pid),'RSHD',true) > 0
                        use = use / 2
                    endif
                endif

                if  GetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_GOLD)>=use
                    AdjustPlayerStateBJ(-use, Player(pid), PLAYER_STATE_RESOURCE_GOLD )
                    next = GetTypeIdData(id,106)

                    fmid = GetItemIntState(it,'FMID')
                    RemoveItem(it)
                    bj_lastCreatedItem = CreateItem(next,GetUnitX(wu),GetUnitY(wu))
                    SetItemIntState(bj_lastCreatedItem,'FMID',fmid)

                    UnitAddItem(wu,bj_lastCreatedItem)
                    bj_lastCreatedItem = null

                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r：恭喜您成功将" + GetObjectName(id) + "晋升为" + GetObjectName(next))
                else    
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffff0000[系统]：|r强化失败！金币不足"+I2S(use))
                endif
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r背包内没有可升级的饰品！")
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r死亡状态无法升级饰品！")
        endif
        flush locals
    endfunction



    function GetExShopUse(int sid)->int
        int use = 0
        return use
    endfunction

    function PlayerBuyExShop(unit wu,int sid)
        int pid = GetPlayerId(GetOwningPlayer(wu))
        int use = GetExShopUse(sid)

        if  use > 0
            if  GetPlayerFood(pid) >= use
                UsePlayerFood(pid,use)

                if  sid == 'AS0A'
                    UnitAddItemById(Pu[1],'IN31')
                elseif  sid == 'AS0B'
                    UnitAddItemById(Pu[1],'CS53')
                elseif  sid == 'AS0C'
                    AddUnitRealState(Pu[1],61,1)
                endif

                
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r购买成功！")
            else
                DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r钻石不足|cffff0000"+I2S(use)+"|r，无法购买！")
            endif
        else
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[系统]：|r已达到购买上限，无法购买！")
        endif
    endfunction



    

    
    


endlibrary
