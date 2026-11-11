# 显式已登记副本操作

## V2.00 已验证扩展

V2.00 对应 `gx3-file-direct-preview-20261110-33`，两轴注释候选对应 `gx3-file-direct-preview-20261111-34`。以下入口按具体原生布局判定。先取得当前对象身份和指纹，改型或更名所需的正文修改另用 `file registered st write` 提交。

| 对象与验证范围 | 命令后缀 |
| --- | --- |
| 已证的固定注释、CLI 自建 MAIN PRG 的已分配 INT／DINT／REAL 变量及支持尺寸的 INT 数组主注释 | `comment read\|set\|clear` |
| 固定 `FB_CC` 内部 REAL 行与固定 `Global` 的 DINT／REAL 两行布局 | `label list\|add\|delete\|rename\|set-type`，改型分别为 FB INT↔REAL 和 Global DINT↔REAL |
| `BridgeTimerProof` 的已证内部 DINT Row7 更名及两个已转换布局的 `iRecordCount` Row8 INT↔REAL | `pou label rename` 或 `pou label set-type`，对象 ID `dd1e4f7a7eb2374e`，`--kind FB --class VAR` |
| `BridgeCCType` 三使用方布局中的 DINT Row12 更名、`bMotionShield` Row10 BOOL↔INT | `struct rename-member` 或 `struct middle list\|set-type`，对象 ID `c44f7b686f30418c` |
| `BridgeCCType` 已证三使用方布局的单个 BOOL Row20 | `struct tail list\|add\|delete`，对象 ID `c44f7b686f30418c` |

三使用方尾成员新增提供合法不重名的 `--member` 和 `--data-type BOOL`。GX 转换、保存并关闭后，删除须提供精确的 `--member` 和 `--expected-type BOOL`。删除清理五条实例记录及两条自动分配。调用端先检查 ST 和其他引用。

下文的 build 编号、布局和测试结果对应当时的验收记录。对于同名命令，以上扩展与下方各自的历史布局分别判定。

此前INOUT更名及本批CLI自建对象维护有各自限定样本验收；已交付包的能力和验证以其CLI及VALIDATION.json为准。

build15新增的登记维护不开放未知谱系、对象或格式。创建入口仍沿原固定范围；新维护入口不等于任意登记副本可以创建／删除整对象。既有build13的879项检查及六轮GX结果保留其历史范围，不能替代build15本轮验收。包身份和验收以同包VALIDATION.json及SHA256SUMS.json为准。

build16的固定三表清单保留原生类型码；数组、复合、NULL类型文本或未知附加数据不能仅凭1/4就显示完整BOOL/INT。FB_CC.INPUT已证实的普通输入注释形状仍显示BOOL且受保护，额外未知字段不推广。写入守卫没有因此放宽。

仅用户授权的独立副本；工程在整个命令期间保存关闭且没有其他写者。目标限CLI认可的首份副本或workspace/projects/file-direct下既存副本，业务原件／部署路径不作为目标。登记JSON不是授权令牌；每次还校验来源实际SHA、双方文件身份／链接、原生profile和具体对象。

先用`file registered status`核对projectSha256、registrationSha256、nativeIdentity及当前支持入口。`file project status`仍只报告登记证据，writeAuthorized=false不代表新版显式注册命令不存在。旧inspect的legacy profile和新版目录profile范围不同，不改工程头或登记伪装成旧profile。未知版本／语义或具体对象拒绝时停止。

共同参数是`--workspace <绝对路径> --project <副本绝对路径> --gx-controller <已验DLL> --json`；每次写入还需`--project-closed true --expected-project-sha256 <最新SHA>`，推荐绑定`--expected-registration-sha256 <status返回值>`。来源宜使用明确的冻结快照，避免把正在变化的业务原件当长期登记基线。

```text
file registered status
file registered st list
file registered st read --kind PRG|FB --name <名称> --object-id <ID>
file registered st write --kind PRG|FB --name <名称> --object-id <ID> --code-file <完整UTF-8.st>
file registered label list --owner <owner> --owner-object-id <ID>
file registered label add --owner <owner> --owner-object-id <ID> --name <名称> --data-type BOOL|INT
file registered label delete --owner <owner> --owner-object-id <ID> --name <名称> --expected-type BOOL|INT
file registered label rename --owner <owner> --owner-object-id <ID> --name <旧名> --new-name <新名> --expected-type BOOL|INT
file registered label set-type --owner <owner> --owner-object-id <ID> --name <名称> --expected-type BOOL|INT --data-type BOOL|INT
file registered struct read --name <名称> --object-id <ID>
file registered struct rename-member --name <名称> --object-id <ID> --member <旧名> --new-name <新名> --expected-type BOOL|INT|DINT
```

