# GX Works3 Bridge

GX Works3 Bridge 为三菱 GX Works3 提供 Windows x64 便携 CLI 和 Agent Skill，面向希望用本地 AI 辅助维护 PLC 工程的开发者。日常编辑可在后台对已保存、已关闭的独立工程副本操作，支持已验证范围内的 ST、FB、PRG、标签、结构体和注释维护。

## 快速开始

在 GitHub 上选择 **Code → Download ZIP**，完整解压后，从包含 `README.md` 的目录运行 PowerShell 命令。

```powershell
.\Verify-Package.ps1
.\cli\gx3.exe help --json
```

第一条核对分发文件的 SHA-256，第二条列出命令和 CLI 构建标识。首次启动可以在没有工程和 GX Works3 的环境中验证。包内已附 .NET 10 运行时，使用时保留整个 `cli/` 目录。工程操作需要本机 GX Works3，文件直改使用本机安装提供的原生控制器 DLL。[包内验收记录](VALIDATION.json)

使用 AI 时，将完整的 `skill/gxworks3-edit/` 放到本地 AI 客户端的 Skill 目录。例如 Codex 项目可使用 `.agents/skills/gxworks3-edit/`。调用 `$gxworks3-edit` 时提供 `gx3.exe` 的绝对路径、工作区、目标工程和要操作的对象。[Skill 入口](skill/gxworks3-edit/SKILL.md)

## 第一次读取工程

在 GX Works3 中保存并关闭工程，准备已存在的可写工作区，以及一份稳定的源工程快照。下面的示例创建独立副本，登记两份文件的身份，再列出可识别的 ST 对象。执行时输入自己的绝对路径，确保目标工作区内还没有 `projects/file-direct/Trial.gx3`。

```powershell
$gx3 = (Resolve-Path '.\cli\gx3.exe').Path
$work = Read-Host '已存在的工作区绝对路径'
$source = Read-Host '已关闭的源工程快照绝对路径'
$controller = Read-Host '本机 Melco.GXW3.Controller.Project.Native.ProjectController.Impl.dll 的绝对路径'
$copy = Join-Path $work 'projects\file-direct\Trial.gx3'
$sha = (Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash.ToLowerInvariant()

& $gx3 daily project copy --workspace $work --source $source --out $copy --json
if ($LASTEXITCODE -ne 0) { throw '复制失败，请检查返回的 JSON。' }

$common = @('--workspace', $work, '--project', $copy, '--gx-controller', $controller, '--json')
& $gx3 file project register @common --source-project $source `
    --expected-project-sha256 $sha --expected-source-sha256 $sha --project-closed true
if ($LASTEXITCODE -ne 0) { throw '登记失败，请检查返回的 JSON。' }

& $gx3 file registered st list @common
```

清单返回识别到的对象和身份。继续读写时，使用准确的对象类型、名称、ID 和最新工程指纹。写入能力按原生布局和具体操作校验。保留登记使用的源快照及副本的操作记录。[登记命令和参数](skill/gxworks3-edit/references/registered.md)

## 两种操作模式

| | 文件直改 | 编辑器模式 |
| --- | --- | --- |
| 操作位置 | 已关闭独立副本的磁盘文件 | GX Works3 中当前打开的副本 |
| 使用场景 | 后台读取或维护已支持的对象 | 显式选择前台读取、编辑或验证 |
| 结果验证 | CLI 回读后，在 GX 重开副本，按需转换并保存 | 核对原生回读，再按授权保存并转换 |

文件模式对既有 ST 对象、简单 FB／PRG、局部与全局标签、结构体成员及注释提供分级支持。部分写入只适用于具体工程谱系、对象 ID 或变量布局。已支持的 PRG 变量包括限定的 BOOL／INT／DINT／REAL 标量和一维 INT 数组。修改类型、更名或删除前，调用端负责检查引用并同步必要的 ST 正文。GX 转换、保存与重开用于确认工程结果。[文件直改](skill/gxworks3-edit/references/file-direct.md) · [登记命令](skill/gxworks3-edit/references/registered.md) · [前台命令与示例](skill/gxworks3-edit/references/commands.md) · [FB 操作](skill/gxworks3-edit/references/fb.md)

## 兼容性与排错

- 本包在 Windows 10 x64 和 GX Works3 1.128J 的限定样本上验证。Windows 11 有独立的试用验收步骤。未识别的 GX 版本、CPU、数据布局、手动分配和复合引用按具体命令判定。设备下载、启停、强制 I/O 和仿真在能力范围之外。[验收结果](VALIDATION.json) · [Windows 11 试用验收](WINDOWS11-TEST.md)
- 工程文件被占用时，先在 GX 保存并关闭副本，再取最新 SHA-256。登记状态和写入资格由各命令分别判断。若命令拒绝未知布局，保留原错误和工程文件。
- 写入后保留 CLI 备份、日志和返回指纹。遇到超时、部分结果或未知弹窗，先核对目标与保存状态。用原始返回值和最新文件指纹判断后续操作，避免重放结果不明的输入。快照恢复会替换整个副本，适用于明确授权的恢复流程。[恢复与文件操作](skill/gxworks3-edit/references/file-direct.md)
- `compilation=not_run` 表示 CLI 本次未转换，`rebuildRequired` 也可能包含工程原有待转换状态。用 GX 的实际错误、警告与保存重开结果验证。

## 许可证

项目使用 MIT 许可证。运行时和第三方依赖的许可及声明随 CLI 分发。[MIT 许可证](LICENSE) · [第三方声明](cli/THIRD_PARTY_NOTICES.md)
