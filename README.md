# GX Works3 Bridge Agent Skill

[English](#english) · [简体中文](#简体中文)

## English

[Install](#install-in-one-sentence) · [First use](#first-use) · [Editing modes](#editing-modes) · [Compatibility and troubleshooting](#compatibility-and-troubleshooting) · [License](#license)

Use a local AI agent to read and edit supported Mitsubishi GX Works3 PLC project objects. The Windows x64 bundle includes a portable CLI, its .NET runtime, and the `gxworks3-edit` Agent Skill.

### Install in one sentence

Copy this prompt into your local AI agent.

> Download and extract [https://github.com/shaying526/gxworks3-bridge](https://github.com/shaying526/gxworks3-bridge), put the entire `cli/` folder in my local tools directory, install `skill/gxworks3-edit/` in this project's Skill directory (`.agents/skills/gxworks3-edit/` for Codex), and run `help --json` using the absolute path to `gx3.exe`.

### First use

Choose **Code → Download ZIP**, extract the bundle, and run these commands in PowerShell from the extracted directory.

```powershell
.\Verify-Package.ps1
.\cli\gx3.exe help --json
```

The first command checks the bundle against its SHA-256 manifest. The second lists the available commands and the CLI build. You can run both before opening a project or installing GX Works3.

Open your AI session in the project with the Skill installed. Give it the CLI path, workspace, and exact path to a saved, closed, registered project copy. For example:

```text
$gxworks3-edit Use the absolute path I provided for gx3.exe.
Use file mode to list the ST programs and function blocks in
D:\PLC\Workspace\projects\file-direct\Trial.gx3. Read only.
```

To create and register your first copy from PowerShell, follow the [copy and read example](#powershell). [Skill instructions](skill/gxworks3-edit/SKILL.md) · [Registered commands](skill/gxworks3-edit/references/registered.md)

### Editing modes

| | Direct File Mode | Editor Mode |
| --- | --- | --- |
| What it works on | A saved, closed project copy on disk | A project copy open in GX Works3 |
| When to use it | Background reads and edits to supported objects | Foreground reads, edits, or verification when explicitly selected |
| How to check the result | Read back with the CLI, then reopen, convert, and save in GX Works3 as needed | Read back in GX Works3 and save or convert as authorized |

Supported operations cover ST source, selected FBs and PRGs, local and global labels, structure members, and comments. Some writes require a specific project lineage, object ID, or declaration layout. Supported PRG declarations include selected BOOL, INT, DINT, and REAL scalars and one-dimensional INT arrays. Check references and update dependent ST before renaming, deleting, or changing a type. [File mode](skill/gxworks3-edit/references/file-direct.md) · [Editor commands](skill/gxworks3-edit/references/commands.md) · [FB operations](skill/gxworks3-edit/references/fb.md)

### Compatibility and troubleshooting

- The bundle was tested on Windows 10 x64 with GX Works3 1.128J on selected projects. Keep the full `cli/` folder. File mode uses the native controller DLL from your local GX Works3 installation. Device download, start or stop, forced I/O, and simulation are outside the bundle's scope. [Validation record](VALIDATION.json) · [Windows 11 trial checklist](WINDOWS11-TEST.md)
- If the project file is in use, save and close the copy in GX Works3 and get its current SHA-256. If the CLI rejects the layout or object, retain the error and the project file for review.
- Keep the backups, logs, and fingerprints from each write. After a timeout, partial result, or unfamiliar dialog, read the current project state before retrying. Snapshot recovery replaces the entire copy and requires explicit authorization. [Recovery instructions](skill/gxworks3-edit/references/file-direct.md)
- `compilation=not_run` means the CLI did not perform conversion. Check GX Works3's actual errors and warnings, then verify the saved copy after reopening.

### License

MIT. Runtime and dependency notices ship with the CLI. [License](LICENSE) · [Third-party notices](cli/THIRD_PARTY_NOTICES.md)

[简体中文](#简体中文) · [Back to top](#gx-works3-bridge-agent-skill)

## 简体中文

[一句话安装](#一句话安装) · [第一次使用](#第一次使用) · [两种编辑模式](#两种编辑模式) · [兼容性与排错](#兼容性与排错) · [许可证](#许可证)

让本地 AI 读取和编辑三菱 GX Works3 工程中已支持的 PLC 对象。Windows x64 便携包包含 CLI、配套 .NET 运行时和 `gxworks3-edit` Agent Skill。

### 一句话安装

把这句话复制给你的本地 AI。

> 请从 [https://github.com/shaying526/gxworks3-bridge](https://github.com/shaying526/gxworks3-bridge) 下载并完整解压，将 `cli/` 整目录放到本机工具目录，将 `skill/gxworks3-edit/` 整目录安装到项目的 Skill 目录（Codex 为 `.agents/skills/gxworks3-edit/`），然后用 `gx3.exe` 的绝对路径运行 `help --json` 验证安装。

### 第一次使用

在 GitHub 选择 **Code → Download ZIP**，完整解压后，在解压目录中打开 PowerShell 并执行。

```powershell
.\Verify-Package.ps1
.\cli\gx3.exe help --json
```

第一条按 SHA-256 清单校验文件，第二条显示可用命令和 CLI 构建标识。两条命令都可以在尚未安装 GX Works3 或打开工程时执行。

在已安装 Skill 的项目里开启 AI 会话，提供 CLI 路径、工作区和准确的工程副本路径。工程副本应已保存、关闭并完成登记。例如：

```text
$gxworks3-edit 使用我提供的 gx3.exe 绝对路径，走文件模式列出
D:\PLC\Workspace\projects\file-direct\Trial.gx3 中的 ST 程序和功能块。
这次只读取。
```

第一次创建和登记副本，可直接执行下方的 [PowerShell 示例](#powershell)。[Skill 入口](skill/gxworks3-edit/SKILL.md) · [登记命令](skill/gxworks3-edit/references/registered.md)

### 两种编辑模式

| | 文件直改模式 | 编辑器模式 |
| --- | --- | --- |
| 操作对象 | 磁盘上已保存、已关闭的工程副本 | GX Works3 中当前打开的工程副本 |
| 使用场景 | 在后台读取或修改已支持的对象 | 显式选择前台读取、编辑或验证 |
| 如何验证 | CLI 回读后，在 GX Works3 中重开，按需转换并保存 | 在 GX Works3 中回读，按授权保存或转换 |

支持 ST 正文、限定的 FB 和 PRG、局部与全局标签、结构体成员和注释维护。部分写入要求特定的工程谱系、对象 ID 或声明布局。PRG 声明支持限定的 BOOL、INT、DINT、REAL 标量和一维 INT 数组。更名、删除或改型前，先核对引用并同步相关 ST 正文。[文件模式](skill/gxworks3-edit/references/file-direct.md) · [编辑器命令](skill/gxworks3-edit/references/commands.md) · [FB 操作](skill/gxworks3-edit/references/fb.md)

### 兼容性与排错

- 已在 Windows 10 x64 和 GX Works3 1.128J 的限定样本上验证。使用时保留完整的 `cli/` 目录。文件模式使用本机 GX Works3 安装提供的原生控制器 DLL。设备下载、启停、强制 I/O 和仿真在工具范围之外。[验收记录](VALIDATION.json) · [Windows 11 试用验收](WINDOWS11-TEST.md)
- 工程文件被占用时，先在 GX Works3 中保存并关闭副本，再取最新 SHA-256。若命令拒绝布局或对象，保留原始报错和工程文件。
- 写入后保留 CLI 备份、日志和返回指纹。遇到超时、部分结果或陌生弹窗，先读取实际状态再决定是否重试。快照恢复会替换整个副本，须有明确授权。[恢复说明](skill/gxworks3-edit/references/file-direct.md)
- `compilation=not_run` 表示 CLI 本次未做转换。以 GX Works3 的错误和警告及保存重开的回读结果为准。

### 许可证

项目使用 MIT 许可证，运行时和依赖的许可声明随 CLI 分发。[许可证](LICENSE) · [第三方声明](cli/THIRD_PARTY_NOTICES.md)

[English](#english) · [返回顶部](#gx-works3-bridge-agent-skill)

## PowerShell

This example copies a saved, closed snapshot to a new destination, registers the copy, and lists its ST objects. Enter absolute paths. Use an existing writable workspace and a destination that does not already exist.

此示例复制已保存关闭的源工程快照，登记独立副本，再列出 ST 对象。请输入绝对路径，工作区须已存在且可写，目标副本路径须尚未占用。

```powershell
$gx3 = (Resolve-Path '.\cli\gx3.exe').Path
$work = Read-Host 'Workspace absolute path / 工作区绝对路径'
$source = Read-Host 'Closed source snapshot / 已关闭的源工程快照'
$controller = Read-Host 'Native GX controller DLL absolute path / 本机原生控制器 DLL 绝对路径'
$copy = Join-Path $work 'projects\file-direct\Trial.gx3'
$sha = (Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash.ToLowerInvariant()

& $gx3 daily project copy --workspace $work --source $source --out $copy --json
if ($LASTEXITCODE -ne 0) { throw 'Copy failed. Check the returned JSON. / 复制失败，请检查返回的 JSON。' }

$common = @('--workspace', $work, '--project', $copy, '--gx-controller', $controller, '--json')
& $gx3 file project register @common --source-project $source `
    --expected-project-sha256 $sha --expected-source-sha256 $sha --project-closed true
if ($LASTEXITCODE -ne 0) { throw 'Registration failed. Check the returned JSON. / 登记失败，请检查返回的 JSON。' }

& $gx3 file registered st list @common
```

The controller DLL is `Melco.GXW3.Controller.Project.Native.ProjectController.Impl.dll`. Keep the source snapshot and the copy's operation records. Use the returned object type, name, ID, and current project fingerprint for subsequent operations.

控制器 DLL 文件名为 `Melco.GXW3.Controller.Project.Native.ProjectController.Impl.dll`。保留登记用的源快照及副本操作记录。后续操作使用返回的对象类型、名称、ID 和当前工程指纹。

[English](#english) · [简体中文](#简体中文) · [返回顶部 / Back to top](#gx-works3-bridge-agent-skill)
