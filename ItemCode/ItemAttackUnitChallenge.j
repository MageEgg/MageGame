library ItemAttackUnitChallenge uses DamageCode,ItemGameFunc

    int array AttackUnitChallengeStatePriceA[400][20]
    int array AttackUnitChallengeStatePriceB[400][20]
    int array AttackUnitChallengeStatePriceC[400][20]
    int array AttackUnitChallengeStatePriceD[400][20]

    int array AttackUnitChallengeStateType[400][20]
    int array AttackUnitChallengeStateTypeValueA[400][20]
    int array AttackUnitChallengeStateTypeValueB[400][20]
    int array AttackUnitChallengeStateTypeValueC[400][20]

    #define AttackUnitChallengeStateGold             AttackUnitChallengeStatePriceA
    #define AttackUnitChallengeStateLumber           AttackUnitChallengeStatePriceB

    #define Buy_Tech 0             
    #define Buy_Unit 1             
    #define Buy_Item 2              
    #define Buy_Unit_Item 3        

    function InitAttackUnitChallengeStateData(int zu,int wei,int gold,int lumber,int othertpye,int othervalue,int typeid,int typea,int typeb,int typec)                                                    
        AttackUnitChallengeStateGold[zu][wei] = gold
        AttackUnitChallengeStateLumber[zu][wei] = lumber
        AttackUnitChallengeStatePriceC[zu][wei] = othertpye
        AttackUnitChallengeStatePriceD[zu][wei] = othervalue

        AttackUnitChallengeStateType[zu][wei] = typeid //购买类型
        AttackUnitChallengeStateTypeValueA[zu][wei] = typea //类型参数
        AttackUnitChallengeStateTypeValueB[zu][wei] = typeb //类型参数 未使用的
        AttackUnitChallengeStateTypeValueC[zu][wei] = typec //类型参数 未使用的
    endfunction

    function InitAttackUnitChallengeState()
        InitAttackUnitChallengeStateData(0,0,1000,10,0,0,Buy_Tech,'ATAA',0,0)
        InitAttackUnitChallengeStateData(0,1,1000,10,0,0,Buy_Tech,'ATAB',0,0)
        InitAttackUnitChallengeStateData(0,2,1000,10,0,0,Buy_Tech,'ATAC',0,0)
        InitAttackUnitChallengeStateData(0,3,1000,10,0,0,Buy_Unit,'ATAD',0,0)
        InitAttackUnitChallengeStateData(0,4,1000,10,0,0,Buy_Tech,'ATAE',0,0)
        InitAttackUnitChallengeStateData(0,5,1000,10,0,0,Buy_Tech,'ATAF',0,0)
        InitAttackUnitChallengeStateData(0,6,1000,10,0,0,Buy_Tech,'ATAG',0,0)
        InitAttackUnitChallengeStateData(0,7,1000,10,0,0,Buy_Item,'ATAH','ID16',0)
        InitAttackUnitChallengeStateData(0,8,1000,10,0,0,Buy_Tech,'ATAE',0,0)
        InitAttackUnitChallengeStateData(0,9,1000,10,0,0,Buy_Tech,'ATAF',0,0)
        InitAttackUnitChallengeStateData(0,10,1000,10,0,0,Buy_Tech,'ATAG',0,0)
        InitAttackUnitChallengeStateData(0,11,1000,10,0,0,Buy_Unit_Item,'ATAH','ID16',0)

        ExecuteFunc("InitAttackUnitChallengeStateStock")
    endfunction

    function AddAttackUnitChallengeStateStock(int pid,int id)
        UnitAddAbility(Pu[42],id)
        
    endfunction

    function InitAttackUnitChallengeStateStock()
        for pid = 0,3
            if  IsPlaying(pid) == true
                for num = 0,11
                    AddAttackUnitChallengeStateStock(pid,'ATAA'+num)
                end
            endif
        end
    endfunction



endlibrary 