ST只接受已识别普通单块、未加密数据库及精确对象／镜像；未注册Main草稿不返回可写目标。旧编译输出保留为过时缓存，需显式GX全部转换，not_run不是成功证明。

变量入口只接受旧固定工程谱系和原生锚点、完整registry／镜像／表与缓存合同，以及精确owner／object ID：`FB_CC`（`a399eba8b3458d98`）、`ProgPou`（`4d11259ebb22ded7`）、`Global`（`b9c952fc976a0b7b`）。只维护普通BOOL／INT变量；FB的EN／ENO、INPUT／OUTPUT接口受保护，未知绑定、手动地址、初值及数组拒绝。更名或改类型清除该行已识别的自动分配，删除也清除该行分配，须等待GX重建；不自动修改ST引用。空PRG／Global表首加与末行删除使用既有元数据生命周期，不新建或删除工程变量表对象。三表已完成三轮GX 0错误／0警告及清理，19表和原ST保持；最终范围以同包记录为准。

已验引用结构体更名仅限原生ID及完整实例／分配形状的BOOL／INT成员：BridgeStruct01（9a9ec4c699091cd6）、TrialStruct01（1d84c3b9e89dab8c），以及BridgeCCType（c44f7b686f30418c，严格19成员及FB VAR_IN_OUT实例形状、无设备分配）。BridgeCCType更名及明确ST引用同步后GX全部转换0错误／0警告，保存后19表仅目标名称单元变化，9个STDB仅一处引用变化；实例、关系和分配保持。保持ID、类型、顺序、实例和分配；未开放的类型码只按原始记录保留，不推测语义。AI同步明确ST引用。上述更名入口不支持增删／改型；BridgeCCType尾槽、原成员及中间原槽独立入口另见下文。先准备完整代码，分步命令不是跨对象事务；部分成功时保持关闭，核对新SHA后完成已授权剩余步骤。

build26 的 `DINT` 更名只适用于上述 BridgeCCType 单一 FB VAR_IN_OUT、19 成员、无分配布局。AI 根据实际引用另行更新 ST。已有带分配的 PRG 引用布局仍限 BOOL／INT 更名。

## 限定 INOUT 尾成员（build18）

独立`file registered struct tail`只接受root `2d9835db77c37b6b`、`BridgeCCType`对象`c44f7b686f30418c`和完整已证INOUT形状：原19成员名称／类型、39个定义和使用方实例及唯一INOUT关系必须匹配，无设备分配或未知附加记录。仅一个尾行20；新增时固定自身实例204、使用方实例205必须空闲，碰撞拒绝，不重新分配。调用者须确保尾成员未被ST引用；CLI不分析或级联修改ST。此入口不能修改原19成员，不开放多尾、其他类型、owner或实例形状。尾成员改型仅BOOL与INT双向，同型拒绝；更名与删除须精确匹配旧名和BOOL／INT旧类型。

下面省略共同参数及写入门禁；使用真实读取的对象和最新SHA，`<尾成员名>`为明确合法且不重名的名称：

```text
file registered struct tail list --name BridgeCCType --object-id c44f7b686f30418c
file registered struct tail add --name BridgeCCType --object-id c44f7b686f30418c --member <尾成员名> --data-type BOOL
file registered struct tail rename --name BridgeCCType --object-id c44f7b686f30418c --member <旧尾成员名> --new-name <新尾成员名> --expected-type BOOL|INT
file registered struct tail set-type --name BridgeCCType --object-id c44f7b686f30418c --member <尾成员名> --expected-type BOOL|INT --data-type BOOL|INT
file registered struct tail delete --name BridgeCCType --object-id c44f7b686f30418c --member <尾成员名> --expected-type BOOL|INT
```

真实GX三步种子与各态转换保存档已取得；build17的900项检查及三轮GX结果属于历史。build18的963项相关检查、5次实际尾维护及四轮新CLI／GX0错误／0警告通过，最后BOOL删除使用自带运行时CLI；恢复与完整包状态以最终记录及实际包的帮助和VALIDATION为准。CLI核验已观察缓存成员集合，保留其内容为过时缓存并标记需重建，不自动编译；缓存存在或标志不证明已编译。文件编辑仅在副本保存关闭后执行；第二种前台模式只在已授权时用于GX验证，一次原生种子取证例外不改变日常编辑模式。

