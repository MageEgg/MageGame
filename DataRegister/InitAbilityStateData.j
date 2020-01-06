
scope AbilityStateData initializer init
    private function init()
        //输出代码
//call InitAbilityData('技能id',技能类型,品质,伤害参数,参数A,参数B,参数C,伤害类型,冷却时间,"技能名称","技能说明","技能图标")
call InitAbilityData('S0Q0',1,6,0,0,0,0,0,0,"Q技能","|cffffff00需求：\n|r|cff808080 - 完成新手任务|r","ReplaceableTextures\\CommandButtons\\BTNCancel.blp")
call InitAbilityData('S0W0',1,6,0,0,0,0,0,0,"W技能","|cffffff00需求：\n|r|cff808080 - 境界3解锁|r","ReplaceableTextures\\CommandButtons\\BTNCancel.blp")
call InitAbilityData('S0E0',1,6,0,0,0,0,0,0,"E技能","|cffffff00需求：\n|r|cff808080 - 境界5解锁|r","ReplaceableTextures\\CommandButtons\\BTNCancel.blp")
call InitAbilityData('S0R0',1,6,0,0,0,0,0,0,"R技能","|cffffff00需求：\n|r|cff808080 - 境界7解锁|r","ReplaceableTextures\\CommandButtons\\BTNCancel.blp")
call InitAbilityData('S0Q1',1,6,0,0,0,0,0,0,"Q技能","暂未学习技能","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0W1',1,6,0,0,0,0,0,0,"W技能","暂未学习技能","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0E1',1,6,0,0,0,0,0,0,"E技能","暂未学习技能","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S0R1',1,6,0,0,0,0,0,0,"R技能","暂未学习技能","ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
call InitAbilityData('S001',1,1,0,0,0,0,0,0,"鬼剑式","增加120%普攻伤害","ReplaceableTextures\\CommandButtons\\BTNS001.blp")
call InitAbilityData('S002',1,1,0,0,0,0,0,0,"夺天一击","每6秒，必定触发6倍致命一击","ReplaceableTextures\\CommandButtons\\BTNS002.blp")
call InitAbilityData('S003',1,1,0,0,0,0,0,0,"残暴","致命概率+20%，致命倍率+300%","ReplaceableTextures\\CommandButtons\\BTNS003.blp")
call InitAbilityData('S004',1,2,0,0,0,0,0,0,"无情","致命概率+5%，致命倍数+300%","ReplaceableTextures\\CommandButtons\\BTNS004.blp")
call InitAbilityData('S005',1,2,0,0,0,0,0,0,"横扫千军","分裂+70%","ReplaceableTextures\\CommandButtons\\BTNS005.blp")
call InitAbilityData('S006',8,2,1,4,0,0,1,6,"无影杀","周围怪物造成AD*4伤害，附带普攻效果。","ReplaceableTextures\\CommandButtons\\BTNS006.blp")
call InitAbilityData('S007',1,3,0,0,0,0,0,0,"巨人之力","增加100%普攻伤害，-80%攻击速度","ReplaceableTextures\\CommandButtons\\BTNS007.blp")
call InitAbilityData('S008',1,3,0,0,0,0,0,0,"摧枯","致命一击对怪物施加承受伤害+30%状态，不叠加","ReplaceableTextures\\CommandButtons\\BTNS008.blp")
call InitAbilityData('S009',1,3,0,0,0,0,0,2,"连击","攻击命中后立即追加一次普通攻击","ReplaceableTextures\\CommandButtons\\BTNS009.blp")
call InitAbilityData('S010',1,4,0,0,0,0,0,0,"技击","普攻伤害-40%,致命概率+30%","ReplaceableTextures\\CommandButtons\\BTNS010.blp")
call InitAbilityData('S011',1,4,0,0,0,0,0,0,"寸劲","致命概率-5%，致命倍率+400%","ReplaceableTextures\\CommandButtons\\BTNS011.blp")
call InitAbilityData('S012',1,4,0,0,0,0,0,0,"横扫","分裂+30%","ReplaceableTextures\\CommandButtons\\BTNS012.blp")
call InitAbilityData('S013',1,5,0,0,0,0,0,0,"知微","致命概率+15%","ReplaceableTextures\\CommandButtons\\BTNS013.blp")
call InitAbilityData('S014',1,5,0,0,0,0,0,0,"善武乏谋","法术伤害-100%，致命倍率+200%","ReplaceableTextures\\CommandButtons\\BTNS014.blp")
call InitAbilityData('S015',1,5,0,0,0,0,0,0,"洞察","致命概率+10%","ReplaceableTextures\\CommandButtons\\BTNS015.blp")
call InitAbilityData('S016',1,5,0,0,0,0,0,0,"骁勇","增加20%普攻伤害","ReplaceableTextures\\CommandButtons\\BTNS016.blp")
call InitAbilityData('S018',2,1,1,6,0,0,1,8,"破甲阵","对目标范围内怪物造成物理伤害，3s内增加15%穿透。可叠加","ReplaceableTextures\\CommandButtons\\BTNS018.blp")
call InitAbilityData('S019',1,2,0,0,0,0,0,0,"卸甲","增加25%护甲穿透","ReplaceableTextures\\CommandButtons\\BTNS019.blp")
call InitAbilityData('S020',1,3,0,0,0,0,0,0,"腐蚀","增加15%护甲穿透","ReplaceableTextures\\CommandButtons\\BTNS020.blp")
call InitAbilityData('S022',8,1,99,3,0,0,1,10,"强攻阵","对目标范围内怪物造成AD*3+AP*3物理伤害，3s内增加10%暴击。可叠加","ReplaceableTextures\\CommandButtons\\BTNS022.blp")
call InitAbilityData('S023',1,1,99,2,0,0,2,0,"天罚","攻击或释放技能暴击时，对目标范围内怪物造成AD*2+AP*2法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS023.blp")
call InitAbilityData('S024',1,1,0,0,0,0,0,0,"诛仙","增加15%暴击,100%暴击伤害","ReplaceableTextures\\CommandButtons\\BTNS024.blp")
call InitAbilityData('S025',1,2,0,0,0,0,0,0,"降魔","降低5%暴击，增加200%暴击伤害","ReplaceableTextures\\CommandButtons\\BTNS025.blp")
call InitAbilityData('S027',1,1,1,8,0,0,1,0,"九天御雷击","攻击15%概率对目标400范围造成AD×8物理伤害","ReplaceableTextures\\CommandButtons\\BTNS027.blp")
call InitAbilityData('S028',1,1,2,8,0,0,2,0,"冥月流星落","攻击15%概率对目标800范围造成AP×8法术伤害","ReplaceableTextures\\CommandButtons\\BTNS028.blp")
call InitAbilityData('S029',1,1,0,0,0,0,0,0,"天命","增加10%所有触发概率\n影响被动触发技能/多重施法/致命一击概率。","ReplaceableTextures\\CommandButtons\\BTNS029.blp")
call InitAbilityData('S030',1,1,99,4,0,0,1,0,"三昧真火","每8次攻击对释放三团火焰对扇形造成AD*4+AP*4物理伤害","ReplaceableTextures\\CommandButtons\\BTNS030.blp")
call InitAbilityData('S031',1,2,0,0,0,0,0,0,"魔茧","降低自身40%攻击速度。\n攻击20%几率4秒内增加自身110%攻击速度。","ReplaceableTextures\\CommandButtons\\BTNS031.blp")
call InitAbilityData('S032',1,2,0,0,0,0,0,0,"血之沸腾","增加50%攻击速度","ReplaceableTextures\\CommandButtons\\BTNS032.blp")
call InitAbilityData('S033',2,2,0,0,0,0,0,8,"燃魂咒术","增加40%攻击速度，持续时间内重复释放效果可叠加。","ReplaceableTextures\\CommandButtons\\BTNS033.blp")
call InitAbilityData('S034',1,3,0,0,0,0,0,0,"风扬阵","600码范围内所有玩家增加30%攻击速度","ReplaceableTextures\\CommandButtons\\BTNS034.blp")
call InitAbilityData('S035',1,3,2,4,0,0,2,0,"业火咒","每8次攻击对目标800范围内造成AP*4法术伤害","ReplaceableTextures\\CommandButtons\\BTNS035.blp")
call InitAbilityData('S036',1,3,0,0,0,0,0,0,"幻击","每次攻击视为2次攻击。（仅作用与攻击次数累计）","ReplaceableTextures\\CommandButtons\\BTNS036.blp")
call InitAbilityData('S037',1,4,0,0,0,0,0,0,"轻灵","普攻伤害-50%，攻击速度+40%","ReplaceableTextures\\CommandButtons\\BTNS037.blp")
call InitAbilityData('S038',1,4,1,4,0,0,1,0,"罡风破","每12次攻击对目标范围造成AD*4物理伤害","ReplaceableTextures\\CommandButtons\\BTNS038.blp")
call InitAbilityData('S039',1,4,2,4,0,0,2,0,"他山之石","每12次攻击对目标范围造成AP*4法术伤害","ReplaceableTextures\\CommandButtons\\BTNS039.blp")
call InitAbilityData('S040',1,5,2,2,0,0,2,0,"弱水咒","攻击12.5%概率对目标范围造成AP*2法术伤害","ReplaceableTextures\\CommandButtons\\BTNS040.blp")
call InitAbilityData('S041',1,5,0,0,0,0,0,0,"速攻","增加25%攻击速度","ReplaceableTextures\\CommandButtons\\BTNS041.blp")
call InitAbilityData('S042',1,5,0,0,0,0,0,0,"若风","法术伤害-50%，攻击速度+40%","ReplaceableTextures\\CommandButtons\\BTNS042.blp")
call InitAbilityData('S043',1,5,1,2,0,0,2,0,"气流杀","攻击12.5%概率对目标范围造成AD*2法术伤害","ReplaceableTextures\\CommandButtons\\BTNS043.blp")
call InitAbilityData('S045',1,1,0,0,0,0,0,0,"毒仙","毒体持续时间翻倍，每秒叠加2次，上限翻倍。","ReplaceableTextures\\CommandButtons\\BTNS045.blp")
call InitAbilityData('S046',2,2,2,1,0,0,2,6,"引爆","对自身范围内敌人造成AP*中毒叠加次数法术伤害","ReplaceableTextures\\CommandButtons\\BTNS046.blp")
call InitAbilityData('S047',2,3,2,0.25,0,0,2,16,"毒体","开启后使周围地方单位进入中毒状态，每秒损失AP*0.25生命。\n法术伤害，持续伤害可叠加，每秒叠加一次，上限8次。","ReplaceableTextures\\CommandButtons\\BTNS047.blp")
call InitAbilityData('S048',1,3,0,0,0,0,2,0,"狐媚术","攻击12.5%概率对目标范围施加一次魅惑，造成AP*3法术伤害，持续时间内降低6%攻速及移动速度。\n持续时间内，减速效果可叠加，上限8次","ReplaceableTextures\\CommandButtons\\BTNS048.blp")
call InitAbilityData('S049',2,3,2,0,0,0,2,8,"失心令","对自身范围内敌人造成AP*魅惑层数法术伤害","ReplaceableTextures\\CommandButtons\\BTNS049.blp")
call InitAbilityData('S052',3,1,2,6,0,0,2,6,"神火天降","对目标范围内敌人造成AP*6法术伤害，所有技能冷却缩减0.5秒。","ReplaceableTextures\\CommandButtons\\BTNS052.blp")
call InitAbilityData('S053',2,2,2,2,0,0,2,2,"落魂咒","对周围单位造成AP*2法术伤害，20%几率造成双倍伤害","ReplaceableTextures\\CommandButtons\\BTNS053.blp")
call InitAbilityData('S054',1,3,0,0,0,0,0,0,"法魂","不再享受任何冷却缩减，冷却转换为法强\n转换公式：冷却/80%","ReplaceableTextures\\CommandButtons\\BTNS054.blp")
call InitAbilityData('S056',1,3,0,0,0,0,0,0,"术神式","攻击1%重置所有技能冷却","ReplaceableTextures\\CommandButtons\\BTNS056.blp")
call InitAbilityData('S057',1,4,0,0,0,0,0,0,"灵犀式","攻击24次重置所有技能冷却","ReplaceableTextures\\CommandButtons\\BTNS057.blp")
call InitAbilityData('S058',1,4,0,0,0,0,0,0,"仙之心","增加15%冷却缩减","ReplaceableTextures\\CommandButtons\\BTNS058.blp")
call InitAbilityData('S059',1,5,0,0,0,0,0,0,"灵之心","增加10%冷却缩减","ReplaceableTextures\\CommandButtons\\BTNS059.blp")
call InitAbilityData('S061',1,1,0,0,0,0,0,0,"帝星","20%概率多重施法8次","ReplaceableTextures\\CommandButtons\\BTNS061.blp")
call InitAbilityData('S062',1,2,0,0,0,0,0,0,"帝命","多重施法触发时，额外释放技能次数+3","ReplaceableTextures\\CommandButtons\\BTNS062.blp")
call InitAbilityData('S063',1,3,0,0,0,0,0,0,"将星","40%概率多重施法2次","ReplaceableTextures\\CommandButtons\\BTNS063.blp")
call InitAbilityData('S065',3,1,2,6,0,0,2,8,"破法阵","对范围内怪物造成AP*6法术伤害，3s内增加15%法术穿透。可叠加","ReplaceableTextures\\CommandButtons\\BTNS065.blp")
call InitAbilityData('S066',1,2,0,0,0,0,0,0,"灭魂","增加25%法术穿透","ReplaceableTextures\\CommandButtons\\BTNS066.blp")
call InitAbilityData('S067',1,2,0,0,0,0,0,0,"威慑","降低周围怪物10%法术抗性，可与队友叠加。","ReplaceableTextures\\CommandButtons\\BTNS067.blp")
call InitAbilityData('S068',1,3,0,0,0,0,0,0,"穿魂","增加15%法术穿透","ReplaceableTextures\\CommandButtons\\BTNS068.blp")
call InitAbilityData('S070',3,1,1,2,0,0,1,0,"暴风剑雨","对目标范围内怪物造成多次攻击，每次攻击造成AD*2物理伤害。攻速影响攻击次数\n基础3次，每30%攻速额外增加1次。","ReplaceableTextures\\CommandButtons\\BTNS070.blp")
call InitAbilityData('S071',1,3,0,0,0,0,0,0,"妖之力","不再享受攻速加成，额外攻速转换为攻击力。\n转换公式：攻速/440%","ReplaceableTextures\\CommandButtons\\BTNS071.blp")
call InitAbilityData('S073',2,2,1,1.2,0,0,1,12,"混元珠","掷出4颗混元宝珠围绕自身旋转，每次碰撞到怪物时造成AD*1.2物理伤害，并眩晕0.5秒。\n对失明状态的怪物造成额外30%物理伤害。\n2秒后回收，并重置 戮目珠 的技能冷却","ReplaceableTextures\\CommandButtons\\BTNS073.blp")
call InitAbilityData('S074',3,3,1,3,0,0,1,6,"戮目珠","对目标范围掷出戮目宝珠，对碰撞到的怪物造成AD*3物理伤害，并使其进入失明状态，攻击命中率降低30%，持续3秒。\n2秒后回收。","ReplaceableTextures\\CommandButtons\\BTNS074.blp")
call InitAbilityData('S075',1,1,1,8,0,0,1,0,"夺命刺","攻击15%概率对目标造成AD*8物理伤害。\n触发后追加一次连环刺。（需已学习连环刺）","ReplaceableTextures\\CommandButtons\\BTNS075.blp")
call InitAbilityData('S076',1,3,1,3,0,0,1,0,"连环刺","攻击15%概率对目标范围造成AD*3物理伤害，\n触发后2s内夺命刺概率增加10%。","ReplaceableTextures\\CommandButtons\\BTNS076.blp")
call InitAbilityData('S078',3,1,1,1,0,0,1,8,"彗星灭世","对目标范围造成AD*3*蓄力时间物理伤害。攻击越高，蓄力时间越长。","ReplaceableTextures\\CommandButtons\\BTNS078.blp")
call InitAbilityData('S079',3,1,2,1,0,0,2,8,"龙神陨光","对指向直线范围造成AP*3*蓄力时间物理伤害。攻击越高，蓄力时间越长。","ReplaceableTextures\\CommandButtons\\BTNS079.blp")
call InitAbilityData('S080',3,2,1,1,0,0,1,8,"剑灵诛仙式","万剑出鞘，对目标范围造成攻击*2物理伤害。攻击越高，持续时间越长。","ReplaceableTextures\\CommandButtons\\BTNS080.blp")
call InitAbilityData('S081',3,2,2,1,0,0,2,8,"真空领域","将目标范围内的所有单位聚卷入重心，每0.5秒造成AP*1法术伤害。法强越高，持续时间越长。","ReplaceableTextures\\CommandButtons\\BTNS081.blp")
call InitAbilityData('S082',2,3,1,1,0,0,1,8,"雷神之子","召唤四个雷球，雷球每0.75秒对发起范围攻击造成AD*0.25物理伤害。攻击越高，雷球持续时间越长。","ReplaceableTextures\\CommandButtons\\BTNS082.blp")
call InitAbilityData('S083',2,3,2,1,0,0,2,8,"十方飓风破","自身每0.75秒向周围逸散暴风，造成AP*1法术伤害。法强越高，持续时间越长。\n每3w法强提升1秒","ReplaceableTextures\\CommandButtons\\BTNS083.blp")
call InitAbilityData('S085',1,1,0,0,0,0,0,0,"通灵秘术","幻影剑阵：飞剑25%几率造成2倍伤害\n天神道兵：进化为混沌道兵\n噬魂灵魄：伤害提高400%\n五行道兵：五行道兵持续时间提高50%","ReplaceableTextures\\CommandButtons\\BTNS085.blp")
call InitAbilityData('S086',2,2,0,0,0,0,0,20,"幻影剑阵","召唤4把飞剑，每把飞剑攻击9次幻化出额外一把飞剑。\n最多幻化1次。持续时间结束时，所有飞剑消失。\n飞剑继承人物30%攻击力，每秒攻击一次。\n持续18秒","ReplaceableTextures\\CommandButtons\\BTNS086.blp")
call InitAbilityData('S087',2,2,0,0,0,0,0,7,"五行道兵","召唤1个五行道兵，提高附近友军10%攻击速度，3%冷却缩减，3%暴击。\n同类增益可叠加。\n持续4秒","ReplaceableTextures\\CommandButtons\\BTNS087.blp")
call InitAbilityData('S088',1,2,0,0,0,0,0,0,"通灵契约","召唤物数量+2","ReplaceableTextures\\CommandButtons\\BTNS088.blp")
call InitAbilityData('S089',2,3,0,0,0,0,0,16,"天神道兵","召唤1个天神道兵。道兵每次攻击伤害递增10%，上限100%。\n道兵攻击=人物25%AP+25%AD，每秒攻击2次\n通灵秘术：进化为混沌道兵，攻击=人物50%AP+50%AD，每次攻击伤害递增20%，上限200%。\n持续12秒","ReplaceableTextures\\CommandButtons\\BTNS089.blp")
call InitAbilityData('S090',2,3,0,0,0,0,2,10,"噬魂灵魄","召唤1个噬魂灵魄，使周围600码单位生机骤减，每0.5秒损失AP*0.3生命。\n法术伤害，多个噬魂灵魄伤害可叠加。","ReplaceableTextures\\CommandButtons\\BTNS090.blp")
call InitAbilityData('S091',2,1,0,0,0,0,0,12,"魔主","吞噬场上属于自己的所有召唤物，4s内自身获得以下相应加成：\n幻影剑阵：暴击+30%\n五行道兵：AD+40%，AP+40%\n天道神兵：攻击速度+80%\n噬魂龙魄：冷却缩减-25%","ReplaceableTextures\\CommandButtons\\BTNS091.blp")
call InitAbilityData('S094',1,1,5,2.6,0,0,1,0,"五色华光","被攻击10%概率对周围敌人造成生命值*2.6物理伤害","ReplaceableTextures\\CommandButtons\\BTNS094.blp")
call InitAbilityData('S095',1,1,5,5,0,0,2,0,"佛陀法身","被攻击20%概率触对周围敌人AP*5法术伤害","ReplaceableTextures\\CommandButtons\\BTNS095.blp")
call InitAbilityData('S096',1,1,5,5,0,0,1,0,"酒仙剑舞","被攻击20%概率对周围敌人AD*5物理伤害","ReplaceableTextures\\CommandButtons\\BTNS096.blp")
call InitAbilityData('S097',1,1,5,2.6,0,0,2,0,"神怒","被攻击8次对自身范围内敌人造成生命值*2.6法术伤害","ReplaceableTextures\\CommandButtons\\BTNS097.blp")
call InitAbilityData('S098',1,2,1,2,0,0,1,0,"反震","被攻击10%概率对周围敌人造成生命值*2物理伤害","ReplaceableTextures\\CommandButtons\\BTNS098.blp")
call InitAbilityData('S099',1,2,0,0,0,0,0,0,"刚毅之心","最大生命值+15%","ReplaceableTextures\\CommandButtons\\BTNS099.blp")
call InitAbilityData('S100',2,2,0,0,0,0,0,0,"挑衅","增加怪物100%攻速，降低怪物70%攻击力","ReplaceableTextures\\CommandButtons\\BTNS100.blp")
call InitAbilityData('S101',3,3,1,2,0,0,1,0,"雷光破","对目标范围造成AD*2物理伤害，额外造成最大生命值*1.3物理伤害。","ReplaceableTextures\\CommandButtons\\BTNS101.blp")
call InitAbilityData('S102',1,4,5,0.6,0,0,2,0,"黑龙之灵","每0.8秒对自身范围内敌人造成生命值*0.6法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS102.blp")
call InitAbilityData('S103',2,5,0,0,0,0,0,8,"梦魇","召唤3个无敌的敌对鬼影环绕自身。\n鬼影攻击力为1，每秒攻击1次。","ReplaceableTextures\\CommandButtons\\BTNS103.blp")
call InitAbilityData('S104',1,5,5,0.3,0,0,0,0,"熔炉之身","每0.8秒对自身范围内敌人造成生命值*0.3法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS104.blp")
call InitAbilityData('S105',1,1,0,0,0,0,0,0,"后发制人","闪避时对攻击来源范围内敌人造成（AD+AP）*2法术伤害","ReplaceableTextures\\CommandButtons\\BTNS105.blp")
call InitAbilityData('S106',1,3,0,1,0,0,2,0,"未命名","闪避时对自身周围敌人造成（AD+AP）*1法术伤害","ReplaceableTextures\\CommandButtons\\BTNS106.blp")
call InitAbilityData('S107',1,2,0,0,0,0,0,0,"未命名","增加25%闪避","ReplaceableTextures\\CommandButtons\\BTNS107.blp")
call InitAbilityData('S108',1,3,0,0,0,0,0,0,"未命名","增加15%闪避","ReplaceableTextures\\CommandButtons\\BTNS108.blp")
call InitAbilityData('S109',1,5,99,0.5,0,0,1,0,"基础剑术","对目标附近200码范围造成攻击和法强相关的自适应伤害。","ReplaceableTextures\\CommandButtons\\BTNS109.blp")
call InitAbilityData('S111',2,4,2,2,0,0,2,12,"寒霜符箓","在自身脚下放置1个寒霜符，敌方单位进入该区域时发生爆炸，造成AP*2法术伤害。该技能属于召唤类技能","ReplaceableTextures\\CommandButtons\\BTNS111.blp")
call InitAbilityData('S112',3,4,1,1,0,0,1,32,"机关塔","召唤1个机关塔，每秒向360°发射8支箭，每支箭造成AD*1物理伤害。该技能属于召唤类技能","ReplaceableTextures\\CommandButtons\\BTNS112.blp")
call InitAbilityData('S113',3,4,1,3,0,0,1,8,"紫金葫","投射一个紫金葫，沿途造成AD*3物理伤害，到达目标区域后爆炸，造成AP*3法术伤害30%几率额外投射2个葫芦。","ReplaceableTextures\\CommandButtons\\BTNS113.blp")
call InitAbilityData('S114',1,4,0,0,0,0,0,0,"除妖","增加10%暴击率","ReplaceableTextures\\CommandButtons\\BTNS114.blp")
call InitAbilityData('S115',3,4,1,3,0,0,1,8,"震天箭","向目标区域射出一支震天箭，造成攻击*3物理伤害距离越远伤害越高","ReplaceableTextures\\CommandButtons\\BTNS115.blp")
call InitAbilityData('S116',2,4,2,2,0,0,2,8,"罪焰","自身600码范围随机点产生一次罪焰，造成AP*2法术伤害间隔1秒","ReplaceableTextures\\CommandButtons\\BTNS116.blp")
call InitAbilityData('S117',1,4,2,3,0,0,2,0,"元气破","攻击15%几率对目标范围造成AP*3法术伤害，并回复10点蓝量","ReplaceableTextures\\CommandButtons\\BTNS117.blp")
call InitAbilityData('S123',2,5,2,3,0,0,2,8,"冰暴术","自身600码范围随机点产生一次冰暴，造成AP*3法术伤害间隔1s","ReplaceableTextures\\CommandButtons\\BTNS123.blp")


call InitAbilityData('S230',9,0,1,12,0,0,1,20,"血之裂痕","扑杀目标范围，造成AD*12物理伤害，随后引发岩浆爆发，造成每秒AD*4伤害，持续3秒。","ReplaceableTextures\\CommandButtons\\BTNS230.blp")
call InitAbilityData('S231',10,0,2,2,0,0,2,20,"十绝阵","召唤道棺从天而降，砸向自身周围。每个道棺造成AP*2法术伤害。\n基础数量6个，每1W5法强增加1个道棺数。\n总持续时间3秒，施法期间无法攻击和移动。","ReplaceableTextures\\CommandButtons\\BTNS231.blp")
call InitAbilityData('S232',2,0,5,2,0,0,2,12,"八荒斗神","强制800范围内所有敌方单位攻击自己，伤害免疫+20%\n每次被攻击，对目标造成生命值*2法术伤害","ReplaceableTextures\\CommandButtons\\BTNS232.blp")
call InitAbilityData('S233',2,0,0,0,0,0,0,20,"冰封之域","2s后，自身周围敌人进入极冻状态（模拟眩晕），承受物理伤害+100%，承受法术伤害-50%。","ReplaceableTextures\\CommandButtons\\BTNS233.blp")
call InitAbilityData('S234',4,0,2,12,0,0,2,20,"离魂秘术","对目标造成AP*12伤害，随后使目标范围600码单位无法攻击，承受法术伤害+80%，承受物理伤害-50%","ReplaceableTextures\\CommandButtons\\BTNS234.blp")
call InitAbilityData('S235',2,0,0,0,0,0,0,15,"修罗之怒","释放后根据当前血量增加自身3%~33%暴击概率，持续时间内，每次暴击增加自身30%暴击伤害。","ReplaceableTextures\\CommandButtons\\BTNS235.blp")
call InitAbilityData('S236',4,0,0,12,0,0,2,12,"神威一击","突刺至目标身后，造成AD或AP*12伤害。随后攻击速度+220%。\n若攻击力最高，则造成攻击力相关物理伤害。\n若法术强度最高，则造成法强相关法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS236.blp")
call InitAbilityData('S237',2,0,0,0,0,0,0,20,"道法自然","持续时间内，冷却缩减+40%，每次释放技能增加自身10%伤害加成。","ReplaceableTextures\\CommandButtons\\BTNS237.blp")
call InitAbilityData('S238',2,0,1,2,0,0,1,20,"孔雀之魂","持续时间内，冷却缩减+40%，每次释放技能增加自身10%伤害加成。","ReplaceableTextures\\CommandButtons\\BTNS238.blp")
call InitAbilityData('S239',1,0,0,0,0,0,0,20,"未命名","获得后每波增加波数相关的金币&木头奖励。\n该收益在被替换后，效果消失。","ReplaceableTextures\\CommandButtons\\BTNS239.blp")
call InitAbilityData('S501',2,0,1,2,0,0,1,12,"天罚连击","向前挥砍后突刺造成大量伤害。\n挥砍一段：造成2*攻击物理伤害。\n挥砍二段：造成2*攻击物理伤害。\n突刺：8%目标已损失生命伤害。","ReplaceableTextures\\CommandButtons\\BTNS501.blp")
call InitAbilityData('S502',4,0,1,2,0,0,1,10,"土遁袭杀","钻入地底突进至目标身后进行2次爪击，每次造成攻击*2伤害。\n\n每提高100%攻击速度额外增加一次爪击。","ReplaceableTextures\\CommandButtons\\BTNS502.blp")
call InitAbilityData('S503',1,0,99,1,0,0,2,0.2,"玉清合荒","周围600码范围内的敌/友军释放主动技能时，对自身周围造成（攻击+法强）*1法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS503.blp")
call InitAbilityData('S504',2,0,1,2,0,0,1,10,"火尖枪舞","突刺并向前方瞬间刺击3次，每次造成攻击*2物理伤害。\n\n暴击达到30%时，额外造成一次刺击，造成攻击*8物理伤害。","ReplaceableTextures\\CommandButtons\\BTNS504.blp")
call InitAbilityData('S505',2,0,2,4,0,0,2,12,"一气化三清","幻化6个无法移动的分身，每个分身拥有70%攻击力。\n4秒后分身爆炸，对周围400码造成4*法强法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS505.blp")
call InitAbilityData('S506',1,0,0,0,0,0,0,0,"斩仙飞刀","斩杀低于15%最大生命值的敌人。","ReplaceableTextures\\CommandButtons\\BTNS506.blp")
call InitAbilityData('S507',1,0,0,0,0,0,0,0,"万物亲和","每5秒回复20%最大生命值\n\n物穿>30%:召唤物伤害+30%\n法穿>30%:召唤物数量+2","ReplaceableTextures\\CommandButtons\\BTNS507.blp")
call InitAbilityData('S508',1,0,2,6,0,0,2,0,"镜花之舞","每次触发被动技能可积累1层妖狐印记，达到7层时向周围释放镜花之舞。\n每层妖狐印记提高10%攻击速度，镜花之舞造成法强*6法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS508.blp")
call InitAbilityData('S509',1,0,0,0,0,0,0,0,"奕剑之道","奕剑之道，在于无招。\n普攻伤害+30%\n\n普攻伤害超过120%时，物理伤害+30%。","ReplaceableTextures\\CommandButtons\\BTNS509.blp")
call InitAbilityData('S510',2,0,0,0,0,0,0,2,"八九玄功","使用后依次变幻形态，并获得相应加成：\n金龙形态：暴击+10%\n白虎形态：攻速+45%\n人形态：冷却-10%","ReplaceableTextures\\CommandButtons\\BTNS510.blp")
call InitAbilityData('S511',1,0,0,0,0,0,0,0,"命途多舛","释放普通技能有50%几率失败，但成功了将增加2%伤害加成，上限150%。","ReplaceableTextures\\CommandButtons\\BTNS511.blp")
call InitAbilityData('S512',2,0,1,6,0,0,1,12,"天王宝塔","掷出天王宝塔镇压目标，造成攻击*6物理伤害并眩晕2秒。\n暴击>30%时，伤害翻倍。","ReplaceableTextures\\CommandButtons\\BTNS512.blp")
call InitAbilityData('S513',2,0,0,0,0,0,0,12,"身外法身","使用毫毛在目标地点幻化一个法身，可重复施放你的技能，但只造成50%伤害。\n\n法身无法攻击，不可选取，不受攻击。","ReplaceableTextures\\CommandButtons\\BTNS513.blp")
call InitAbilityData('S514',2,0,2,4,0,0,2,10,"冰封万里","对自身500码范围发动一次冰暴，造成法强*4法术伤害\n\n冷却缩减>30%：额外对自身800码发动一次冰暴，造成法强*6法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS514.blp")
call InitAbilityData('S515',1,0,2,8,0,0,2,0,"日月珠","每次施法凝聚一颗日月珠环绕自身，数量达到8颗时，向攻击目标造成法强*8范围伤害。","ReplaceableTextures\\CommandButtons\\BTNS515.blp")
call InitAbilityData('S516',2,0,0,0,0,0,0,30,"悔悟","自裁悔过，所有人回复满额生命，6秒内提高15%伤害加成。\n\n悔过次数>30：永久增加自身当前攻击60%","ReplaceableTextures\\CommandButtons\\BTNS516.blp")
call InitAbilityData('S517',1,0,0,0,0,0,0,0,"天资聪颖","每次学习技能获得一定法强永久加成。","ReplaceableTextures\\CommandButtons\\BTNS517.blp")
call InitAbilityData('S518',1,0,0,0,0,0,0,0,"九转神功","每次突破境界时，50%几率获得额外12%突破属性收益","ReplaceableTextures\\CommandButtons\\BTNS518.blp")
call InitAbilityData('S519',1,0,2,2,0,0,2,0,"天眼神光","攻击10%几率或施法时，开启天眼向自身范围发射神光，造成法强*2法术伤害。","ReplaceableTextures\\CommandButtons\\BTNS519.blp")
call InitAbilityData('S520',1,0,0,0,0,0,0,0,"莲花化身","承受技能伤害减少50%，免疫技能负面效果。","ReplaceableTextures\\CommandButtons\\BTNS520.blp")
call InitAbilityData('S521',2,0,0,0,0,0,0,40,"中秋快乐","每次使用获得一个随机月饼。\n蛋黄月饼：回复80%生命，解除异常状态\n豆沙月饼：回复70%蓝量\n冰皮月饼：攻击速度+60%\n果蔬月饼：法术伤害提高40%\n鲜肉月饼\n物理伤害提高40%\n\n状态持续15秒。","ReplaceableTextures\\CommandButtons\\BTNS521.blp")
call InitAbilityData('S522',1,0,0,0,0,0,0,0,"风雷咒术","获得风雷咒术加持，攻击速度提高200%。过快的攻击速度导致物理伤害降低70%。","ReplaceableTextures\\CommandButtons\\BTNS522.blp")
call InitAbilityData('S523',6,0,0,0,0,0,0,12,"狐媚术","回复目标30%生命并解除所有负面效果，4s内提高10%攻击和法强。","ReplaceableTextures\\CommandButtons\\BTNS523.blp")
call InitAbilityData('S524',6,0,0,0,0,0,0,180,"道友请留步","劝说目标队友分享属性：\n30%成功，该队友和你攻击及法强提高20%。\n40%暴力劝说，获得该队友40%攻击及法强。\n30%失败，队友获得你40%攻击及法强\n劝说效果持续3分钟。\n\n该技能冷却时间固定。","ReplaceableTextures\\CommandButtons\\BTNS524.blp")
call InitAbilityData('S525',2,0,1,2,0,0,1,8,"攒心钉","对目标范围发射3枚攒心钉，造成攻击*2物理伤害，4s内降低15护甲。\n\n效果不可叠加。","ReplaceableTextures\\CommandButtons\\BTNS525.blp")
call InitAbilityData('S526',1,0,1,1,0,0,1,6,"当头棒击","每6秒攻击对直线范围造成攻击*1物理伤害，该伤害必定触发暴击。","ReplaceableTextures\\CommandButtons\\BTNS526.blp")
call InitAbilityData('S527',6,0,0,0,0,0,0,30,"昏庸无道","处决一名队友，额外获得其30%攻击。","ReplaceableTextures\\CommandButtons\\BTNS527.blp")
call InitAbilityData('S528',1,0,0,0,0,0,0,0,"尚武乏谋","有什么问题是暴力不能解决的呢？\n物理伤害+50%，法术伤害-100%","ReplaceableTextures\\CommandButtons\\BTNS528.blp")
call InitAbilityData('S529',1,0,0,0,0,0,0,15,"神医救世","队友或你死亡时，直接复活。","ReplaceableTextures\\CommandButtons\\BTNS529.blp")
call InitAbilityData('S530',1,0,0,0,0,0,0,0,"百发百中","攻击必定命中。","ReplaceableTextures\\CommandButtons\\BTNS530.blp")
call InitAbilityData('S531',1,0,0,0,0,0,0,0,"料事如神","每次占星挑战成功，增加一定法强。","ReplaceableTextures\\CommandButtons\\BTNS531.blp")
    endfunction
endscope

