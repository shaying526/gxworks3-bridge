---
name: gxworks3-edit
description: 通过便携CLI读取和编辑GX Works3独立工程副本中的ST、FB、标签和简单结构体，按实际验证范围选择后台文件直改或用户明确选择的编辑器模式。用于明确对象的工程维护，不用于PLC在线操作。
---

# GX Works3 工程编辑

整理方式：AI 根据项目讨论整理。\
当前状态：两轴注释候选，配套 CLI 构建 `gx3-file-direct-preview-20261111-34`。\
最后更新：2026-11-10（Asia/Shanghai）。

## 定位与选择模式

- 使用用户提供的`gx3.exe`绝对路径，保留完整CLI目录。完整包中本Skill在`skill/gxworks3-edit/`，向上两级为`cli/`；单独安装Skill后仍须定位配套CLI。先读`help --json`及包内`VALIDATION.json`，不猜PATH、开发机路径或能力。
- 文件模式要求已验 GX Works3 1.128J 格式与显式控制器 DLL。旧 `file` 写入使用固定副本，`file registered` 使用独立登记和对象合同。遇到 `ProtectedProject` 或未知格式，保留拒绝结果和工程指纹。
- **文件直改模式优先用于已授权的正常后台编辑**：目标须保存关闭，CLI直接读写，不使用前台、鼠标、键盘或剪贴板。入口见[文件模式](references/file-direct.md)。不支持在打开工程内实时后台刷新。
- **编辑器操作模式**保留旧`daily`入口，会占用前台及输入设备。仅用户明确选择时读[编辑器命令](references/commands.md)，涉及IEC XML／实例再读[编辑器FB定义](references/fb.md)。文件模式受限不能自动改用前台模式。
- `editor validation-step`属于显式GX验收，会请求前台；仅用户已授权本次加载／转换／保存／关闭验证时使用，不承担普通文件编辑。
- V2.00 的 [登记命令速查](references/registered.md#v200-已验证扩展) 涵盖已证的主注释、宽标量标签、多实例 FB 改型，以及三使用方结构体更名、指定成员改型和 BOOL 尾成员增删。下面的 build 条目保留各次验证的具体范围。
- build34 候选增加两轴工程独立登记副本中的 17 条现有 FB／PRG 标签简中注释。按[注释命令范围](references/registered.md)核对原生工程、对象、成员和语言。
- build07的`file project inspect/register/status`提供只读兼容及副本基线登记，不扩大写权限；登记失败不得改路径、元数据或工程头绕过。原生关联计数不是业务依赖图。见[文件模式](references/file-direct.md)。
- build09新增独立的显式[已登记副本入口](references/registered.md)：`file registered`支持已识别单块ST正文及两份已验证实例结构体成员更名。整个调用期须目标关闭且没有其他目标写入；不能把登记成功当所有对象可写，也不将新入口混作旧固定工程命令。
- build13包含固定谱系的FB_CC／ProgPou／Global普通BOOL／INT变量维护，三表已完成三轮GX 0错误／0警告及清理，19表和原ST保持；命令及精确ID见[已登记副本](references/registered.md)。严格限定的BridgeCCType INOUT形状支持BOOL／INT成员更名，其中一次更名已完成GX 0错误／0警告验收，不推广到其他实例形状或写入类型。
- build15增加严格CLI自建无引用结构体成员及ST FB／MAIN PRG标签的登记维护入口，沿用原固定谱系和对象合同，见[已登记副本](references/registered.md)。未知／数组／复合或NULL类型文本行不能仅按原生类型码当作普通标量。
- build18扩展[限定INOUT尾成员](references/registered.md#限定-inout-尾成员build18)登记入口：仅一个BOOL尾成员新增、BOOL／INT尾成员更名与删除及双向改型，同型拒绝。963项相关检查、5次实际尾维护及四轮新CLI／GX0/0通过；恢复和完整包运行另证，具体能力及验收以配套CLI帮助和VALIDATION.json为准，不推广其他引用结构。
- build19新增[限定原成员入口](references/registered.md#限定-inout-原成员build19)，只针对BridgeCCType原Row2改型及原Row19槽删／加；AI须同步已引用ST，多命令期间保持关闭。1128项／14组及4项成功只读路由检查通过；改BOOL、恢复INT并删除原末行、原槽新增BOOL分别同步正文后，三轮GX均0错误／0警告。恢复及完整包状态以最终VALIDATION.json为准，配套CLI帮助决定实际可用范围。

- build20增加[限定INOUT中间原槽入口](references/registered.md#限定-inout-中间原槽build20)：仅原Row10改型及原槽删除／补回，其他18行身份和次序保持；AI同步ST依赖。1318项／15组及4项只读路由通过，三轮功能GX转换均0错误／0警告；恢复和完整包状态以最终VALIDATION.json为准。

- build22自建MAIN PRG VAR的REAL及独立登记单INT[0..7]纯数组完成限定GX验收；标量入口仍拒绝数组。参数与限制见[登记数组](references/registered.md#prg-real与单数组build22候选)。REAL与BOOL／DINT互转仅隔离测试，不称GX覆盖。
- build24候选的独立[PRG混表入口](references/registered.md#prg数组变长与标量混表build24候选)支持有限长度及最多四数组；限定工程GX联合验收与恢复已完成。旧标量及单数组入口守卫不变，实际包能力与验证以配套CLI帮助和VALIDATION.json为准。
- 自建PRG正文写入可能产生0/1/1编译标志，使自身或兄弟POU标签入口遭MAIN守卫拒绝。先完成本轮全部标签修改，再同步正文并转换；已出现该状态时先GX全部转换、保存关闭并核对结果，不放宽守卫绕过。
- source21候选增加[固定注释读／设置／清除](references/registered.md#固定注释source21候选)：仅ST_CC.iCMD简中及FB_CC.INPUT普通注释；CLI自建MAIN PRG VAR标签另有DINT候选，实际可用性和GX验收以配套CLI及包内记录为准。

## 文件编辑流程

1. 明确workspace、唯一副本和对象，确认工程保存关闭；声明不替代实际状态，占用／未保存状态不明时停止写入。用文件清单及读取取得对象ID和最新SHA，不凭名称或历史成功猜身份。
2. AI判断引用、声明、接口、变量依赖和编译时机，拆成明确操作；CLI不级联改其他对象。输入用工作区内UTF-8文件；类别、预期旧类型及ID按实际结果提供。
3. 串行调用CLI，等进程退出，保留stdout JSON、stderr、退出码。每次用最新projectSha256；备份和暂存回读由CLI完成。完整核对正文／表、其他行、接口和执行顺序；unchanged不代表原工程已编译，查看rebuildRequired。
4. 候选、写回、回读、GX加载、转换、保存及设备结果分别记证。not_run和旧缓存不是新编译证明。已授权时统一GX验证；未知模态或结果不明先只读重观测，不重放写入／确认。

多条命令只保证各自文件提交原子，不是跨对象批次事务。先备齐声明和完整正文，再串行写入；中途失败时保持工程关闭，核对已成功项、实际内容和最新SHA，标记批次未完成。原因明确且剩余操作仍在授权内时，用新指纹完成剩余明确操作并完整回读；不盲目重放、自动反向改名或把部分成功当整批完成。引用检查范围由AI按任务确定，不把局部无命中当全工程证明。

## 失败与边界

- 指纹、身份、类别、原类型、未知记录或外部绑定拒绝时，不放宽原生门禁。确认CLI退出后核对源指纹和实际内容，不凭partial猜未提交，不覆盖或自动回滚打开工程。
- 哈希备份只含磁盘，不含GX未保存会话。恢复须确认关闭、明确备份并遵守已有授权；不整体重置工作区。
- 注册提交最后检查到rename不是CAS；源指纹变化／未知日志时停止诊断，不自动rebind、清除日志或加载样例。load-snapshot会替换整个副本，只能用于明确授权的快照恢复或专项验证；不作为编辑失败的默认补救。
- 自定义 FB 基础定义使用普通 BOOL／INT 字段，EN／ENO 受保护，接口操作须显式提供 class。宽标量、有限数组及已实例化结构体使用各自的登记命令与布局门禁。[已验证扩展](references/registered.md#v200-已验证扩展)
- build07仅在CLI创建、无引用且state0的简单结构体中增加DINT，支持定义及成员维护；source21另限定支持CLI自建MAIN PRG VAR标签DINT，FB和固定三表不因此扩展。实际GX验收看同包记录。
- 编辑器模式继续遵守XML确认和剪贴板约束，默认preserve；不得因文件编辑受限而反复让用户代点，或用业务AI截图／点击补齐。
- 验收辅助的 `activate-proof-st` 和 `show-output` 均仅用于显式前台验证，不作为正常编辑手段；Computer Use截图／点击仍失败，部分键盘可用，不把CLI辅助或人工操作当作其已修复的证明。
- 自包含包无需全局.NET／SDK、PATH或MCP安装；厂商DLL由本机合法GX安装只读提供，不随包复制。不下载PLC、启停或强制IO，不把转换成功当设备验证。
