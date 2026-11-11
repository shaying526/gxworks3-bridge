# daily 命令与输入

本页仅用于用户明确选择的前台编辑器操作模式。文件直改见[file-direct.md](file-direct.md)，文件模式受限不能自动改用daily。

## XML 导入确认

`daily structure create/update` 和 `daily fb create` 在本次文件提交内核对完整已知确认框、工程身份、候选封存及预期模式。创建使用“添加”，结构体更新使用“替换”；可设置组合框的默认模式不符时只选择一次，重新获取控件并稳定核对后确认一次。结构体更新仅接受精确同名目标且值为“替换”的禁用组合框，不对它发输入。其他禁用或不符状态拒绝。

操作目录保留 `confirmation-before.json`、`confirmation-verified.json`、`confirmation-attempt.json`、`confirmation-sent.json`、`import-completed.json`，失败时另有 `confirmation-failure.json` 或 `import-completion-failure.json`（到达相应阶段才存在）。attempt 表示调用已开始，sent 表示 Invoke 已返回；都不能替代即时完整回读。最终成功须 `targetReadbackVerified=true`。遇到未知反馈、超时、partial 或差异停止，`replayAllowed=false`；不要代点“是”、重复创建/导入或自动回滚。先用独立只读命令核对实际状态。实测覆盖以同包 `VALIDATION.json` 为准。

所有路径使用绝对本地路径。工作区须已存在且可写，避免UNC、符号链接、系统保护目录。普通使用仅调用`daily`；`help`同时列出旧固定实验入口，其历史限制不套到daily。

这是此候选包的接口说明；是否在对应CPU、GX版本及具体对象上通过，以同包`VALIDATION.json`与本次实际结果为准。不要从新增命令或离线解析成功推断原生导入、容量回读或编译已经通过。

