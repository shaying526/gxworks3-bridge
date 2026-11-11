# 单ST FB、声明和类型引用

本页仅用于明确选择的编辑器操作模式。文件直改的BOOL／INT JSON定义见[file-direct.md](file-direct.md)，两种输入格式不混用。

此参考说明候选包的实际接口和输入边界，不预填原生通过结果。先核对同包`VALIDATION.json`、当前CPU及本次对象；旧r1没有这些新增入口，不能将新Skill配旧CLI使用。

## 选择对象与操作

新建 FB 的原生确认框显示类别“FB, FB文件, 函数, FUN文件”；这不是具体对象身份。CLI 同时核对单 FB 候选、新独立文件及不存在同名对象的前置条件，并将默认“替换”纠正为“添加”后完整核对。不要手工改变模式或代点确认。若返回 partial，先只读现有 FB，不重放 create；完整定义覆盖仍不开放。

- 新建真实ST FB：`daily fb create --name <FB名> --definition <完整IEC.xml>`，可用`--fb-file <实际新FB文件名>`断言绑定。输入只包含一个明确FB及其自身新文件登记，不包含其他FB、PRG、结构定义或项目实例；先确认依赖类型，AI决定创建顺序。
- 完整读取：`daily fb read --name <FB名> [--fb-file <实际文件>]`。当前适配可用目标原生声明导出，加独立ST全文组合定义；检查结果的`bodySource`及`files`。不要把仅含声明的`labels.xml`当成包含正文的完整FB导出或完整工程备份。
- 正文修改：`daily st read|write --name <FB名> --kind FB`，write另传UTF-8完整`--code-file`；不自动修改声明或其他引用。
- 声明读/增/改/删：`daily label list|add|update|delete --scope local --owner <FB名> --owner-kind FB`，add/update传基于实际表头的字符串值JSON。先list核对完整实际字段，修改后完整CSV回读；未指定行/列保持。接口参数使用GX实际分类值，不把源厂商IN/OUT/INOUT直接当中文表头。

`--fb-file`只适用于`fb`定义命令，`--owner-kind`只适用于标签命令。整FB替换`daily fb update`当前写前拒绝`DailyFbReplaceNotVerified`；FB删除未开放。不能通过重建、另一路全文件导入或放宽保护覆盖隐含其他FB。

## r3 原生读取兼容范围

r4 沿用本节的解析范围，并通过原生 MDI 活动子窗核对声明和 ST 编辑器。先确认 CLI 与 GX 同在接收输入的交互桌面，保持 GX 主窗最大化。正文控件仅在目标 ST 子窗激活后定位。出现未确认的激活或前台错误时，先保留本次结果，再核对窗口和桌面。

r3识别本机GX 1.128J/FX5U的UTF-16 TC6_0201声明导出：根级`projectProperties`仅允许已观察的`title`属性和空内容，连同`projectPlcType`、`projectFolders`、`projectLabelArea`保留；`title`只作显示元数据，不作为工程或FB身份依据。`projectFolders`可识别明确的`macro`或`subroutine`文件种类。实际原始XML字节保留在操作目录，JSON中的`metadata[].xml`是节点序列化文本，不是原始文件字节备份。未知属性、payload、作用域、重复外围单例及隐藏定义仍拒绝，不要删字段绕过。

无TextPattern的daily ST读取会将单次复制结果与复制前后稳定的原生编辑器全文属性逐字比较（仅规范化BOM及换行）；`FullTextCoverageUnverified`表示全文来源不一致，工具不接受该次复制。保留结果并检查焦点/界面状态，不自动重放；退出0也应核对返回正文与本次已知内容，不能单凭菜单复制成功声称完整。此检查不证明所有GX版本或运行环境均已兼容。修复包的实际原生证据、失败记录及未验范围见`VALIDATION.json`。

## 可编辑的完整创建示例