## 限定 INOUT 原成员（build19）

独立 `file registered struct original` 仅接受root `2d9835db77c37b6b`、`BridgeCCType` 对象 `c44f7b686f30418c` 及唯一无分配的 `BridgeControlProof.stCC` INOUT完整profile。前18行固定，只有原Row2 `iCMD` 可在限定19行态切换INT／BOOL；Row19仅BOOL，使用原自身实例89与使用方实例118（父99）。所有原行、关联、槽位、schema和未知数据均须符合合同，冲突或不支持即拒绝，不猜新ID、不改为UI编辑。旧tail、read及rename守卫不因新入口放宽。

下面省略共同参数及写入门禁；始终以实际配套CLI帮助和最新身份／SHA为准：

```text
file registered struct original list --name BridgeCCType --object-id c44f7b686f30418c
file registered struct original set-type --name BridgeCCType --object-id c44f7b686f30418c --member iCMD --expected-type INT|BOOL --data-type BOOL|INT
file registered struct original delete --name BridgeCCType --object-id c44f7b686f30418c --member <当前末行名> --expected-type BOOL
file registered struct original add --name BridgeCCType --object-id c44f7b686f30418c --member <新末行名> --data-type BOOL
```

- `set-type` 只支持原Row2 `iCMD` 的INT↔BOOL，必须19行且末行为原 `bHomeArr : BOOL`，原类型须精确匹配；同型拒绝。
- `delete` 只接受Row19 BOOL的精确当前名，可以是 `bHomeArr` 或此槽受支持的替代名；`iCMD` 须为原INT。`add` 只接受精确18行、`iCMD` 为INT且原Row19／实例89、118及所有关联均空闲，新增合法不重名的BOOL并复用原槽。不可推及其他中间行或通用ID分配；Row10另有独立限定入口。
- AI须先读取并分析真实使用方ST、准备完整依赖同步，`iCMD` 与 `bHomeArr` 均已确认被引用；CLI不会级联更新，结果为 `referencesUpdated=false`、编译 `not_run`。多命令并非跨对象事务，声明和正文修改期间始终关闭目标；全部完成并回读后，才在授权范围内统一GX验证。

本批技术测试中，`iCMD` 改BOOL时将 `iCCState := stCC.iCMD;` 换成按该BOOL赋值 `iCCState` 1／0的IF；删除原末行时移除其目标赋值；新增 `BridgeOriginalAdded` 后写入对应目标赋值。这是该技术使用方的测试替换，不自动证明业务语义等价，其他使用方须按实际代码判断。

source19的1128项／14组及4项成功只读路由检查通过（19行和18行各2项）。CLI将 `iCMD` INT→BOOL并同步正文、改回INT后删除 `bHomeArr` 并同步正文、以自包含发布CLI 10.0.14复用原槽新增 `BridgeOriginalAdded` 并同步正文，三轮GX全部转换均0错误／0警告。原18行和原Row2改型的记录构造是推导方案，经这些GX操作验证，并非原生编辑种子。开发工作区的本批规格为 `docs/development/specs/2026-11-08-referenced-original-members.md`；恢复及完整包状态以最终VALIDATION.json为准，配套CLI帮助决定实际可用范围。


## 限定 INOUT 中间原槽（build20）

独立 `file registered struct middle` 仅接受root `2d9835db77c37b6b`、`BridgeCCType` 对象 `c44f7b686f30418c` 和唯一无分配 `BridgeControlProof.stCC` INOUT完整profile。原Row10/RowNo10为 `bMotionShield : BOOL`，自身实例80、使用方子实例109（父99）。其他18行的原名称、类型、RowID／RowNo及实例保持，未知关联、分配、schema或槽冲突拒绝；旧入口守卫不放宽。

以下省略共同参数及写入门禁，使用实际配套CLI帮助及最新SHA：

```text
file registered struct middle list --name BridgeCCType --object-id c44f7b686f30418c
file registered struct middle set-type --name BridgeCCType --object-id c44f7b686f30418c --member bMotionShield --expected-type BOOL|INT --data-type INT|BOOL
file registered struct middle delete --name BridgeCCType --object-id c44f7b686f30418c --member <当前Row10名称> --expected-type BOOL
file registered struct middle add --name BridgeCCType --object-id c44f7b686f30418c --member <合法新名称> --data-type BOOL
```

