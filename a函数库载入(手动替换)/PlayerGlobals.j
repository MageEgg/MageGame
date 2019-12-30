library PlayerGlobals uses Define1

    int array           PlayerInt[12][680]
    unit array          PlayerUnit[12][680]
    item array          PlayerItem[12][680]
    bool array          PlayerBool[12][680]
    real array          PlayerReal[12][680]
    string array        PlayerString[12][680]
    effect array        PlayerEffect[12][680]
    timerdialog array   PlayerTimerDia[12][680]
    
    
    
    #define Pu      PlayerUnit[pid]
    #define Pi      PlayerItem[pid]
    #define Pe      PlayerEffect[pid]
    #define Pint    PlayerInt[pid]
    #define Pdia    PlayerTimerDia[pid]

    #define PlayerDeathBool             PlayerBool[pid][0] //玩家死亡判断
    #define ShowEffect                  PlayerBool[pid][1] //特效显示
    #define AttackRoomTimer             PlayerBool[pid][2] //练功房计时器是否运行
    
    #define PlayerColor                 PlayerString[pid][0] //玩家颜色
    #define GamePlayerName              PlayerString[pid][1] //玩家名字
    
    #define KillAttackUnitNum           PlayerInt[pid][11]//守家杀敌数量
    
    #define AttackRoomUnitNum           PlayerInt[pid][12]//练功房单位数量
    
    //110-119 英雄技能数据

    
    
    #define PlayerReviveX               PlayerReal[pid][0]//复活x
    #define PlayerReviveY               PlayerReal[pid][1]//复活y



    //300-350 副本数据
    
    
    //UI数据

    function GetPlayerIntState(int pid,int index)->int
        
        return 0
    endfunction
endlibrary
