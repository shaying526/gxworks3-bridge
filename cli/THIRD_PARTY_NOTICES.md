# Third-party notices

This CLI reuses Structured Text clipboard read/write techniques and portions of
the controller implementation from **coder007rahul/gxworks3-mcp-bridge**, fixed
commit `d10998d40dddfff86059067e42128dd65487efd1`:
https://github.com/coder007rahul/gxworks3-mcp-bridge

The upstream MIT copyright and permission notice is preserved in `LICENSE`.
New command-line, identity, plan storage and creation behavior must be assessed
from this project's source and evidence; upstream claims are not validation of
this derivative.

Direct package references:

| Package | Version | License/source |
| --- | --- | --- |
| FlaUI.Core | 5.0.0 | MIT; https://github.com/FlaUI/FlaUI |
| FlaUI.UIA3 | 5.0.0 | MIT; https://github.com/FlaUI/FlaUI |

The resolved transitive package set is recorded by NuGet in
`obj/project.assets.json`. The publish script copies package-provided license
and notice files, plus package metadata, into `licenses/` and records that list
in the accompanying package manifest. This includes
`Interop.UIAutomationClient` (MIT; https://github.com/Roemer/UIAutomation-Interop)
and the resolved `System.Management` dependency.

Self-contained distributions also contain Microsoft's .NET runtime components.
Retain the runtime-provided license and third-party notice files in the publish
directory. Runtime patch versions and included frameworks are recorded in
`gx3.runtimeconfig.json` and the package manifest; they are separate from the
CLI source license and require maintenance when runtime patches are released.

This product is not affiliated with or endorsed by Mitsubishi Electric.