- 改型仅完整19行且原名 `bMotionShield` 时BOOL↔INT，精确旧类型；INT不能与替代名或缺槽组合。同型拒绝。
- 删除仅Row10的BOOL原名或合法替代名，精确匹配；剩余18行保留原RowID／RowNo，中间缺10。新增只在该精确缺槽、80／109及全部关联空闲时复用原槽加入合法不重名BOOL。这不是完整19行的任意中间插入，不分配未知ID、不重排后续行。
- AI先分析并同步实际使用方ST；CLI不级联，返回 `referencesUpdated=false`、`compilation=not_run`。多命令期间保持关闭并逐次核对最新SHA，完成依赖及回读后才按授权进行GX验证。

source20的1318项／15组与4项成功只读路由（19行、缺10各2）通过；4次middle和3次ST写入后，改INT、恢复BOOL并删 `bMotionShield`、原槽补 `BridgeMiddleAdded` 三轮功能GX全部转换均0错误／0警告并保存关闭。23轮中断后用户重开，24轮验证保存成功，但重开后的输入SHA未能重读，不能据此声称跨重开连续性已验证。缺槽与改型是受限推导并经上述GX验证，不是原生编辑种子；恢复及完整包状态以最终VALIDATION.json为准。

## 标签和成员注释

先读取配套 CLI 帮助并用共同参数绑定独立登记副本。固定身份如下：

```text
file registered comment read --kind STRUCT --name ST_CC --object-id 2cebde61f9d55ce3 --member iCMD --language zh-CN
file registered comment read --kind FB --name FB_CC --object-id a399eba8b3458d98 --member INPUT --language default
```

同一命令支持已转换的 CLI 自建 MAIN ST PRG 中已分配的 INT／DINT／REAL 普通 VAR 标量，以及 build26 起受 mixed 合同支持的一维 INT 数组。用 `file registered st list` 确认 PRG 对象 ID，再明确变量名：

```text
file registered comment read --kind PRG --name <PRG> --object-id <ID> --member <变量名> --language default
```

`set`／`clear` 使用同样身份，另带共同写入门禁及 `--expected-comment-sha256 <读取返回的textSha256>`；`set` 还须 `--comment-file <工作区UTF-8.txt>`，文本非空且非全空白、单行、最多32个UTF-16代码单元。`read` 的 `present`、`text` 和 `textSha256` 区分现有文本与 `absent`；现有文本使用UTF-8 SHA-256，缺记录为小写 `absent`。按最新结果串行写入；旧注释指纹不符即拒绝。

`clear` 删除目标注释单元。重复设置相同文本或清除缺记录返回 `unchanged`。纯注释写入保留 ST、分配及编译状态。mixed 更名、受支持的改型与数组变长保留注释，删除整行会移除该行注释。带注释改为 BOOL 前先显式清除注释。全局标签、其他语言和未知原生记录超出本候选范围。

build34 候选支持 `native128/6bfa4931ccdd0505` 独立登记副本的两轴标签简体中文注释。参数和写入门禁同上，指定 `--language zh-CN`。该路径仅写第 16 列，保留默认语言列。

| `--kind` | `--name` | `--object-id` | `--member` |
| --- | --- | --- | --- |
| FB | FB_AxisBasic | 8ea8bf7944e21d6a | AxisNo、Input、Output、Axis、fbPower、fbHome、fbMoveRelative、fbMoveAbsolute、iBoundAxisNo、iReadyIndex、iReadBase、iCommand、dwPosition |
| PRG | ProgPou | 8af5bce1946506ba | AxisInput、AxisOutput、fbAxis1、fbAxis2 |

## CLI自建对象维护

下列命令也使用上述共同参数和写入门禁。只接受原固定root/version、FB_CC及ProgPou原生锚点，且对象确定性ID、原生树／镜像、数据库、实例和缓存完整匹配；不是凭登记存在或对象名字授予写权限。

