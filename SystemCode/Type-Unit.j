struct unitex
    unit u
    method onDestroy takes nothing returns nothing
        //DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,60,I2S(this)+"unitDestroy")
        set .u = null
    endmethod
    //! textmacro GetState takes Name, value ,Code
        method operator $Name$ takes nothing returns $value$
            return $Code$
        endmethod
    //! endtextmacro
    
    //! textmacro SetState takes Name, value ,Code
        method operator $Name$= takes $value$ value returns nothing
            call $Code$
        endmethod
    //! endtextmacro
    
    //all
    //! runtextmacro GetState("lv","integer","GetHeroLevel(.u)")
    //! runtextmacro SetState("lv","integer","SetHeroLevel(.u,value,false)")
    
    //! runtextmacro GetState("str","integer","GetHeroStr(.u,true)")
    //! runtextmacro SetState("str","integer","SetHeroStr(.u,value,true)")
    
    //! runtextmacro GetState("agi","integer","GetHeroAgi(.u,true)")
    //! runtextmacro SetState("agi","integer","SetHeroAgi(.u,value,true)")
    
    //! runtextmacro GetState("int","integer","GetHeroInt(.u,true)")
    //! runtextmacro SetState("int","integer","SetHeroInt(.u,value,true)")
    
    //! runtextmacro GetState("x","real","GetUnitX(.u)")
    //! runtextmacro SetState("x","real","SetUnitX(.u, value)")
    
    //! runtextmacro GetState("y","real","GetUnitY(.u)")
    //! runtextmacro SetState("y","real","SetUnitY(.u, value)")
    
    //! runtextmacro GetState("face","real","GetUnitFacing(.u)")
    //! runtextmacro SetState("face","real","SetUnitFacing(.u, value)")
    
    //! runtextmacro GetState("life","real","GetUnitState(.u,UNIT_STATE_LIFE)")
    //! runtextmacro SetState("life","real","SetUnitState(.u,UNIT_STATE_LIFE, value)")
    
    
    //! runtextmacro GetState("mana","real","GetUnitState(.u,UNIT_STATE_MANA)")
    //! runtextmacro SetState("mana","real","SetUnitState(.u,UNIT_STATE_MANA, value)")
    
    //! runtextmacro GetState("p","player","GetOwningPlayer(.u)")
    //! runtextmacro SetState("p","player","SetUnitOwner( .u,value, true )")
    
    //! runtextmacro GetState("pid","integer","GetPlayerId(GetOwningPlayer(.u))")
    //! runtextmacro SetState("pid","integer","SetUnitOwner(.u,Player(value),true)")
    
    //! runtextmacro GetState("show","boolean","IsUnitHidden(.u)")
    //! runtextmacro SetState("show","boolean","ShowUnit(.u, value)")
    
    //! runtextmacro GetState("ph","unit","PlayerUnit[GetPlayerId(GetOwningPlayer(.u))][1]")
    
    //only Get
    //! runtextmacro GetState("maxlife","real","GetUnitState(.u,UNIT_STATE_MAX_LIFE)")
    //! runtextmacro GetState("maxmana","real","GetUnitState(.u,UNIT_STATE_MAX_MANA)")
    //! runtextmacro GetState("uid","integer","GetUnitTypeId(.u)")
    //! runtextmacro GetState("str2","integer","GetHeroStr(.u,false)")
    //! runtextmacro GetState("int2","integer","GetHeroInt(.u,false)")
    //! runtextmacro GetState("agi2","integer","GetHeroAgi(.u,false)")
    
endstruct
