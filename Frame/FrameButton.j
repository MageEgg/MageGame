library GameFrame uses FRAME
    int array BUTTON_Button //按钮
    int array BUTTON_Model //模型
    int array BUTTON_Text //文字
    int array BUTTON_Back[1000][5] //贴图

    function FrameSetScriptByExecute(int frame,integer eventId,int framenumber,int Type)
        InitFrame(frame,framenumber,Type)
        DzFrameSetScript( frame,eventId, "FrameFuncExecute"+I2S(eventId)+"n"+I2S(framenumber), true )
    endfunction
    
    function CreateText(int id,integer parent,string framename,int p1,int p2,real x,real y,string origin)
        BUTTON_Text[id] = DzCreateFrame(framename,parent, id)
        DzFrameSetPoint( BUTTON_Text[id], p1, BUTTON_Back[id][0], p2, x, y)
        DzFrameSetText(BUTTON_Text[id],origin)
    endfunction
 
    function CreateModel(int id,integer parent,int FrameType,int p1,int p2,real x,real y,string origin)
        BUTTON_Model[id] = DzCreateFrameByTagName("SPRITE","BUTTON_Model"+I2S(id), parent,"template",0)
        DzFrameSetPoint( BUTTON_Model[id], p1, BUTTON_Back[id][0], p2, x, y)
        DzFrameSetModel( BUTTON_Model[id], origin, 0, 0 )
        if  FrameType != TYPE_NOT
            FrameSetScriptByExecute( BUTTON_Model[id], 1,id,FrameType)
        endif
    endfunction

    function CreateButton(integer id,integer parent,int FrameType,int p1,int pointframe,int p2,real x,real y,real w,real h,string origin)
        BUTTON_Back[id][0] = DzCreateFrameByTagName("BACKDROP","BUTTON_Back"+I2S(id), parent,"template",0)
        
        DzFrameSetTexture(BUTTON_Back[id][0], origin, 0)
        DzFrameSetPoint( BUTTON_Back[id][0], p1, pointframe, p2, x, y)
        DzFrameSetSize( BUTTON_Back[id][0], w,h)
        

        if FrameType != TYPE_NOT
            //BUTTON_Button[id] = DzCreateFrameByTagName("BUTTON","BUTTON_Button"+I2S(id), parent,"template",0)
            BUTTON_Button[id] = DzCreateFrameByTagName("BUTTON","BUTTON_Button"+I2S(id), BUTTON_Back[id][0],"template",0)
            DzFrameSetPoint( BUTTON_Button[id], 4, BUTTON_Back[id][0], 4,0 , 0 )
            DzFrameSetSize( BUTTON_Button[id], w,h)
        endif
        
        for i = 1,4
            //BUTTON_Back[id][i] = DzCreateFrameByTagName("BACKDROP","BUTTON_Back"+I2S(id), parent,"template",i)
            BUTTON_Back[id][i] = DzCreateFrameByTagName("BACKDROP","BUTTON_Back"+I2S(id), BUTTON_Back[id][0],"template",i)
            DzFrameSetPoint( BUTTON_Back[id][i], 4, BUTTON_Back[id][0], 4,0 , 0 )
            DzFrameSetSize( BUTTON_Back[id][i], w,h)
            DzFrameSetTexture(BUTTON_Back[id][i], "war3mapImported\\alpha.tga", 0)
        end
        
        if  FrameType != TYPE_NOT
            FrameSetScriptByExecute( BUTTON_Button[id], 1,id,FrameType)
        endif
        
    endfunction
    
    
        
    
endlibrary