```text
file registered struct member list --name <结构名> --object-id <ID>
file registered struct member add --name <结构名> --object-id <ID> --member <新成员> --data-type BOOL|INT|DINT
file registered struct member delete --name <结构名> --object-id <ID> --member <成员> --expected-type BOOL|INT|DINT
file registered struct member rename --name <结构名> --object-id <ID> --member <旧成员> --new-name <新成员> --expected-type BOOL|INT|DINT
file registered struct member set-type --name <结构名> --object-id <ID> --member <成员> --expected-type BOOL|INT|DINT --data-type BOOL|INT|DINT
file registered pou label list --kind FB|PRG --owner <名称> --owner-object-id <ID>
file registered pou label add --kind FB|PRG --owner <名称> --owner-object-id <ID> --name <新变量> --data-type BOOL|INT|DINT|REAL [--class VAR|VAR_INPUT|VAR_OUTPUT]
file registered pou label delete --kind FB|PRG --owner <名称> --owner-object-id <ID> --name <变量> --expected-type BOOL|INT|DINT|REAL [--class VAR|VAR_INPUT|VAR_OUTPUT]
file registered pou label rename --kind FB|PRG --owner <名称> --owner-object-id <ID> --name <旧变量> --new-name <新变量> --expected-type BOOL|INT|DINT|REAL [--class VAR|VAR_INPUT|VAR_OUTPUT]
file registered pou label set-type --kind FB|PRG --owner <名称> --owner-object-id <ID> --name <变量> --expected-type BOOL|INT|DINT|REAL --data-type BOOL|INT|DINT|REAL [--class VAR|VAR_INPUT|VAR_OUTPUT]
```

结构体只维护CLI自建、无引用、state0简单成员；不能用于BridgeCCType等已引用对象。不能删除最后一个成员；同名更名／同类型修改沿用明确拒绝且不出版。未知附加记录、分配、关联及数组／嵌套均拒绝。

POU标签只维护CLI自建ST FB／MAIN scan PRG，类别默认VAR。PRG VAR的新增、读取、改型、更名、删除支持DINT及build22 REAL；legacy与registered共享核心，REAL限定GX验收完成，REAL与BOOL／DINT互转仅隔离测试。FB仅BOOL／INT，固定三个owner的入口不扩展。FB接口的所有修改／删除／更名须显式class，PRG只接受VAR，EN／ENO受保护；失败转换档和未知布局拒绝。无变化返回unchanged，不提交工程。旧编译布局经核验保留为过时缓存，实际修改标记重建，不自动同步ST引用或执行转换。新入口与旧三个固定owner的`file registered label`分开，不能混用ID参数。

## PRG REAL与单数组（build22候选）

仅固定谱系、CLI自建MAIN PRG的VAR可使用REAL标量；FB及固定三表仍限BOOL／INT。标量入口继续拒绝数组。以下独立登记入口只接受空表或恰好一个无注释INT[0..7]的纯数组表，不支持混合标量、多数组、其他元素类型、变长或多维：

```text
file registered pou array list --kind PRG --owner <名称> --owner-object-id <ID>
file registered pou array add --kind PRG --owner <名称> --owner-object-id <ID> --name <变量> --data-type INT --lower-bound 0 --upper-bound 7
file registered pou array rename --kind PRG --owner <名称> --owner-object-id <ID> --name <旧名> --new-name <新名> --expected-type INT --expected-lower-bound 0 --expected-upper-bound 7
file registered pou array delete --kind PRG --owner <名称> --owner-object-id <ID> --name <变量> --expected-type INT --expected-lower-bound 0 --expected-upper-bound 7
```

各命令使用本节共同workspace、project、控制器参数；写入须最新工程SHA和关闭声明，可选绑定登记SHA。list不接受写入或形状参数。已识别的目标自动分配在更名或删除时清除，由GX重建；不更新ST引用。删除PRG前先清空全部变量表。此限定范围已完成GX验收，实际证据以配套记录为准。

已观察登记ST正文写后PRG／标签／正文标志为0/1/1，严格MAIN守卫会拒绝后续自身或兄弟POU标签入口。先完成本轮全部标签操作，再同步正文并统一GX转换；若已出现该状态，先全部转换、保存关闭并核对结果后继续，不改守卫绕过。此观察不开放其他混合标志或未知形状。

## PRG数组变长与标量混表（build24候选）

新增独立 `file registered pou mixed list|add|rename|set-type|resize|delete`，仅限符合完整对象合同的CLI自建MAIN PRG VAR，类固定VAR，不传 `--class`。共用本页的workspace、project、gx-controller、`--kind PRG --owner <名称> --owner-object-id <ID>`，可选 `--expected-registration-sha256 <SHA>`；写操作还需最新工程SHA和 `--project-closed true`。list不接受写入、行或形状参数。

