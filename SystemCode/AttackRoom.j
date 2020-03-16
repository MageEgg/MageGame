library AttackRoom initializer AttackRoomInit uses System,State,PlayerGlobals,GameChallengDeath
    
    real array AttackRoomPostion[12][600] 
    bool array AttackRoomUnitBool
    texttag array AttackTexttag

    //设置刷怪id
    function SetAttackRoomUnitId(int pid,int id)
        AttackRoomUnitId = id
    endfunction
    //获取刷怪id
    function GetAttackRoomUnitId(int pid)->int
        if  AttackRoomUnitId == 0
            SetAttackRoomUnitId(pid,'g00A')
        endif
        return AttackRoomUnitId
    endfunction
    //获取刷怪数量
    function GetPlayerAttackUnitNum(int pid)->int
        return R2I(GetUnitRealState(Pu[1],61))+10
    endfunction

    //设置玩家移动坐标
    function SetAttackRoomMovePostion(int pid,real x,real y)
        AttackRoomPostion[pid][1] = x
        AttackRoomPostion[pid][2] = y
    endfunction

    //设置怪物刷新坐标
    function SetAttackRoomRefreshPostion(int pid,real x,real y)
        AttackRoomPostion[pid][3] = x
        AttackRoomPostion[pid][4] = y
    endfunction
    


    unit array AttackRoomUnit[4][2000]
    int array AttackRoomMax[4][2000]


    //1.回收组 2.刷怪组


    

    //设置组内单位数量
    private function SetNum(int pid,int index,int num)
        AttackRoomMax[pid][index] = num
    endfunction

    //读取组内单位数量
    private function GetNum(int pid,int index)->int
        return AttackRoomMax[pid][index]
    endfunction


    //根据序号设置单位
    private function SetUnit(int pid,int index,int num,unit u)
        AttackRoomUnit[pid][index*100+num] = u
    endfunction
    //根据序号读取单位
    private function GetUnit(int pid,int index,int num)->unit
        return AttackRoomUnit[pid][index*100+num]
    endfunction

    //获取单位在组内序号
    function GetAttackRoomUnitNum(int pid,int index,unit u)->int
        int max = GetNum(pid,index)
        for i = 1,max
            if  GetUnit(pid,index,i) == u
                return i
            endif
        end
        return 0
    endfunction

    //判断单位是否在组内
    function IsAttackRoomUnit(int pid,int index,unit u)->bool
        return GetAttackRoomUnitNum(pid,index,u) != 0
    endfunction

    //回收单位
    private function RecUnit(int pid,int index,unit u)
        int max = GetNum(pid,index)+1
        SetUnit(pid,index,max,u)
        SetNum(pid,index,max)
    endfunction

    unit outunit = null
    //根据序号 取出单位
    private function OutUnit(int pid,int index,int num)->unit
        int max = GetNum(pid,index)

        outunit = GetUnit(pid,index,num)
        
        if  max != num and max != 1
            SetUnit(pid,index,num,GetUnit(pid,index,max))
        endif

        SetUnit(pid,index,max,null)
        SetNum(pid,index,max-1)
        return outunit
    endfunction

    //根据单位取出单位
    function OutAttackRoomUnitByHandle(int pid,int index,unit u)
        int num = GetAttackRoomUnitNum(pid,index,u)
        if  num == 0
            BJDebugMsg("单位不在组内，无法取出")
        else
            OutUnit(pid,index,num)
        endif
    endfunction

    

    //创建练功房单位
    function CreateAttackRoomUnit(int pid,int unitid,real x,real y,real face)
        int max = GetNum(pid,1)
        unit u = null
        //BJDebugMsg("创建单位 max"+I2S(max))
        if  max == 0
            u = CreateUnit( Player(PLAYER_NEUTRAL_AGGRESSIVE), unitid, x, y,face)
            UnitAddAbility(u,'AZ95')
            SetPlayerOnlyDamage(u,pid)
            RecUnit(pid,2,u)//将单位存入组2
        else
            u = OutUnit(pid,1,max)//从组1中取出单位
            if  GetUnitTypeId(u) != unitid
                RemoveUnit(u)
                //BJDebugMsg("重新创建")
                CreateAttackRoomUnit(pid,unitid,x,y,face)
            else
                UnitAddAbility(u,'AZ95')
                SetUnitPathing( u, true )
                SetUnitInvulnerable( u, false )
                PauseUnit(u,false)
                SetUnitX(u,x)
                SetUnitY(u,y)
                //SetUnitAnimation( u, "stand" )
                ShowUnit(u,true)
                
                SetPlayerOnlyDamage(u,pid)
                RecUnit(pid,2,u)//将单位存入组2
            endif
        endif

        
    endfunction

    function AttackUnitTest(int pid)
        int max = 0
        max = GetNum(pid,1)
        BJDebugMsg("回收检测:max"+I2S(max))
        if  max > 0
        for i = 1,max
            BJDebugMsg("回收检测:Rec index"+I2S(i)+" "+GetUnitName(GetUnit(pid,1,i)))
        end
        endif
        max = GetNum(pid,2)
        BJDebugMsg("刷怪检测:max"+I2S(max))
        if  max > 0
        for i = 1,max
            BJDebugMsg("刷怪检测:Att index"+I2S(i)+" "+GetUnitName(GetUnit(pid,2,i)))
        end
        endif
    endfunction
    //刷一波怪
    function RefreshAttackRoom(int pid)
        int uid = GetAttackRoomUnitId(pid)
        real x = AttackRoomPostion[pid][1]
        real y = AttackRoomPostion[pid][2]
        int num = GetNum(pid,2)
        int max = GetPlayerAttackUnitNum(pid) - num
        if  max >= 1
            for i = 1,max
                CreateAttackRoomUnit(pid,uid,x,y,GetRandomReal(1,360))
            end
        else
            BJDebugMsg("错误的刷一波怪 但是被阻止了 max"+I2S(GetPlayerAttackUnitNum(pid))+" num"+I2S(num))
        endif
    endfunction

    //延迟刷一波怪
    function RefreshAttackRoomTimer(int p,real time)
        int pid = p
        if  AttackRoomUnitBool[pid] == false
            AttackRoomUnitBool[pid] = true
            TimerStart(time,false)
            {
                
                RefreshAttackRoom(pid)
                AttackRoomUnitBool[pid] = false
                endtimer
                flush locals
            }
        else    
            BJDebugMsg("限制了一波计时器刷怪")
        endif
        flush locals
    endfunction

    

    //青蛙
    function SoulToFrog(int pid)
        real x = AttackRoomPostion[pid][1] 
        real y = AttackRoomPostion[pid][2] 
        if  GetUnitTypeId(Pu[27]) == 'np27'
            RemoveUnit(Pu[27])
            
            Pu[27]=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np28',x+512,y+512,270)
            SetUnitState(Pu[27],UNIT_STATE_MAX_LIFE,1000)
            SetUnitState(Pu[27],UNIT_STATE_LIFE,1)
            SetTextTagText(AttackTexttag[pid],"0/1000",0.03)
            SetTextTagPos(AttackTexttag[pid],x+432,y+412,0)
            UnitAddEffectOfNPC(Pu[27])
            

            Pu[120]=CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'u001',x+256,y+512,225)
            UnitAddAbility(Pu[120],'Awan')
            UnitAddEffectOfNPC(Pu[120])
            SetPlayerOnlyDamage(Pu[120],pid)

            
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
        unit u1 =  CreateTmUnit(Player(pid),"xkt_boss_zhaohuan_miss.mdl",x,y,ang/0.01745+(40-speed)*GetRandomInt(-1,1),50,1.0)
        SetUnitPropWindow( u1, 6.26 )
        SetUnitTurnSpeed( u1, GetRandomReal(0.01,0.2))
        
        TimerStart(0.03,true)
        {
            real dis = Pdis(x1,y1,x2,y2)
            if  dis < 300
                speed = 49
            endif
            if  dis > 50 and GetUnitTypeId(Pu[27]) == 'np27'
                x1 = x1 + speed * Cos(GetUnitFacing(u1)*0.01745)
                y1 = y1 + speed * Sin(GetUnitFacing(u1)*0.01745)
                SetUnitFacing(u1,Pang(x1,y1,x2,y2)/0.01745)
                SetUnitX(u1,x1)
                SetUnitY(u1,y1)
            else
                real life = GetUnitState(Pu[27],UNIT_STATE_LIFE)+1
                real maxlife = GetUnitState(Pu[27],UNIT_STATE_MAX_LIFE)
                
                if  maxlife > 0
                    SetUnitState(Pu[27],UNIT_STATE_LIFE,life)
                    SetTextTagText(AttackTexttag[pid],I2S(R2I(life+0.001))+"/400",0.03)
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
        for i = 1,GetPlayerAttackUnitNum(pid)
            SoulTimerFunc(pid,x,y)
        end
    endfunction
    
    function AstrologyFunc(int pid)//占星
        real x = AttackRoomPostion[pid][1]
        real y = AttackRoomPostion[pid][2]
        int num = AttackRoomZXNum
        int id = 'u0CA'+num
        if  AttackRoomZXNum < 12
            AttackRoomZXNum = AttackRoomZXNum + 1
        endif

        bj_lastCreatedUnit = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),id,x+500,y+500,270)
        IssuePointOrderById(bj_lastCreatedUnit, 851983, AttackRoomPostion[pid][1], AttackRoomPostion[pid][2] )
        SetPlayerOnlyDamage(bj_lastCreatedUnit,pid)
        //UnitAddAbility(bj_lastCreatedUnit,'AZ31')
        UnitApplyTimedLife(bj_lastCreatedUnit, 'BHwe', 20 )
        bj_lastCreatedUnit = null
        

        if  GetUnitTypeId(Pu[1]) == 'H031'
            int lv = GetHeroAbilityLevel(Pu[1],'S531')
            int jj = GetUnitIntState(Pu[1],150)
            if  jj > 0
                if  lv >= 3
                    AddUnitRealState(Pu[1],2,jj * 500)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:姜子牙料事如神，法强|Cffff8000+"+I2S(jj*500)+"|r")
                elseif  lv >= 2
                    AddUnitRealState(Pu[1],2,jj * 400)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:姜子牙料事如神，法强|Cffff8000+"+I2S(jj*400)+"|r")
                else
                    AddUnitRealState(Pu[1],2,jj * 300)
                    DisplayTimedTextToPlayer(Player(pid),0,0,5,"|cffffcc00[系统]|r:姜子牙料事如神，法强|Cffff8000+"+I2S(jj*300)+"|r")
                endif
            endif
            
        endif
    endfunction

    //周天星辰阵
    function SoulTimer2FuncGivePrize(int pid)
        int num = AttackRoomXCNum
        int id = 'u0DA'+num
        real x = AttackRoomPostion[pid][1]
        real y = AttackRoomPostion[pid][2]
        
        if  num == 5 or num == 11 or num == 17 or num == 23
            AttackRoomXCUnitNum = 1
            bj_lastCreatedUnit = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),id,x+500,y+500,225)
            IssuePointOrderById(bj_lastCreatedUnit, 851983, AttackRoomPostion[pid][1], AttackRoomPostion[pid][2] )
            SetPlayerOnlyDamage(bj_lastCreatedUnit,pid)
            AddAttackSummonUnit(pid,bj_lastCreatedUnit)
            UnitApplyTimedLife(bj_lastCreatedUnit, 'BHwe', 20 )
            //UnitAddAbility(bj_lastCreatedUnit,'AZ31')
            bj_lastCreatedUnit = null
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r"+GetObjectName(id)+"来临！！")
        else
            AttackRoomXCUnitNum = 10
            for i = 1,10
                bj_lastCreatedUnit = CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE),id,x+500,y+500,225)
                IssuePointOrderById(bj_lastCreatedUnit, 851983, AttackRoomPostion[pid][1], AttackRoomPostion[pid][2] )
                SetPlayerOnlyDamage(bj_lastCreatedUnit,pid)
                AddAttackSummonUnit(pid,bj_lastCreatedUnit)
                UnitApplyTimedLife(bj_lastCreatedUnit, 'BHwe', 20 )
                //UnitAddAbility(bj_lastCreatedUnit,'AZ31')
                bj_lastCreatedUnit = null
            end
            DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[周天星辰阵]:|r第"+I2S(num+1)+"波星宿之灵来临！")
        endif
    endfunction

    function SoulTimer2Func(int id,real x,real y)
        int pid = id
        real x1 = x
        real y1 = y
        real x2 = GetUnitX(Pu[27])
        real y2 = GetUnitY(Pu[27])
        real ang = Pang(x2,y2,x1,y1)
        real speed = GetRandomReal(20,40)
        unit u1 =  CreateTmUnit(Player(pid),"xkt_boss_zhaohuan_miss.mdl",x,y,ang/0.01745+(40-speed)*GetRandomInt(-1,1),50,2.0)
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
                real life = GetUnitState(Pu[27],UNIT_STATE_LIFE)+GetPlayerAttackUnitNum(pid)
                real maxlife = GetUnitState(Pu[27],UNIT_STATE_MAX_LIFE)
                if  maxlife > 0
                    SetUnitState(Pu[27],UNIT_STATE_LIFE,life)
                    SetTextTagText(AttackTexttag[pid],I2S(R2I(life+0.001))+"/1000",0.03)
                    
                    //SetUnitVertexColor(Pu[27],255,255,255,55+R2I(205*(life/maxlife)))
                
                    if  life+0.5 >= maxlife
                        
                        SetUnitState(Pu[27],UNIT_STATE_LIFE,1)
                        SetTextTagText(AttackTexttag[pid],"0/1000",0.03)
                        LocAddEffect(GetUnitX(Pu[27]),GetUnitY(Pu[27]),"effect_az_bw_lina_t1-2.mdl")
                        SoulTimer2FuncGivePrize(pid)
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

    //回收死亡单位
    function RecoveryAttackRoomUnit(int pid,unit u)
        if  IsAttackRoomUnit(pid,2,u) == true
            OutAttackRoomUnitByHandle(pid,2,u)//从组2中移除
            if  IsAttackRoomUnit(pid,1,u) == false
                RecUnit(pid,1,u)//将单位存入组1
                UnitRemoveAbility(u,'AZ95')
                ShowUnit(u,false)
                UnitRemoveBuffs(u, true, true)
                SetUnitPathing( u, false )
                SetUnitInvulnerable( u, true )
                PauseUnit(u,true)
                int max = GetNum(pid,2)
                real x = GetUnitX(u)
                real y = GetUnitY(u)
                if  max == 0
                    //BJDebugMsg("怪物空了 刷一波")
                    RefreshAttackRoomTimer(pid,0.8)

                    if  GetUnitTypeId(Pu[27]) == 'np27'
                        SoulTimer(pid,x,y)
                    elseif  GetUnitTypeId(Pu[27]) == 'np28'
                        SoulTimer2(pid,x,y)
                    endif
                elseif  max < 0
                    if  IsAttackRoomUnit(pid,1,u) == true
                        //BJDebugMsg("该单位在组1")
                    endif
                    if  IsAttackRoomUnit(pid,2,u) == true
                        //BJDebugMsg("该单位在组2")
                    endif
                endif
            else
                BJDebugMsg("试图错误的回收单位，但是被阻止了！")
            endif
        endif
        //BJDebugMsg("回收单位 max1"+I2S(GetNum(pid,1))+" max2 "+I2S(GetNum(pid,2)))
    endfunction


    //死亡单位
    function AttackRoomUnitDeath(unit wu)
        int pid = GetUnitAbilityLevel(wu,'AZ99')-1

        if  pid >= 0
            RecoveryAttackRoomUnit(pid,wu)
        endif
    endfunction

    //练功房单位死亡
    function KillAttackRoomUnitEvent(unit wu,unit tu)
        
        //杀怪奖励
        PlayerHeroKillUnit.execute(wu,tu)

        //单位死亡回收
        AttackRoomUnitDeath(tu)
    endfunction







   


    function HeroMoveToRoom(int pid) //传送
        
        if  IsCanMoveToRoom(pid) == true
            real x = AttackRoomPostion[pid][1]
            real y = AttackRoomPostion[pid][2]
            real ux = GetUnitX(Pu[1])
            real uy = GetUnitY(Pu[1])
            if  x - 768 <= ux and ux <= x + 768 and y - 768 <= uy and uy <= y + 768
                ////BJDebugMsg("在练功房内")
            else
                SendPlayerUnit(pid,x,y)
                if  AttackRoomUnitBool[pid] == false
                    RefreshAttackRoom(pid)
                else
                    BJDebugMsg("阻止F3刷怪")
                endif

                if  GameChallengPlayerBool[pid][0] == true and GameChallengPlayerBool[pid][1] == true and GameChallengPlayerBool[pid][2] == true and GameChallengPlayerBool[pid][3] == true and GameChallengPlayerBool[pid][4] == false
                    GameChallengPlayerBool[pid][4] = true
                    AddPlayerState(pid,PLAYER_STATE_RESOURCE_GOLD,1000)
                    UnitAddItemEx(Pu[1],'I010')
                    DisplayTimedTextToPlayer(Player(pid),0,0,10,"|cffffcc00[完成任务]：|r奖励1000金币和"+GetObjectName('I010')+"！")
                    ShowPlayerTaskUIOfPlayer(pid,false,0)
                    SetPlayerTaskUIChatOfPlayer(pid," "," ",0)
                    SetPlayerTaskUITaskOfPlayer(pid," ",0)
                    InitPlayerGameGift.execute(pid)//加载礼包
                endif
            endif
        endif
    endfunction

    function AttackRoomInit()
        real x = 0
        real y = 0
        
        //初始化练功房刷怪坐标
        SetAttackRoomRefreshPostion(0,-8512,-5312)
        SetAttackRoomRefreshPostion(1,-5312,-5312)
        SetAttackRoomRefreshPostion(2,-5312,-8512)
        SetAttackRoomRefreshPostion(3,-8512,-8512)
        
        
        //初始化练功房进入坐标
        SetAttackRoomMovePostion(0,-8512,-5312)
        SetAttackRoomMovePostion(1,-5312,-5312)
        SetAttackRoomMovePostion(2,-5312,-8512)
        SetAttackRoomMovePostion(3,-8512,-8512)
        
        
        for pid = 0,3//玩家数量
            if  IsPlaying(pid) == true
            
                x = AttackRoomPostion[pid][1]
                y = AttackRoomPostion[pid][2]
                
                AttackSummonUnitGroup[pid] = CreateGroup()
                CreateUnit(Player(pid),'nc02',x-512,y+128,270)//技能商店
                CreateUnit(Player(pid),'nc01',x+128,y+512,270)//境界
                
                CreateUnit(Player(pid),'nc06',x,y-512,270)//礼包
                CreateUnit(Player(pid),'nc41',x,y-512,0)//积分兑换
                CreateUnit(Player(pid),'nc42',x-128,y+512,270)//挑战

                Pu[21]=CreateUnit(Player(pid),'np01',x+128,y+512,270)//境界

                Pu[22]=CreateUnit(Player(pid),'np02',x-512,y+128,270)//技能商店

                Pu[24]=CreateUnit(Player(pid),'np04',x+512,y+128,270)//副本入口
                ShowUnit(Pu[24],false)

                Pu[26]=CreateUnit(Player(pid),'np06',x,y-512,270)//礼包
                Pu[41]=CreateUnit(Player(pid),'np41',x,y-512,0)//积分兑换
                
                Pu[27]=CreateUnit(Player(pid),'np27',x+512,y+512,225)//送宝金蝉

                

                Pu[42]=CreateUnit(Player(pid),'np42',x-128,y+512,270)//挑战

                UnitAddAbility(Pu[27],'Avul')
                SetUnitState(Pu[27],UNIT_STATE_MAX_LIFE,400)
                SetUnitState(Pu[27],UNIT_STATE_LIFE,1)
                SetUnitVertexColor(Pu[27],255,255,255,50)
                PauseUnit(Pu[27],true)
                
                AttackRoomUnitBool[pid] = false
                AttackTexttag[pid] = CreateTextTag()
                SetTextTagText(AttackTexttag[pid],"0/400",0.03)
                SetTextTagPos(AttackTexttag[pid],x+176,y+412,0)

                RefreshAttackRoom(pid)

                //////////////////团本分割/////////////////////
                GameChallengPlayerUnit[pid][90] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np30',AttackRoomPostion[pid][1]+450,AttackRoomPostion[pid][2]-512,90)
                GameChallengPlayerUnit[pid][91] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e000',AttackRoomPostion[pid][1]+450-120,AttackRoomPostion[pid][2]-512+120,0)
                DzSetUnitModel(GameChallengPlayerUnit[pid][91],"effect2_tx-yuzhou.mdl")
                CreateTrigUnitInRangeOfGameChallenge(GetUnitX(GameChallengPlayerUnit[pid][91]),GetUnitY(GameChallengPlayerUnit[pid][91]),200,function EnRctGameTeamChallengA)
                ShowUnit(GameChallengPlayerUnit[pid][90],false)
                SetUnitVertexColor(GameChallengPlayerUnit[pid][91],255,255,255,0)
            endif
        end
    endfunction

endlibrary
