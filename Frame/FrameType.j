library FRAME initializer FRAMEInit uses OriginGameFrame
    
    
    int LocalFrame = 0
    function FRAMEInit()
        LocalFrame = FRAME.create()
    endfunction
    struct FRAME
        int frameid //控件id
        int Alpha //透明度
        int Red
        int Green
        int Blue
        real x //x坐标
        real y //y坐标
        real Width //宽度
        real Height //高度
        real Offset //动画进度
        boolean Show //显示


        
        //fdf创建
        static method Fdf(string name,integer parent,integer id)->int
            return DzCreateFrame(name,parent,id)
        endmethod
        //tag创建
        static method Tag(string TagType,string name,int parent,int id)->int
            return DzCreateFrameByTagName(TagType,name, parent,"template",id)
        endmethod
        //设置锚点
        method SetPoint(integer point,integer frame,integer framepoint,real x,real y)
            DzFrameSetPoint(.frameid,point,frame,framepoint,x,y)
            .x = x
            .y = y
        endmethod
        //设置绝对瞄点
        method SetAbsPoint(integer point,real x,real y)
            DzFrameSetAbsolutePoint(.frameid,point,x,y)
            .x = x
            .y = y
        endmethod
        //设置模型
        method SetModel(string file,integer ftype,integer flag)
            DzFrameSetModel(.frameid,file,ftype,flag)
        endmethod
        //设置动画
        method SetAnimate(integer id,boolean auto)
            DzFrameSetAnimate(.frameid,id,auto)
        endmethod
        //设置贴图
        method SetTexture(string texture,integer flag)
            DzFrameSetTexture(.frameid,texture,flag)
        endmethod
        //设置文字
        method SetText(string text)
            DzFrameSetText(.frameid,text)
        endmethod
        //设置缩放
        method SetScale(real value)
            DzFrameSetScale(.frameid,value)
        endmethod
        //设置大小
        method SetSize(real w,real h)
            DzFrameSetSize(.frameid,w,h)
            .Width = w
            .Height = h
        endmethod
        //颜色
        method SetColor(int r,int g,int b)
            DzFrameSetVertexColor( .frameid, DzGetColor(r, g, b, 255) )
            .Red = r
            .Green = g
            .Blue = b
        endmethod

        //读取show
        method operator show takes nothing returns bool
            return .Show
        endmethod
        //设置show
        method operator show= takes bool value returns nothing
            DzFrameShow(.frameid,value)
            .Show = value
        endmethod
        //读取动画进度
        method operator offset takes nothing returns real
            return .Offset
        endmethod
        //设置动画进度
        method operator offset= takes real value returns nothing
            DzFrameSetAnimateOffset(.frameid,value)
            .Offset = value
        endmethod

        
        //读取red
        method operator red takes nothing returns int
            return .Red
        endmethod
        //读取greed
        method operator green takes nothing returns int
            return .Green
        endmethod
        //读取blue
        method operator blue takes nothing returns int
            return .Blue
        endmethod
        
        //设置red
        method operator red= takes int value returns nothing
            SetColor(value,.Green,.Blue)
        endmethod
        //设置green
        method operator green= takes int value returns nothing
            SetColor(.Red,value,.Blue)
        endmethod
        //设置blue
        method operator blue= takes int value returns nothing
            SetColor(.Red,.Green,value)
        endmethod

        
        //读取alpha
        method operator alpha takes nothing returns int
            return .Alpha
        endmethod
        //设置alpha
        method operator alpha= takes int value returns nothing
            DzFrameSetAlpha(.frameid,value)
            if  value > 255
                value = 255
            elseif  value < 0
                value = 0
            endif
            .Alpha = value
        endmethod
        //读取宽度
        method operator width takes nothing returns real
            return .Width
        endmethod
        //设置宽度
        method operator width= takes real value returns nothing
            .SetSize(value,.Height)
        endmethod
        //读取高度
        method operator height takes nothing returns real
            return .Height
        endmethod
        //设置高度
        method operator height= takes real value returns nothing
            .SetSize(.Width,value)
        endmethod
        
    endstruct
    struct BUTTON
        int button
        int model
        int text
        int array back[5]
        
        method Assignment(int index)
            .button = BUTTON_Button[index]
            .model = BUTTON_Model[index]
            .text = BUTTON_Text[index]
            for i = 0,4
                .back[i]=BUTTON_Back[index][i]
            end
        endmethod
    endstruct
endlibrary