每次写入提供 `--row-kind scalar|array --name <名称>`。标量add需 `--data-type BOOL|INT|DINT|REAL`；标量其他操作需 `--expected-type BOOL|INT|DINT|REAL`，rename另需 `--new-name <新名>`，set-type另需 `--data-type BOOL|INT|DINT|REAL`。标量不支持resize。

数组add需 `--data-type INT --lower-bound 0 --upper-bound 0|2|3|4|7|15`；数组rename、resize、delete均需 `--expected-type INT --expected-lower-bound 0 --expected-upper-bound 0|2|3|4|7|15`，rename另需 `--new-name <新名>`，resize另需新的 `--lower-bound 0 --upper-bound 0|2|3|4|7|15`。上界选择其一，对应元素数1、3、4、5、8、16；这些长度间可变长。数组不支持set-type，rename和delete不接受新形状；不支持标量／数组互转或数组元素改型。同尺寸、同名或同类型的相应操作返回unchanged，不发布。

最多64个普通行、最多4个数组，可纯标量、纯数组或混表；不支持其他下界、元素类型、多维、初值或手动地址。build26 支持上节定义的标量及数组主注释与 mixed 共存。实际目标的已识别自动分配在变更时仅清除目标自身记录，等待GX重新分配；其他行及其分配保留。AI负责引用、索引、值域和ST同步。先完成全部声明操作，再同步正文；正文写后0/1/1状态使MAIN守卫拒绝标签操作时，先GX全部转换、保存关闭并核对结果。旧标量及build22纯数组入口的守卫保持不变。

本轮限定合同及GX验收已完成；配套CLI帮助和包内VALIDATION.json决定实际能力与验证状态；BOOL／INT／DINT／REAL接口支持的互转只有部分方向经过本轮GX验证，不将结果泛化到全部组合。文件写回或隔离检查不等于GX验证。

## 提交及恢复

本轮验证保留序列化编辑器引用守卫：若GX保存的WindowControl仍指向CLI自建对象，文件入口可能以 `FileDirectUnsupportedRegistry` 拒绝维护。不要改登记或删除引用绕过；在已明确授权的第二模式验证中正常关闭该技术编辑页，再由GX保存关闭，重新读当前文件和对象后继续。本次完整流程已自动完成，不需要用户代点；此说明不授予未获准的前台操作权限。ST镜像窗口恢复标志0／2已有原生证据并限定兼容，其他未知窗口／结构状态仍拒绝。

来源、元数据和目录链在调用期受到保护，暂存回读、备份、日志、末次目标SHA／身份核对后原子替换。最后检查到rename不是CAS，不支持并发目标写入。异常时先读实际结果，不假定所有错误都未提交。

```text
file project recovery-status
file project rebind --source-project <明确来源> --expected-source-sha256 <SHA> --expected-project-sha256 <SHA> --expected-registration-sha256 <旧登记SHA> --project-closed true --gx-controller <DLL>
file project load-snapshot --snapshot-file <明确现有快照> --expected-snapshot-sha256 <SHA> --expected-project-sha256 <SHA> --project-closed true --gx-controller <DLL> [--expected-registration-sha256 <SHA>] [--allow-lineage-change true]
```

recovery-status只读未完成日志及实际状态，不自动回滚。未知／prepared状态拒绝继续，不删日志、改记录或盲重放来绕过。aborted_before_publish是已明确在发布前中止，可重新读取后评估下一步。

rebind只在用户明确重新选择来源／基线时使用，严格绑定旧登记SHA并保留历史，不是普通SHA漂移的自动修复。load-snapshot会替换**整个副本**；仅用于用户明确授权的快照恢复或专项验收，不能在正常编辑中为了通过门禁把目标换成示例工程。跨原生根须显式allow-lineage-change，再显式rebind；profile通过不证明整工程或编译正确。

GX加载、转换、保存关闭仍是另行授权的前台验收。CLI内editor validation-step仍只支持固定首份路径，不能对另一登记副本绕过其保护；`activate-proof-st` 和 `show-output` 仅用于前台验证，不用于正常编辑。Computer Use读取／截图／切页仍报 `0x80070486`，未修复；验收辅助或人工操作不证明它已修复，正常文件编辑不用Computer Use补齐。