下面是独立技术FB，四类声明均有，正文只是显式数值/BOOL赋值。形状来自原生Probe采用的单FB文件登记、接口、内部声明与ST主体；名称已改成可替换的示例。根的`schemaVersion="1.000"`是当前原生输入profile的必要字段，不要删掉。示例没有标签初值或接口数字排序，不代表已在用户目标工程通过。创建前同时替换命令中的FB名、XML中`FunctionBlock name`、新文件名及两处文件登记；文件必须是新独立FB文件。

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project xmlns="www.iec.ch/public/TC65SC65BWG7TF10"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         schemaVersion="1.000">
  <FileHeader companyName="GxWorks3Bridge" companyURL=""
              productName="FB declaration example" productVersion="candidate"/>
  <ContentHeader name="IndependentCopy" creationDateTime="2026-11-03T12:00:00+08:00"/>
  <Types><GlobalNamespace>
    <AddData>
      <Data name="http://www.mitsubishielectric.com/xml/FbFiles" handleUnknown="implementation">
        <FbFiles><FbFile name="NewProofFbFile" functionBlockType="macro"/></FbFiles>
      </Data>
    </AddData>
    <FunctionBlock name="NewProofFb">
      <AddData>
        <Data name="http://www.mitsubishielectric.com/xml/FbPouProperties" handleUnknown="implementation">
          <FbPouProperties isEnEno="false" isMcMcr="false"/>
        </Data>
        <Data name="http://www.mitsubishielectric.com/xml/FbPouFile" handleUnknown="implementation">
          <FbPouFile name="NewProofFbFile"/>
        </Data>
      </AddData>
      <Parameters>
        <InputVars>
          <Variable name="SignalIn"><Type><TypeName>BOOL</TypeName></Type></Variable>
        </InputVars>
        <OutputVars retain="false">
          <Variable name="SignalOut"><Type><TypeName>BOOL</TypeName></Type></Variable>
        </OutputVars>
        <InoutVars>
          <Variable name="InOutValue"><Type><TypeName>DINT</TypeName></Type></Variable>
        </InoutVars>
      </Parameters>
      <Vars constant="false" retain="false" accessSpecifier="private">
        <Variable name="SeqValue"><Type><TypeName>DINT</TypeName></Type></Variable>
      </Vars>
      <MainBody><BodyContent xsi:type="ST"><ST>SeqValue := SeqValue + 1;
SignalOut := SignalIn;
InOutValue := SeqValue;
</ST></BodyContent></MainBody>
    </FunctionBlock>
  </GlobalNamespace></Types>
  <Instances/>
</Project>
```

保存为UTF-8完整XML，再按[命令参考](commands.md)中的共同参数调用create/read。`macro`和关闭EN/ENO是此示例的明确属性，不能据此认定其他FB属性/文件种类均已验证。不要复制未理解的预留区数值、厂商内部编号或多个POU到输入中。

## 原候选与原生接口序号

用户完整定义保留`Parameters`中的接口文档顺序，不填写数字`orderWithinParamSet`。当前GX原生输入需要这个字段，因此`DailyFbNativeInput.Prepare`只在另存的原生副本中，按`Parameters`各组及变量的文档顺序给接口变量生成连续1起序号，内部`Vars`不生成。上例的三个接口变量会按SignalIn、SignalOut、InOutValue生成原生格式映射；原候选不因此被覆盖。

这是派生原生输入格式的明确例外：操作目录同时保留原始candidate、派生native字节和各自哈希，`native-transport.json`记录映射。它不是来自旧工程或其他厂商的对象编号。显式数字请求仍返回`DailyFbParameterOrderNotVerified`；不要手动添加数字来绕过。没有独立数字回读证据时，不能用变量行号、生成映射或编译结果证明原引脚身份/跨类别位置调用ABI一致。同类声明顺序、完整ST、名称/类型及显式容量仍严格回读；若业务必须保留特定数字引脚身份，记录当前未支持。

## 结构INOUT与内部FB实例

结构参数在`InoutVars/Variable/Type/TypeName`中填写实际结构类型；例如用户明确需要时将示例DINT改为已建立的结构类型，正文也由AI明确配套。内部嵌套FB在`Vars`中以实际FB类型名声明独立实例，再由完整ST调用。PRG中的结构变量和FB实例仍用普通PRG局部标签入口，不另建隐藏实例管理器。

按实际依赖顺序创建结构、被调用FB、上层FB及测试PRG。CLI只准确编辑明确对象，不自动补依赖、扫描全工程或修正引用。读回要逐项核对声明分类、名字、同类顺序、类型及显式类型细节，再由GX全部转换检查语法/类型/引用。

## 初值、字符串容量与验证边界

FX5 CPU不支持标签初值。当前FB完整定义或FB标签写入若请求显式非空初值（`0`和`FALSE`也属于非空），CLI先通过当前工程原生声明资料只读核对CPU：FX5返回`DailyInitialValueUnsupportedForCpu`；CPU身份或其他CPU能力未验证返回`DailyInitialValueCapabilityUnverified`，不提交该初值。不要删除用户已明确请求的值后声称完成，也不要擅自改成每扫赋值、上电初始化或其他业务逻辑。若业务确需初始化，交由业务侧确认方案；本示例主动不请求初值。

结构或FB简单类型中的明确`STRING[N]`/`WSTRING[N]`容量必须参与实际回读比较。IEC和TC6可能采用不同语法，原生标签编辑器显示又可能不同；以真实输入/导出及`stringLength`为依据，不从类型名或默认值猜容量。本机FX5U独立副本已验证19成员结构和40容量的原生写入、即时及保存重开回读；全部转换结果见包内VALIDATION，不推广到其他CPU、WSTRING或运行时内容。

写后先完整回读，再统一保存→正常关闭工程→重开同一副本→完整目标回读→全部转换→再保存，来源分别记录。未知弹窗、partial或差异即停止。计时类型/六实例技术用例只验证创建、声明和引用；编译不证明原业务时间单位、状态独立性或计时算法等价，迁移兼容正文须由业务侧确认。
