library AttackRoom initializer AttackRoomInit uses System,State,PlayerGlobals
    
    real array AttackRoomPostion[12][600] 
    group array diesgroup
    group array AttackRoomGroup
    integer AttackRoomUid ='g00A'
    bool AttackRoomTimer[pid][2]
    
    
//初始化数据类

    function SetAttackRoomMovePostion(int pid,real x,real y)
        AttackRoomPostion[pid][1] = x
        AttackRoomPostion[pid][2] = y
        //设置玩家移动坐标
    endfunction
    function SetAttackRoomRefreshPostion(int pid,real x,real y)
        AttackRoomPostion[pid][3] = x
        AttackRoomPostion[pid][4] = y
        //设置怪物刷新坐标
    endfunction
    
    function AttackRoomInit()
        real x = 0
        real y = 0
        
        //初始化练功房刷怪坐标
        SetAttackRoomRefreshPostion(0,-8512,-5312)
        SetAttackRoomRefreshPostion(1,-5312,-5312)
        SetAttackRoomRefreshPostion(2,-8512,-8512)
        SetAttackRoomRefreshPostion(3,-5312,-8512)
        
        //初始化练功房进入坐标
        SetAttackRoomMovePostion(0,-8512,-5312)
        SetAttackRoomMovePostion(1,-5312,-5312)
        SetAttackRoomMovePostion(2,-8512,-8512)
        SetAttackRoomMovePostion(3,-5312,-8512)
        
        
        for pid = 0,3//玩家数量
            if  IsPlaying(pid) == true
                x = AttackRoomPostion[pid][1]
                y = AttackRoomPostion[pid][2]
                
                AttackRoomGroup[pid] = CreateGroup()
                AttackRoomUid = 'g00A'
                AttackRoomUnitNum = 10
                
                Pu[21]=CreateUnit(Player(pid),'np01',x,y+512,270)//境界
                Pu[22]=CreateUnit(Player(pid),'np02',x-512,y,270)//技能商店
                Pu[23]=CreateUnit(Player(pid),'np03',x+512,y+512,270)//占星方士
                
                Pu[25]=CreateUnit(Player(pid),'np05',x-512,y-256,270)//兽魂神通
                Pu[26]=CreateUnit(Player(pid),'np06',x-512,y+256,270)//药品商店
                
                Pu[27]=CreateUnit(Player(pid),'u001',x+384,y+192,225)//送宝金蝉
                UnitAddAbility(Pu[27],'Avul')
                SetUnitState(Pu[27],UNIT_STATE_MAX_LIFE,101)
                SetUnitState(Pu[27],UNIT_STATE_LIFE,1)
                SetUnitVertexColor(Pu[27],255,255,255,50)
                PauseUnit(Pu[27],true)
                
                ShowUnit(Pu[23],false)
                
                ShowUnit(Pu[25],false)
            endif
        end
        
        
        for g = 1,1//怪物种类数量
            diesgroup[g] = CreateGroup()
        end
        
        
    endfunction
    
    
    
//单位回收类
    
    function CreateAttackRoomUnit(int unitid,int pid)
        int uid = unitid -'g00A'+1
        unit u = FirstOfGroup(diesgroup[uid])
        if  u == null
            u = CreateUnit( Player(PLAYER_NEUTRAL_AGGRESSIVE), unitid, AttackRoomPostion[pid][3], AttackRoomPostion[pid][4], bj_UNIT_FACING )
            GroupAddUnit(AttackRoomGroup[pid],u)
        else
            SetUnitLifePercentBJ( u, 100 )
            UnitRemoveAbility( u, 'Aloc' )
            UnitRemoveBuffs(u, true, true)
            SetUnitX(u,AttackRoomPostion[pid][3])
            SetUnitY(u,AttackRoomPostion[pid][4])
            SetUnitAnimation( u, "stand" )
            SetUnitInvulnerable( u, false )
            SetUnitPathing( u, true )
            ShowUnit(u,true)
            GroupAddUnit(AttackRoomGroup[pid],u)
            GroupRemoveUnit(diesgroup[uid],u)
           
        endif
        u = null
    endfunction
    //复活创建练功房怪物
    //----------------------------------------------
    
    
    function RecoveryAttackRoomUnit(int pid1,unit u1)
        unit u=u1
        int pid=pid1
        int uid=GetUnitTypeId(u)-'g00A'+1
        SetUnitInvulnerable( u, true )
        SetUnitPathing( u, false )
        GroupAddUnit(diesgroup[uid],u)
        GroupRemoveUnit(AttackRoomGroup[pid],u)
        ShowUnit( u, false )
        flush locals
    endfunction
                