r3保留相同命令，补齐实际TC6原生FB外围元数据读取，范围见[FB参考](fb.md#r3-原生读取兼容范围)。daily ST剪贴板读取与复制前后稳定的原生编辑器全文属性比较；不一致明确拒绝，不以单次复制或历史编译作为全文证明。

在PowerShell中先设置实际参数，例如：

```powershell
$gx3 = 'E:\GX Bridge\cli\gx3.exe'
$work = 'E:\GX Trial'
$source = 'E:\Source\Original.gx3'
$project = Join-Path $work 'projects\trial01\Trial.gx3'
& $gx3 help --json
& $gx3 daily project copy --workspace $work --source $source --out $project --json
```

先创建工作区目录，再执行copy。copy不覆盖目标，核对复制前/后源与目标hash一致，登记副本来源；后续保存无历史hash准入链。工作区及`.daily-projects`登记应一并保留。包内不附PLC工程。

在GX打开准确副本后设置共同参数；以下对象名均应替换成实际名称，不是固定模板：

```powershell
$common = @('--workspace', $work, '--project', $project, '--json')
& $gx3 daily objects @common
& $gx3 daily st read @common --name 'ActualProgram' --kind PRG --execution-target 'ActualScanFile'
```

`objects`只返回可见导航和已打开编辑器元数据，非全工程清单。导航最多处理256个展开目录项，只展开本次所需范围。可添加`--pid <实际进程ID>`避免多实例不明确；不要在PowerShell中重用系统变量`$PID`。

## ST

```powershell
& $gx3 daily st write @common --name 'ActualProgram' --kind PRG --code-file 'E:\GX Trial\inputs\ActualProgram.st'
& $gx3 daily st create @common --name 'NewProgram' --execution-target 'ActualScanFile' --code-file 'E:\GX Trial\inputs\NewProgram.st'
& $gx3 daily st delete @common --name 'ObsoleteProgram' --kind PRG --execution-target 'ActualScanFile'
```

- `.st`是UTF-8完整正文，不是补丁；不要以PowerShell5默认UTF-16写ST。可使用`[IO.File]::WriteAllText($path, $text, (New-Object Text.UTF8Encoding $false))`。
- `--execution-target`是实际父扫描执行文件名，可辅助展开目标；不能用“程序”等分类名代替。该父项当前不在视口时，导航可能在写前拒绝；若准确目标ST编辑器已经打开，可省略此可选参数直接读取/修改。不要把失败改成猜坐标点击，也不要把人工编辑当作CLI结果。
- 支持ST PRG读/写/创建/删除；准确已打开或已明确定位的ST FB用`--kind FB`读/写。`st create`仍只创建PRG；真实FB创建使用下节入口。FB删除未开放。程序删除含该程序的正文和局部表；其他对象引用不变。

## ST FB定义

```powershell
& $gx3 daily fb create @common --name 'NewProofFb' --fb-file 'NewProofFbFile' --definition 'E:\GX Trial\inputs\NewProofFb.xml'
& $gx3 daily fb read @common --name 'NewProofFb' --fb-file 'NewProofFbFile'
& $gx3 daily st read @common --name 'NewProofFb' --kind FB
& $gx3 daily st write @common --name 'NewProofFb' --kind FB --code-file 'E:\GX Trial\inputs\NewProofFb.st'
```

`fb create`接收一个完整单ST FB的IEC定义，新FB和绑定文件均应按实际对象核对。根须含`schemaVersion="1.000"`；用户候选不填写数字`orderWithinParamSet`，CLI按`Parameters`文档顺序，仅对接口变量在独立原生副本中补连续1起的必需格式序号，不给内部VAR补序号。原候选和派生原生输入分别留存，原生字节/哈希及名字映射见证据目录的`native-transport.json`。显式数字仍拒绝，不让AI手工填写数字绕过；数字无法独立回读时，不把它当作引脚身份或跨类别ABI已验。完整ST、同类有序声明、类型和显式容量仍须严格实际回读。

`--fb-file`可省略时由明确输入绑定/实际定位确定；同名或多层文件不明确时停止，不猜父文件。它仅属于`fb`定义命令，不能加到`label`或`st`命令；`--owner-kind`仅属于标签命令。

完整XML示例、四类声明、结构/FB类型引用与实际回读边界见[FB参考](fb.md)。`daily fb update`虽然可能出现在帮助列表，当前会在写前返回`DailyFbReplaceNotVerified`；修改声明使用明确标签编辑，修改正文使用`st write --kind FB`，不得用重建或覆盖整个FB文件代替修改。

## 标签

```powershell
& $gx3 daily label list @common --scope local --owner 'ActualProgram'
& $gx3 daily label add @common --scope local --owner 'ActualProgram' --name 'SeqValue' --definition 'E:\GX Trial\inputs\label-add.json'
& $gx3 daily label update @common --scope local --owner 'ActualProgram' --name 'SeqValue' --definition 'E:\GX Trial\inputs\label-update.json'
& $gx3 daily label delete @common --scope local --owner 'ActualProgram' --name 'SeqValue'
```

先读本次实际表头，JSON为原生列名到字符串值的对象。例如当实际中文表头相同时，局部新增`{"类":"VAR","数据类型":"INT","注释":"顺序值"}`，更新`{"数据类型":"DINT"}`；局部新增未给字段为空，修改未给单元格和其他行按原字节保留。不要猜其他语言表头或把JSON数值当字符串。

PRG为默认owner；FB声明使用相同操作并显式增加`--owner-kind FB`：

```powershell
& $gx3 daily label list @common --scope local --owner 'NewProofFb' --owner-kind FB
& $gx3 daily label add @common --scope local --owner 'NewProofFb' --owner-kind FB --name 'SeqValue' --definition 'E:\GX Trial\inputs\fb-label-add.json'
& $gx3 daily label update @common --scope local --owner 'NewProofFb' --owner-kind FB --name 'SeqValue' --definition 'E:\GX Trial\inputs\fb-label-update.json'
& $gx3 daily label delete @common --scope local --owner 'NewProofFb' --owner-kind FB --name 'SeqValue'
```

以上新增/修改/删除是互相独立的操作示例，按实际存在状态选择，不整段盲执行。`--owner-kind FB`仅用于`scope local`；不能用`--kind FB`替代，也不能把`--fb-file`传给标签命令来假定完成绑定。完整FB接口/内部声明与初值限制见[FB参考](fb.md)。完整表导入后其他行和未指定字段仍须逐字节保持，不自动配套修改正文或引用。

全局将scope改为`global`，owner为实际全局表名，且在已获覆盖剪贴板授权后加`--clipboard-policy replace`：

```powershell
& $gx3 daily label list @common --scope global --owner 'ActualGlobalTable'
& $gx3 daily label add @common --scope global --owner 'ActualGlobalTable' --name 'ReadyFlag' --definition 'E:\GX Trial\inputs\global-add.json' --clipboard-policy replace
```

- 首版全局表须非空且不超过256行，不能新建全局表。
- 全局新增JSON例如`{"类":"VAR_GLOBAL","数据类型":"BOOL"}`；类可省略或断言VAR_GLOBAL。更新只支持实际`标签名`/`数据类型`列。地址、注释、初值等字段暂未开放；当前不可控字段会拒绝，不能绕过检查。
- 全局新增保留旧完整行，只增加一行并核对显式字段；其他新行字段由GX产生原生默认值并报告。为提交默认字段会关闭重开该标签编辑器，这不等于工程保存/关闭重开。更新/删除要求完整实际CSV等于候选，不能归一化旧字段。

## 简单结构体

```powershell
& $gx3 daily structure read @common --name 'ActualType'
& $gx3 daily structure create @common --name 'NewType' --definition 'E:\GX Trial\inputs\NewType.xml'
& $gx3 daily structure update @common --name 'ActualType' --definition 'E:\GX Trial\inputs\ActualType.xml'
& $gx3 daily structure delete @common --name 'ObsoleteType'
```

输入必须为完整单结构IEC61131-10 XML；TC6导出只能作为原始证据，不能改后缀当作IEC导入。以下沿用本机已成功原生导入输入的完整形状，替换了示例名称和时间。按实际工程/结构/成员替换对应字段；其他GX版本仍须以其实际接受/回读及编译为准，不意味着任意厂商元数据都已覆盖：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project xmlns="www.iec.ch/public/TC65SC65BWG7TF10"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         schemaVersion="1.000"
         xsi:schemaLocation="www.iec.ch/public/TC65SC65BWG7TF10 GXW3_IEC61131_10_Ed1_0_ForGXW3.xsd">
  <FileHeader companyName="GxWorks3Bridge" companyURL="" productName="Daily CLI trial" productVersion="preview"/>
  <ContentHeader name="IndependentCopy" creationDateTime="2026-11-03T12:00:00+08:00"/>
  <Types><GlobalNamespace><DataTypeDecl name="NewType"><UserDefinedTypeSpec xsi:type="StructTypeSpec">
    <Member name="IsActive"><Type><TypeName>BOOL</TypeName></Type></Member>
    <Member name="SeqValue"><Type><TypeName>INT</TypeName></Type></Member>
  </UserDefinedTypeSpec></DataTypeDecl></GlobalNamespace></Types>
  <Instances/>
</Project>
```

此试用包另可投影明确的IEC`STRING[N]`/`WSTRING[N]`，例如`<TypeName>STRING[40]</TypeName>`；解析器支持的TC6形状`<string length="40"/>`对应基础类型和独立容量字段`stringLength:40`。本机FX5U独立副本的19成员结构及40容量已有原生写入、即时回读及保存重开回读证据；全部转换的具体结果以同包VALIDATION为准，WSTRING及其他环境不自动算通过。回读必须核对容量；未给容量的`null`不等于已确认40，不能删长度后仅比较STRING。编辑器显示、原生标签CSV与IEC输入的写法可能不同，不把这里的IEC写法直接猜成标签JSON类型值；中文编码或运行时截断行为另验。

准确结构体编辑器已打开时，读取可直接绑定该原生窗口，并核对实际导出的结构名。未打开时保留定向导航路径；目录或坐标无法确认就停止，可先只调整界面显示目标，不让用户手工修改定义或导出文件来冒充CLI结果。

其他仅支持简单成员类型名；数组、嵌套类型表达式等复杂形状仍拒绝。结构回读核对结构名、有序成员名/类型和显式字符串容量，保留原始XML；不宣称厂商元数据、注释等价。更新是明确完整定义，不会自动合并其他结构成员；AI应基于实际读取准备完整目标定义。删除不预先扫描或改其他引用。

## 结果与恢复目录

daily每次在`<workspace>/experiments/daily-cli/<操作ID>/`留证。写操作在变更前生成磁盘工程备份与`recovery.json`，核对源复制前/后及副本SHA-256/长度一致；失败在对象写入前停止。目标before/candidate/after与完整原始导出另存。磁盘备份只覆盖已保存版本，不能代替所有未保存IDE状态。

成功写入仍返回`not_saved`、`savePerformed=false`、`compilation=not_run`。保存重开/编译结果需另记用户或computer use来源。保存后hash变化正常；不从hash推断格式或语义正确。partial时保留目录与现场，不自动恢复或重试。
