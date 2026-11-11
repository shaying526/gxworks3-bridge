# 文件直改模式

本页保留固定副本命令。build13的显式`file registered`操作、三个固定变量owner及其登记、并发和恢复边界见[已登记副本](registered.md)；固定三表三轮GX 0/0并清理，19表及原ST保持。BridgeCCType限定INOUT形状支持BOOL／INT成员更名，其中一次更名已完成GX验收，不推广其他实例或类型。旧metadata status不自动授予这些操作，也不以改变工程头绕过旧门禁。

build15将既有严格CLI自建无引用结构体成员及ST FB／MAIN PRG标签维护接入登记会话。build18扩展[限定INOUT单尾成员入口](registered.md#限定-inout-尾成员build18)：支持尾成员BOOL／INT更名与删除、双向改型，新增仍仅BOOL；963项相关检查、5次实际尾维护及四轮新CLI／GX0/0通过，不推广其他引用形状。各批历史结果不替代本包验收；恢复、包身份及实际范围以同包VALIDATION.json及SHA256SUMS.json为准。

build19另有[限定INOUT原成员入口](registered.md#限定-inout-原成员build19)：仅原Row2改型及原Row19槽删／加，AI须同步已引用的实际使用方ST；1128项／14组及4项成功只读路由检查通过，三个功能方向同步正文后的三轮GX均0错误／0警告。恢复及完整包状态以最终VALIDATION.json为准。旧入口守卫不变，不支持时不得自动回退UI。

build20另有[限定INOUT中间原槽入口](registered.md#限定-inout-中间原槽build20)：原Row10的BOOL／INT改型、删除和空原槽BOOL补回；其余18行RowID／RowNo保持，非任意中间插入。AI处理ST依赖，恢复及完整包状态以最终VALIDATION.json为准。

build22候选独立PRG单数组的参数及限制见[登记数组](registered.md#prg-real与单数组build22候选)，标量入口仍拒绝数组。source21候选的两个固定注释及CLI自建MAIN PRG VAR DINT范围见[已登记副本](registered.md#固定注释source21候选)；清除恢复已观察的目标记录缺失态，验收以同包记录为准。

build24候选的独立[PRG混表与数组变长入口](registered.md#prg数组变长与标量混表build24候选)支持有限长度及最多四数组；旧标量和纯数组入口守卫不变。限定工程GX联合验收与恢复已完成，实际范围以配套CLI与VALIDATION.json为准。

先完成本轮全部POU标签操作，再同步正文并转换；已观察正文写后0/1/1标志会使自身或兄弟标签入口被MAIN守卫拒绝。若已发生，先GX全部转换、保存关闭并核对结果，不放宽守卫。

先读配套CLI的`help --json`及包内`VALIDATION.json`。当前是固定测试副本预览，工程根／格式必须被CLI识别，不支持任意业务工程。使用明确workspace／project绝对路径和本机已验GX1.128J的`Service/Native/Melco.GXW3.Controller.Project.Native.ProjectController.Impl.dll`；厂商DLL仅作格式／指纹读取。

工程先保存关闭。每次写入传`--project-closed true --expected-project-sha256 <最新SHA256>`，用实际返回指纹，GX保存后重新读；占用或未保存状态不明不写。共同参数为：

```powershell
$common = @('--workspace',$work,'--project',$project,'--gx-controller',$controller,'--json')
& $gx3 file st list @common
```

下列示例省略共同参数及写入门禁，实际执行须补齐。输入均为工作区内UTF-8文件。

## ST与FB／PRG

```text
file st list
file st read --kind PRG|FB --name <精确名称> --object-id <ID>
file st write --kind PRG|FB --name <名称> --object-id <ID> --code-file <UTF-8.st>
file fb add --name <新FB> --code-file <UTF-8.st> [--definition-file <UTF-8.json>]
file fb delete --name <名称> --object-id <新增返回ID>
file prg add --name <新PRG> --execution-target-id scan:MAIN --code-file <UTF-8.st>
file prg delete --name <名称> --object-id <ID> --execution-target-id scan:MAIN
```

清单返回kind、名称、对象／标签／正文ID、父对象和执行位置；PRG含执行序号。读取既有对象不等于允许写它；正文通用写入仅CLI创建的已验对象。旧不带控制器的ProgPou／FB_CC入口保持原范围。

MAIN末尾追加PRG，ProgPou保持第1；删除中间项保留其他ID，返回操作前后顺序。PRG删除前显式清空全部局部变量表（包括限定数组），引用由AI判断。新FB不带定义沿用固定模板；自定义JSON仅name及variables：

```json
{"name":"ExampleFb","variables":[{"name":"EnableIn","class":"VAR_INPUT","dataType":"BOOL"},{"name":"CountOut","class":"VAR_OUTPUT","dataType":"INT"},{"name":"WorkValue","class":"VAR","dataType":"INT"}]}
```

用户字段1–64，名称ASCII标识符1–24、字母开头，不重复、不用EN／ENO；类别仅VAR_INPUT／VAR_OUTPUT／VAR，类型BOOL／INT。EN／ENO由工具管理。删除校验实际完整表，不重传旧定义；未知关联拒绝。

## 标签

固定owner旧入口为`file label list|add|delete|set-type|rename --owner FB_CC|ProgPou|Global`。新建POU使用精确kind及ID：

```text
file label list --kind FB|PRG --owner <名称> --object-id <ID>
file label add --kind FB|PRG --owner <名称> --object-id <ID> --name <新变量> --data-type BOOL|INT [--class <类别>]
file label delete --kind FB|PRG --owner <名称> --object-id <ID> --name <变量> --expected-type BOOL|INT [--class <原类别>]
file label set-type --kind FB|PRG --owner <名称> --object-id <ID> --name <变量> --expected-type BOOL|INT --data-type BOOL|INT [--class <原类别>]
file label rename --kind FB|PRG --owner <名称> --object-id <ID> --name <旧名> --expected-type BOOL|INT --new-name <新名> [--class <原类别>]
```

CLI自建MAIN PRG的VAR标签另支持DINT及build22 REAL（上例类型参数可使用DINT或REAL）；legacy与registered共享核心，REAL限定GX验收完成，固定FB_CC／ProgPou／Global旧表及FB仍限BOOL／INT。REAL与BOOL／DINT互转仅隔离测试。默认class=VAR，PRG仅VAR；FB接口必须显式VAR_INPUT／VAR_OUTPUT，不能借默认VAR修改接口。EN／ENO不可写，类别不匹配拒绝。中间删除保留其他行／实例ID，LV／GV自动地址由GX重分配，不是固定业务地址。手动分配、别名、初值和未知关联拒绝。改名不改ST，AI配套声明和正文后一批统一转换。

声明改名和正文替换是两次独立提交。先备齐全文；第一步成功而第二步失败时工程可能暂时不一致，应保持关闭、核对实际结果和新指纹后完成仍已授权的剩余操作，不能打开转换并声称整批通过，也不自动回滚已成功项。

## 简单结构体

```text
file struct list
file struct read --name <名称> [--object-id <ID>]
file struct add --name <新名称> --definition-file <UTF-8.json>
file struct delete --name <名称> --object-id <ID>
file struct add-member --name <名称> --object-id <ID> --member <新成员> --data-type BOOL|INT|DINT
file struct delete-member --name <名称> --object-id <ID> --member <成员> --expected-type BOOL|INT|DINT
file struct rename-member --name <名称> --object-id <ID> --member <旧名> --expected-type BOOL|INT|DINT --new-name <新名>
file struct set-member-type --name <名称> --object-id <ID> --member <成员> --expected-type BOOL|INT|DINT --data-type BOOL|INT|DINT
```

定义为`{"name":"ExampleType","members":[{"name":"Ready","dataType":"BOOL"}]}`，1–64简单成员。配套build07在这类无引用结构体中额外接受DINT，定义及上述成员操作可使用BOOL／INT／DINT；验收范围看同包VALIDATION。固定三表及FB变量仍仅BOOL／INT；CLI自建MAIN PRG VAR另支持DINT及build22候选REAL。写入只限CLI创建、无外部实例且state0的已验完整形状。ST_CC旧注释／单尾行入口为独立固定范围，不代表任意业务结构可改。两个限定注释目标的候选新增与清除见[已登记副本](registered.md#固定注释source21候选)；其他语言及实例／嵌套按各自证据处理。

## 只读兼容与副本登记

```text
file project inspect --project <明确.gx3或.gx3.bak> --gx-controller <DLL>
file project register --project <既存副本> --source-project <只读来源或历史快照> --expected-project-sha256 <当前SHA> --expected-source-sha256 <来源SHA> --project-closed true --gx-controller <DLL>
file project status --project <已登记副本> --gx-controller <DLL>
```

共同workspace／JSON参数仍须提供。inspect只读当前关闭磁盘文件；recognized仅说明已识别的原生形状，未知结果如实保留。全表原生关联／分配计数和有限行样本不是业务依赖图，也不表示对象可编辑。

register只在工具内持久保存来源和副本基线的登记JSON，诊断临时数据库在工具cache创建并清理；只接受CLI明确限定的副本位置，不创建或修改工程，不授予其他工程写入权限。来源和副本SHA可以不同；原生锚点可被克隆继承，登记不证明复制历史。指纹、关闭声明、独立Windows文件身份、硬链接和重解析检查失败时停止，不能改登记／工程头绕过。status显示与基线的内容／文件ID变化，不自动刷新登记；原生身份或格式不再匹配时直接拒绝。正常GX保存或原子替换也可能改变文件ID。元数据不是安全令牌，旧文件写入门禁仍有效。

## 验收与恢复

文件命令不操作前台或共享输入。正文及声明变更按各自合同标脏；固定注释写入不额外标脏。保留或清理已识别归属的旧生成物，not_run不是新编译证明。`rebuildRequired`含原工程状态，`rebuildMarkedByThisWrite`仅说明本次标脏；同值不写且不清除已有脏状态。

显式获授权的GX验收可用`editor validation-step --pid <准确PID> --action status|open-dialog|open-project|rebuild|confirm-rebuild|save|project-menu|close`，传workspace/project。每次为单个请求，按原生状态推进；invocationReturned=false或空计数不是完成证据。只确认观察到的同一转换框，瞬态只重读，不重放未知输入。最后核对错误／警告、保存后完整正文／表、编译产物、空工程句柄与独占读取。

`activate-proof-st` 和 `show-output` 仅用于前台验收，不是正常编辑；Computer Use读取／截图／切页仍报 `0x80070486`，故障未修复，不能以此辅助或人工操作声明故障已解决。

失败转换可能部分落盘；仅明确支持的状态允许修复，其他状态保留并汇总需要的取证。用户要求后台时，不因文件模式拒绝自动改用daily或截图点击。