//把即将要死亡的单位回收--------------
        

    
    
//练功房操作类
    
    //计时器会额外出一波
    
    

    
    function ClearAttackRoom(int pid)
        loop 
            unit u = FirstOfGroup(AttackRoomGroup[pid])
            exitwhen u==null
            RecoveryAttackRoomUnit(pid,u)
        endloop
        u = null
    endfunction
//清空练功房内怪物

    function RefreshAttackRoom(int pid,int uid)
        DBUG("即将清空刷新")
        ClearAttackRoom(pid)//先清空
        for c=1,AttackRoomUnitNum
            CreateAttackRoomUnit(uid,pid)
        end
        DBUG(I2S(CountUnitsInGroup(AttackRoomGroup[pid])))
    endfunction
//刷新一波怪物
    
    function MoveHeroToAttackRoom(int pid)
        SetPlayerUnitPostionSelectUnit(Pu[1],AttackRoomPostion[pid][1],AttackRoomPostion[pid][2],Pu[1])
    endfunction

//事件类
    function AttackRoomKillUnit(unit wu,unit tu)
        PlayerHeroKillUnit.execute(wu,tu)
    endfunction
    function SoulToFrog(int pid)
        real x = AttackRoomPostion[pid][1] 
        real y = AttackRoomPostion[pid][2] 
        if  GetUnitTypeId(Pu[27]) == 'u001'
            RemoveUnit(Pu[27])
            Pu[27]=CreateUnit(Player(pid),'np03',x+512,y+256,270)
            SetUnitState(Pu[27],UNIT_STATE_MAX_LIFE,351)
            SetUnitState(Pu[27],UNIT_STATE_LIFE,1)
            Pu[120]=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'u001',x+384,y+192,225)
            LocAddEffect(x+512,y+256,"effect_az_bw_lina_t1-2.mdl")
        endif
    endfunction
    function SoulTimerFunc(int id,real x,real y)
        int pid = id
        real x1 = x
        real y1 = y
        real x2 = GetUnitX(Pu[27])
        real y2 = GetUnitY(Pu[27])
        real ang = Pang(x2,y2,x1,y1)
        real speed = GetRandomReal(20,40)
        unit u1 =  CreateTmUnit(Player(pid),"Abilities\\Weapons\\SpiritOfVengeanceMissile\\SpiritOfVengeanceMissile.mdl",x,y,ang/0.01745+(40-speed)*GetRandomInt(-1,1),50,1.0)
        SetUnitPropWindow( u1, 6.26 )
        SetUnitTurnSpeed( u1, GetRandomReal(0.01,0.2))
        
        TimerStart(0.03,true)
        {
            real dis = Pdis(x1,y1,x2,y2)
            if  dis > 50 and GetUnitTypeId(Pu[27]) == 'u001'
                x1 = x1 + speed * Cos(GetUnitFacing(u1)*0.01745)
                y1 = y1 + speed * Sin(GetUnitFacing(u1)*0.01745)
                SetUnitFacing(u1,Pang(x1,y1,x2,y2)/0.01745)
                SetUnitX(u1,x1)
                SetUnitY(u1,y1)
            else
                real life = GetUnitState(Pu[27],UNIT_STATE_LIFE)+2
                real maxlife = GetUnitState(Pu[27],UNIT_STATE_MAX_LIFE)
                if  maxlife > 0
                    SetUnitState(Pu[27],UNIT_STATE_LIFE,life)
                    SetUnitVertexColor(Pu[27],255,255,255,55+R2I(205*(life/maxlife)))
                
                    if  life+0.5 >= maxlife
                        SoulToFrog(pid)
                    endif
                endif
                RemoveUnit(u1)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction
    function SoulTimer(int pid,real x,real y)
        for i = 1,5
            SoulTimerFunc(pid,x,y)
        end
    endfunction
    


    function SoulTimer2Func(int id,real x,real y)
        int pid = id
        real x1 = x
        real y1 = y
        real x2 = GetUnitX(Pu[27])
        real y2 = GetUnitY(Pu[27])
        real ang = Pang(x2,y2,x1,y1)
        real speed = GetRandomReal(20,40)
        unit u1 =  CreateTmUnit(Player(pid),"Abilities\\Weapons\\SpiritOfVengeanceMissile\\SpiritOfVengeanceMissile.mdl",x,y,ang/0.01745+(40-speed)*GetRandomInt(-1,1),50,5.0)
        SetUnitPropWindow( u1, 6.26 )
        SetUnitTurnSpeed( u1, GetRandomReal(0.01,0.2))
        
        TimerStart(0.03,true)
        {
            real dis = Pdis(x1,y1,x2,y2)
            if  dis > 50
                x1 = x1 + speed * Cos(GetUnitFacing(u1)*0.01745)
                y1 = y1 + speed * Sin(GetUnitFacing(u1)*0.01745)
                SetUnitFacing(u1,Pang(x1,y1,x2,y2)/0.01745)
                SetUnitX(u1,x1)
                SetUnitY(u1,y1)
            else
                real life = GetUnitState(Pu[27],UNIT_STATE_LIFE)+10
                real maxlife = GetUnitState(Pu[27],UNIT_STATE_MAX_LIFE)
                if  maxlife > 0
                    SetUnitState(Pu[27],UNIT_STATE_LIFE,life)
                    //SetUnitVertexColor(Pu[27],255,255,255,55+R2I(205*(life/maxlife)))
                
                    if  life+0.5 >= maxlife
                        BJDebugMsg("占星一下")
                        SetUnitState(Pu[27],UNIT_STATE_LIFE,1)
                    endif
                endif
                RemoveUnit(u1)
                endtimer
            endif
            flush locals
        }
        flush locals
    endfunction

    function SoulTimer2(int pid,real x,real y)
        SoulTimer2Func(pid,x,y)
    endfunction
    
    //任意单位死亡 触发单位，凶手单位
    function AttackRoomUnitDeath(unit wu,unit ku)
        real x = GetUnitX(ku)
        real y = GetUnitY(ku)
        int pid=GetPlayerId(GetOwningPlayer(ku))
        AttackRoomKillUnit(ku,wu)
        RecoveryAttackRoomUnit(pid,wu)
        if  IsUnitGroupEmptyBJ(AttackRoomGroup[pid]) == true
            if  GetUnitTypeId(Pu[27]) == 'u001'
                SoulTimer(pid,x,y)
            elseif  GetUnitTypeId(Pu[27]) == 'np03'
                SoulTimer2(pid,x,y)
            endif
            AttackRoomTimer = true
            TimerStart(1,false)
            {
                RefreshAttackRoom(pid,AttackRoomUid)
                
                AttackRoomTimer = false
                endtimer
            }
        endif
    
    endfunction
    
    function HeroMoveToRoom(int pid)
        DestroyEffect(AddSpecialEffect("effect_az_goods_lvlup(3).mdl",GetUnitX(Pu[1]),GetUnitY(Pu[1])))
        SetPlayerUnitPostionSelectUnit(Pu[1],AttackRoomPostion[pid][1],AttackRoomPostion[pid][2],Pu[1])
        DestroyEffect(AddSpecialEffect("effect_effect_az_goods_tp_target_effect(4).mdl",AttackRoomPostion[pid][1],AttackRoomPostion[pid][2]))
        if  AttackRoomTimer==false
            RefreshAttackRoom(pid,AttackRoomUid)
        endif
    endfunction
    
   
endlibrary
