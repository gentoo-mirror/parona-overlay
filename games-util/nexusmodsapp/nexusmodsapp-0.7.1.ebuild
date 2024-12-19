# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOTNET_PKG_COMPAT=9.0
NUGETS="
argon@0.24.2
autofixture.xunit2@4.18.1
autofixture@4.18.1
avalonia.angle.windows.natives@2.1.22045.20230930
avalonia.avaloniaedit@11.1.0
avalonia.buildservices@0.0.28
avalonia.buildservices@0.0.29
avalonia.controls.colorpicker@11.2.2
avalonia.controls.datagrid@11.2.2
avalonia.controls.treedatagrid@11.1.0
avalonia.desktop@11.2.2
avalonia.diagnostics@11.2.2
avalonia.freedesktop@11.2.2
avalonia.headless@11.2.2
avalonia.labs.panels@11.2.0
avalonia.native@11.2.2
avalonia.reactiveui@11.2.2
avalonia.remote.protocol@11.0.0
avalonia.remote.protocol@11.2.2
avalonia.skia@11.0.0
avalonia.skia@11.2.0
avalonia.skia@11.2.2
avalonia.svg.skia@11.2.0.2
avalonia.themes.fluent@11.2.2
avalonia.themes.simple@11.2.2
avalonia.win32@11.2.2
avalonia.x11@11.2.2
avalonia@11.0.0
avalonia@11.1.3
avalonia@11.2.0
avalonia@11.2.2
avaloniaedit.textmate@11.1.0
bannerlord.launchermanager.localization@1.0.138
bannerlord.launchermanager.models@1.0.138
bannerlord.launchermanager@1.0.138
bannerlord.modulemanager.models@5.0.221
bannerlord.modulemanager.models@6.0.242
bannerlord.modulemanager@5.0.225
bannerlord.modulemanager@6.0.242
benchmarkdotnet.annotations@0.14.0
benchmarkdotnet@0.14.0
bitfaster.caching@2.5.2
bsdiff@1.1.0
castle.core@5.1.1
cliwrap@3.6.7
colordocument.avalonia@11.0.3-a1
colortextblock.avalonia@11.0.3-a1
commandlineparser@2.9.1
coverlet.collector@6.0.2
diffengine@15.5.3
diffplex@1.7.2
dynamicdata@8.3.27
dynamicdata@8.4.1
dynamicdata@9.0.1
dynamicdata@9.0.4
emptyfiles@8.5.0
excss@4.2.3
fare@2.1.1
fetchbannerlordversion.models@1.0.6.46
fetchbannerlordversion@1.0.6.46
fluentassertions.analyzers@0.34.1
fluentassertions.oneof@0.0.5
fluentassertions@5.0.0
fluentassertions@6.12.2
fluentresults@3.15.2
fody@6.8.0
fomodinstaller.interface@1.0.0
fomodinstaller.interface@1.2.0
fomodinstaller.scripting.xmlscript@1.0.0
fomodinstaller.scripting@1.0.0
fomodinstaller.utils@1.0.0
gamefinder.common@4.3.3
gamefinder.launcher.heroic@4.3.3
gamefinder.registryutils@4.3.3
gamefinder.storehandlers.eadesktop@4.3.3
gamefinder.storehandlers.egs@4.3.3
gamefinder.storehandlers.gog@4.3.3
gamefinder.storehandlers.origin@4.3.3
gamefinder.storehandlers.steam@4.3.3
gamefinder.storehandlers.xbox@4.3.3
gamefinder.wine@4.3.3
gamefinder@4.3.3
gee.external.capstone@2.3.0
githubactionstestlogger@2.4.1
google.protobuf@3.22.5
grpc.core.api@2.52.0
grpc.net.client@2.52.0
grpc.net.common@2.52.0
harfbuzzsharp.nativeassets.linux@7.3.0.2
harfbuzzsharp.nativeassets.linux@7.3.0.3
harfbuzzsharp.nativeassets.macos@7.3.0.2
harfbuzzsharp.nativeassets.macos@7.3.0.3
harfbuzzsharp.nativeassets.webassembly@7.3.0.3
harfbuzzsharp.nativeassets.webassembly@7.3.0.3-preview.2.2
harfbuzzsharp.nativeassets.win32@7.3.0.2
harfbuzzsharp.nativeassets.win32@7.3.0.3
harfbuzzsharp@7.3.0.2
harfbuzzsharp@7.3.0.3
hotchocolate.language.syntaxtree@14.3.0
hotchocolate.transport.abstractions@14.3.0
hotchocolate.transport.http@14.3.0
hotchocolate.utilities@14.3.0
htmlagilitypack@1.11.70
humanizer.core.af@2.14.1
humanizer.core.ar@2.14.1
humanizer.core.az@2.14.1
humanizer.core.bg@2.14.1
humanizer.core.bn-bd@2.14.1
humanizer.core.cs@2.14.1
humanizer.core.da@2.14.1
humanizer.core.de@2.14.1
humanizer.core.el@2.14.1
humanizer.core.es@2.14.1
humanizer.core.fa@2.14.1
humanizer.core.fi-fi@2.14.1
humanizer.core.fr-be@2.14.1
humanizer.core.fr@2.14.1
humanizer.core.he@2.14.1
humanizer.core.hr@2.14.1
humanizer.core.hu@2.14.1
humanizer.core.hy@2.14.1
humanizer.core.id@2.14.1
humanizer.core.is@2.14.1
humanizer.core.it@2.14.1
humanizer.core.ja@2.14.1
humanizer.core.ko-kr@2.14.1
humanizer.core.ku@2.14.1
humanizer.core.lv@2.14.1
humanizer.core.ms-my@2.14.1
humanizer.core.mt@2.14.1
humanizer.core.nb-no@2.14.1
humanizer.core.nb@2.14.1
humanizer.core.nl@2.14.1
humanizer.core.pl@2.14.1
humanizer.core.pt@2.14.1
humanizer.core.ro@2.14.1
humanizer.core.ru@2.14.1
humanizer.core.sk@2.14.1
humanizer.core.sl@2.14.1
humanizer.core.sr-latn@2.14.1
humanizer.core.sr@2.14.1
humanizer.core.sv@2.14.1
humanizer.core.th-th@2.14.1
humanizer.core.tr@2.14.1
humanizer.core.uk@2.14.1
humanizer.core.uz-cyrl-uz@2.14.1
humanizer.core.uz-latn-uz@2.14.1
humanizer.core.vi@2.14.1
humanizer.core.zh-cn@2.14.1
humanizer.core.zh-hans@2.14.1
humanizer.core.zh-hant@2.14.1
humanizer.core@2.14.1
humanizer.core@2.2.0
humanizer@2.14.1
iced@1.17.0
ini-parser-netstandard@2.5.2
jetbrains.annotations@2024.3.0
k4os.compression.lz4@1.3.7-beta
k4os.compression.lz4@1.3.8
linqgen@0.3.1
livechartscore.skiasharpview.avalonia@2.0.0-rc2
livechartscore.skiasharpview@2.0.0-rc2
livechartscore@2.0.0-rc2
magick.net-q16-anycpu@14.0.0
magick.net.core@14.0.0
markdown.avalonia.tight@11.0.3-a1
martincostello.logging.xunit@0.3.0
memorypack.core@1.21.3
memorypack.generator@1.21.3
memorypack.streaming@1.21.3
memorypack@1.21.3
microcom.runtime@0.11.0
microsoft.aspnet.webapi.client@6.0.0
microsoft.aspnetcore.webutilities@9.0.0
microsoft.bcl.asyncinterfaces@1.1.0
microsoft.bcl.asyncinterfaces@1.1.1
microsoft.bcl.asyncinterfaces@6.0.0
microsoft.bcl.asyncinterfaces@7.0.0
microsoft.build.tasks.git@8.0.0
microsoft.codeanalysis.analyzer.testing@1.1.2
microsoft.codeanalysis.analyzers@3.3.3
microsoft.codeanalysis.analyzers@3.3.4
microsoft.codeanalysis.common@1.0.1
microsoft.codeanalysis.common@3.8.0
microsoft.codeanalysis.common@4.1.0
microsoft.codeanalysis.common@4.11.0
microsoft.codeanalysis.common@4.8.0
microsoft.codeanalysis.csharp.sourcegenerators.testing.xunit@1.1.2
microsoft.codeanalysis.csharp.sourcegenerators.testing@1.1.2
microsoft.codeanalysis.csharp.workspaces@3.8.0
microsoft.codeanalysis.csharp.workspaces@4.8.0
microsoft.codeanalysis.csharp@3.8.0
microsoft.codeanalysis.csharp@4.1.0
microsoft.codeanalysis.csharp@4.11.0
microsoft.codeanalysis.csharp@4.8.0
microsoft.codeanalysis.sourcegenerators.testing@1.1.2
microsoft.codeanalysis.testing.verifiers.xunit@1.1.2
microsoft.codeanalysis.workspaces.common@1.0.1
microsoft.codeanalysis.workspaces.common@3.8.0
microsoft.codeanalysis.workspaces.common@4.8.0
microsoft.codecoverage@17.11.1
microsoft.composition@1.0.27
microsoft.csharp@4.7.0
microsoft.diagnostics.netcore.client@0.2.251802
microsoft.diagnostics.runtime@2.2.332302
microsoft.diagnostics.tracing.traceevent@3.1.8
microsoft.dotnet.platformabstractions@3.1.6
microsoft.extensions.ambientmetadata.application@9.0.0
microsoft.extensions.compliance.abstractions@9.0.0
microsoft.extensions.configuration.abstractions@8.0.0
microsoft.extensions.configuration.abstractions@9.0.0
microsoft.extensions.configuration.binder@8.0.0
microsoft.extensions.configuration.binder@9.0.0
microsoft.extensions.configuration.commandline@8.0.0
microsoft.extensions.configuration.commandline@9.0.0
microsoft.extensions.configuration.environmentvariables@8.0.0
microsoft.extensions.configuration.environmentvariables@9.0.0
microsoft.extensions.configuration.fileextensions@8.0.0
microsoft.extensions.configuration.fileextensions@9.0.0
microsoft.extensions.configuration.json@8.0.0
microsoft.extensions.configuration.json@9.0.0
microsoft.extensions.configuration.usersecrets@8.0.0
microsoft.extensions.configuration.usersecrets@9.0.0
microsoft.extensions.configuration@8.0.0
microsoft.extensions.configuration@9.0.0
microsoft.extensions.dependencyinjection.abstractions@2.0.0
microsoft.extensions.dependencyinjection.abstractions@8.0.0
microsoft.extensions.dependencyinjection.abstractions@8.0.1
microsoft.extensions.dependencyinjection.abstractions@8.0.2
microsoft.extensions.dependencyinjection.abstractions@9.0.0
microsoft.extensions.dependencyinjection.autoactivation@9.0.0
microsoft.extensions.dependencyinjection@8.0.0
microsoft.extensions.dependencyinjection@9.0.0
microsoft.extensions.diagnostics.abstractions@8.0.0
microsoft.extensions.diagnostics.abstractions@9.0.0
microsoft.extensions.diagnostics.exceptionsummarization@9.0.0
microsoft.extensions.diagnostics@8.0.0
microsoft.extensions.diagnostics@9.0.0
microsoft.extensions.fileproviders.abstractions@8.0.0
microsoft.extensions.fileproviders.abstractions@9.0.0
microsoft.extensions.fileproviders.physical@8.0.0
microsoft.extensions.fileproviders.physical@9.0.0
microsoft.extensions.filesystemglobbing@8.0.0
microsoft.extensions.filesystemglobbing@9.0.0
microsoft.extensions.hosting.abstractions@8.0.0
microsoft.extensions.hosting.abstractions@9.0.0
microsoft.extensions.hosting@8.0.0
microsoft.extensions.hosting@9.0.0
microsoft.extensions.http.diagnostics@9.0.0
microsoft.extensions.http.resilience@9.0.0
microsoft.extensions.http@9.0.0
microsoft.extensions.logging.abstractions@2.0.0
microsoft.extensions.logging.abstractions@3.0.3
microsoft.extensions.logging.abstractions@6.0.1
microsoft.extensions.logging.abstractions@8.0.0
microsoft.extensions.logging.abstractions@9.0.0
microsoft.extensions.logging.configuration@8.0.0
microsoft.extensions.logging.configuration@9.0.0
microsoft.extensions.logging.console@8.0.0
microsoft.extensions.logging.console@9.0.0
microsoft.extensions.logging.debug@8.0.0
microsoft.extensions.logging.debug@9.0.0
microsoft.extensions.logging.eventlog@8.0.0
microsoft.extensions.logging.eventlog@9.0.0
microsoft.extensions.logging.eventsource@8.0.0
microsoft.extensions.logging.eventsource@9.0.0
microsoft.extensions.logging@2.0.0
microsoft.extensions.logging@2.1.1
microsoft.extensions.logging@8.0.0
microsoft.extensions.logging@9.0.0
microsoft.extensions.objectpool@9.0.0
microsoft.extensions.options.configurationextensions@8.0.0
microsoft.extensions.options.configurationextensions@9.0.0
microsoft.extensions.options@2.0.0
microsoft.extensions.options@8.0.0
microsoft.extensions.options@9.0.0
microsoft.extensions.primitives@8.0.0
microsoft.extensions.primitives@9.0.0
microsoft.extensions.resilience@9.0.0
microsoft.extensions.telemetry.abstractions@9.0.0
microsoft.extensions.telemetry@9.0.0
microsoft.extensions.timeprovider.testing@9.0.0
microsoft.io.recyclablememorystream@3.0.0
microsoft.net.http.headers@9.0.0
microsoft.net.test.sdk@17.11.1
microsoft.netcore.platforms@1.1.0
microsoft.netcore.platforms@2.0.0
microsoft.netcore.platforms@2.1.2
microsoft.netcore.platforms@5.0.0
microsoft.netcore.targets@1.1.0
microsoft.sourcelink.common@8.0.0
microsoft.sourcelink.github@8.0.0
microsoft.testplatform.objectmodel@17.10.0
microsoft.testplatform.objectmodel@17.11.1
microsoft.testplatform.testhost@17.11.1
microsoft.visualstudio.composition.netfxattributes@16.1.8
microsoft.visualstudio.composition@16.1.8
microsoft.visualstudio.threading.analyzers@17.10.48
microsoft.visualstudio.threading@17.10.48
microsoft.visualstudio.validation@15.0.82
microsoft.visualstudio.validation@17.8.8
microsoft.win32.primitives@4.3.0
microsoft.win32.registry@4.4.0
microsoft.win32.registry@5.0.0
nerdbank.fullduplexstream@1.1.12
nerdbank.streams@2.11.79
netescapades.enumgenerators@1.0.0-beta07
netstandard.library@1.6.0
netstandard.library@1.6.1
netstandard.library@2.0.3
newtonsoft.json.bson@1.0.2
newtonsoft.json@12.0.1
newtonsoft.json@13.0.1
newtonsoft.json@13.0.3
nexusmods.archives.nx@0.6.1
nexusmods.archives.nx@0.6.3
nexusmods.hashing.xxhash3.paths@3.0.3
nexusmods.hashing.xxhash3@3.0.3
nexusmods.mnemonicdb.abstractions@0.9.97
nexusmods.mnemonicdb.sourcegenerator@0.9.97
nexusmods.mnemonicdb@0.9.97
nexusmods.paths.extensions.nx@0.15.0
nexusmods.paths.testinghelpers@0.15.0
nexusmods.paths@0.10.0
nexusmods.paths@0.15.0
nlog.extensions.logging@5.3.14
nlog@5.3.4
noggog.csharpext@2.67.3
nsubstitute.analyzers.csharp@1.0.17
nsubstitute@5.3.0
nuget.common@6.3.4
nuget.configuration@6.3.4
nuget.frameworks@6.3.4
nuget.packaging@6.3.4
nuget.protocol@6.3.4
nuget.resolver@6.3.4
nuget.versioning@6.3.4
observablecollections.r3@3.3.2
observablecollections@3.3.2
oneof.extended@2.1.125
oneof@2.1.125
oneof@3.0.271
onigwrap@1.0.6
opentelemetry.api.providerbuilderextensions@1.10.0
opentelemetry.api@1.10.0
opentelemetry.exporter.opentelemetryprotocol@1.10.0
opentelemetry.extensions.hosting@1.10.0
opentelemetry@1.10.0
pathoschild.http.fluentclient@4.4.1
perfolizer@0.3.17
polly.core@8.4.2
polly.core@8.5.0
polly.extensions@8.4.2
polly.ratelimiting@8.4.2
polly@8.5.0
projektanker.icons.avalonia.materialdesign@9.4.1
projektanker.icons.avalonia@9.4.1
qoisharp@1.0.0
r3@1.0.0
r3@1.2.9
r3extensions.avalonia@1.2.9
reactiveui.fody@19.5.41
reactiveui@19.5.41
reactiveui@20.1.1
reactiveui@20.1.63
reloaded.memory@9.4.1
reloaded.memory@9.4.2
rocksdb@9.4.0.50294
runtime.any.system.collections@4.3.0
runtime.any.system.diagnostics.tools@4.3.0
runtime.any.system.diagnostics.tracing@4.3.0
runtime.any.system.globalization.calendars@4.3.0
runtime.any.system.globalization@4.3.0
runtime.any.system.io@4.3.0
runtime.any.system.reflection.extensions@4.3.0
runtime.any.system.reflection.primitives@4.3.0
runtime.any.system.reflection@4.3.0
runtime.any.system.resources.resourcemanager@4.3.0
runtime.any.system.runtime.handles@4.3.0
runtime.any.system.runtime.interopservices@4.3.0
runtime.any.system.runtime@4.3.0
runtime.any.system.text.encoding.extensions@4.3.0
runtime.any.system.text.encoding@4.3.0
runtime.any.system.threading.tasks@4.3.0
runtime.any.system.threading.timer@4.3.0
runtime.debian.8-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.fedora.23-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.fedora.24-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.native.system.io.compression@4.3.0
runtime.native.system.net.http@4.3.0
runtime.native.system.security.cryptography.apple@4.3.0
runtime.native.system.security.cryptography.openssl@4.3.0
runtime.native.system@4.3.0
runtime.opensuse.13.2-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.opensuse.42.1-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.apple@4.3.0
runtime.osx.10.10-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.rhel.7-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.14.04-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.16.04-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.ubuntu.16.10-x64.runtime.native.system.security.cryptography.openssl@4.3.0
runtime.unix.microsoft.win32.primitives@4.3.0
runtime.unix.system.console@4.3.0
runtime.unix.system.diagnostics.debug@4.3.0
runtime.unix.system.io.filesystem@4.3.0
runtime.unix.system.net.primitives@4.3.0
runtime.unix.system.net.sockets@4.3.0
runtime.unix.system.private.uri@4.3.0
runtime.unix.system.runtime.extensions@4.3.0
sha3.net@2.0.0
sharpziplib@1.4.2
sharpzstd.interop@1.5.6
shimskiasharp@2.0.0.4
simpleinfoname@3.0.1
skiasharp.harfbuzz@2.88.6
skiasharp.harfbuzz@2.88.8
skiasharp.nativeassets.linux@2.88.8
skiasharp.nativeassets.linux@2.88.9
skiasharp.nativeassets.macos@2.88.8
skiasharp.nativeassets.macos@2.88.9
skiasharp.nativeassets.webassembly@2.88.8
skiasharp.nativeassets.webassembly@2.88.9
skiasharp.nativeassets.win32@2.88.8
skiasharp.nativeassets.win32@2.88.9
skiasharp@2.88.6
skiasharp@2.88.8
skiasharp@2.88.9
spectre.console.cli@0.49.1
spectre.console.testing@0.49.1
spectre.console@0.49.1
splat.microsoft.extensions.logging@15.2.22
splat@14.8.12
splat@15.1.1
splat@15.2.22
strawberryshake.core@14.3.0
strawberryshake.resources@14.3.0
strawberryshake.server@14.3.0
strawberryshake.transport.http@14.3.0
strawberryshake.transport.websockets@14.3.0
svg.custom@2.0.0.4
svg.model@2.0.0.4
svg.skia@2.0.0.4
system.appcontext@4.3.0
system.buffers@4.3.0
system.buffers@4.5.1
system.codedom@5.0.0
system.codedom@8.0.0
system.codedom@9.0.0
system.collections.concurrent@4.0.12
system.collections.concurrent@4.3.0
system.collections.immutable@1.2.0
system.collections.immutable@5.0.0
system.collections.immutable@7.0.0
system.collections.immutable@8.0.0
system.collections@4.0.11
system.collections@4.3.0
system.commandline@2.0.0-beta4.22272.1
system.componentmodel.annotations@4.3.0
system.componentmodel.annotations@4.5.0
system.componentmodel.annotations@5.0.0
system.componentmodel.composition@4.5.0
system.componentmodel@4.3.0
system.composition.attributedmodel@1.0.31
system.composition.attributedmodel@7.0.0
system.composition.convention@1.0.31
system.composition.convention@7.0.0
system.composition.hosting@1.0.31
system.composition.hosting@7.0.0
system.composition.runtime@1.0.31
system.composition.runtime@7.0.0
system.composition.typedparts@1.0.31
system.composition.typedparts@7.0.0
system.composition@1.0.31
system.composition@7.0.0
system.configuration.configurationmanager@4.4.0
system.console@4.3.0
system.diagnostics.debug@4.0.11
system.diagnostics.debug@4.3.0
system.diagnostics.diagnosticsource@4.3.0
system.diagnostics.diagnosticsource@8.0.0
system.diagnostics.diagnosticsource@9.0.0
system.diagnostics.eventlog@6.0.0
system.diagnostics.eventlog@8.0.0
system.diagnostics.eventlog@9.0.0
system.diagnostics.tools@4.3.0
system.diagnostics.tracing@4.1.0
system.diagnostics.tracing@4.3.0
system.dynamic.runtime@4.0.11
system.formats.asn1@5.0.0
system.globalization.calendars@4.3.0
system.globalization.extensions@4.3.0
system.globalization@4.0.11
system.globalization@4.3.0
system.io.abstractions@21.0.29
system.io.compression.zipfile@4.3.0
system.io.compression@4.3.0
system.io.filesystem.primitives@4.3.0
system.io.filesystem@4.3.0
system.io.hashing@8.0.0
system.io.hashing@9.0.0
system.io.pipelines@6.0.3
system.io.pipelines@7.0.0
system.io.pipelines@8.0.0
system.io.pipelines@9.0.0
system.io@4.1.0
system.io@4.3.0
system.linq.async@6.0.1
system.linq.expressions@4.1.0
system.linq.expressions@4.3.0
system.linq@4.1.0
system.linq@4.3.0
system.management@5.0.0
system.management@8.0.0
system.memory@4.5.3
system.memory@4.5.4
system.memory@4.5.5
system.net.http@4.3.0
system.net.nameresolution@4.3.0
system.net.primitives@4.3.0
system.net.sockets@4.3.0
system.numerics.vectors@4.4.0
system.objectmodel@4.0.12
system.objectmodel@4.3.0
system.private.uri@4.3.0
system.reactive@5.0.0
system.reactive@6.0.1
system.reflection.emit.ilgeneration@4.0.1
system.reflection.emit.ilgeneration@4.3.0
system.reflection.emit.lightweight@4.3.0
system.reflection.emit@4.0.1
system.reflection.emit@4.3.0
system.reflection.emit@4.7.0
system.reflection.extensions@4.0.1
system.reflection.extensions@4.3.0
system.reflection.metadata@1.3.0
system.reflection.metadata@1.6.0
system.reflection.metadata@5.0.0
system.reflection.metadata@7.0.0
system.reflection.metadata@8.0.0
system.reflection.primitives@4.0.1
system.reflection.primitives@4.3.0
system.reflection.typeextensions@4.1.0
system.reflection.typeextensions@4.3.0
system.reflection@4.1.0
system.reflection@4.3.0
system.resources.resourcemanager@4.0.1
system.resources.resourcemanager@4.3.0
system.runtime.compilerservices.unsafe@4.5.2
system.runtime.compilerservices.unsafe@4.5.3
system.runtime.compilerservices.unsafe@5.0.0
system.runtime.compilerservices.unsafe@6.0.0
system.runtime.extensions@4.1.0
system.runtime.extensions@4.3.0
system.runtime.handles@4.3.0
system.runtime.interopservices.runtimeinformation@4.3.0
system.runtime.interopservices@4.1.0
system.runtime.interopservices@4.3.0
system.runtime.numerics@4.3.0
system.runtime@4.1.0
system.runtime@4.3.0
system.security.accesscontrol@4.4.0
system.security.accesscontrol@4.5.0
system.security.accesscontrol@5.0.0
system.security.claims@4.3.0
system.security.cryptography.algorithms@4.3.0
system.security.cryptography.cng@4.3.0
system.security.cryptography.cng@5.0.0
system.security.cryptography.csp@4.3.0
system.security.cryptography.encoding@4.3.0
system.security.cryptography.openssl@4.3.0
system.security.cryptography.pkcs@5.0.0
system.security.cryptography.primitives@4.3.0
system.security.cryptography.protecteddata@4.4.0
system.security.cryptography.x509certificates@4.3.0
system.security.permissions@4.5.0
system.security.principal.windows@4.3.0
system.security.principal.windows@4.4.0
system.security.principal.windows@4.5.0
system.security.principal.windows@5.0.0
system.security.principal@4.3.0
system.text.encoding.codepages@4.5.1
system.text.encoding.codepages@7.0.0
system.text.encoding.extensions@4.0.11
system.text.encoding.extensions@4.3.0
system.text.encoding@4.0.11
system.text.encoding@4.3.0
system.text.encodings.web@8.0.0
system.text.json@8.0.0
system.text.json@8.0.4
system.text.json@8.0.5
system.text.regularexpressions@4.3.0
system.threading.channels@7.0.0
system.threading.ratelimiting@8.0.0
system.threading.tasks.dataflow@4.6.0
system.threading.tasks.extensions@4.3.0
system.threading.tasks.extensions@4.5.4
system.threading.tasks@4.0.11
system.threading.tasks@4.3.0
system.threading.threadpool@4.3.0
system.threading.timer@4.3.0
system.threading@4.0.11
system.threading@4.3.0
system.xml.readerwriter@4.3.0
system.xml.xdocument@4.3.0
testableio.system.io.abstractions.wrappers@21.0.29
testableio.system.io.abstractions@21.0.29
textmatesharp.grammars@1.0.59
textmatesharp.grammars@1.0.64
textmatesharp@1.0.59
textmatesharp@1.0.64
tmds.dbus.protocol@0.20.0
transparentvalueobjects@1.0.2
validation@2.3.7
validation@2.4.18
valvekeyvalue@0.10.0.360
verify.imagemagick@3.6.0
verify.sourcegenerators@2.5.0
verify.xunit@28.2.1
verify@26.5.0
verify@27.0.0
verify@28.2.1
weave@2.1.0
xunit.abstractions@2.0.1
xunit.abstractions@2.0.2
xunit.abstractions@2.0.3
xunit.analyzers@1.16.0
xunit.assert@2.3.0
xunit.assert@2.9.2
xunit.core@2.9.2
xunit.dependencyinjection.logging@9.0.0
xunit.dependencyinjection.skippablefact@9.0.0
xunit.dependencyinjection@9.0.0
xunit.dependencyinjection@9.6.0
xunit.extensibility.core@2.2.0
xunit.extensibility.core@2.4.0
xunit.extensibility.core@2.4.2
xunit.extensibility.core@2.9.2
xunit.extensibility.execution@2.4.0
xunit.extensibility.execution@2.4.2
xunit.extensibility.execution@2.9.2
xunit.runner.visualstudio@2.8.2
xunit.skippablefact@1.4.13
xunit@2.9.2
zstdsharp.port@0.8.2
zstring@2.6.0
"

inherit desktop dotnet-pkg virtualx xdg

DESCRIPTION="Nexus Mods App, a mod installer, creator and manager for all your popular games"
HOMEPAGE="
	https://www.nexusmods.com/
	https://github.com/Nexus-Mods/NexusMods.App/
"

MY_PN="NexusMods.App"
MY_PV="${PV/_/-}" # nuget compatible version
MY_P="${MY_PN}-${MY_PV}"

SMAPI_COMMIT="ae4c42648356b6ee5c769397e3a2048b22bfd80b"
TESTDB_LFS_COMMIT="9a590db37705d191f53665ed312c7485edc375d7"
DOCS_THEME_COMMIT="fe4e8b1b26d2c2917b404b0b091bfa31f135e337"

SRC_URI="
	https://github.com/Nexus-Mods/NexusMods.App/archive/refs/tags/v${MY_PV}.tar.gz
		-> ${MY_P}.tar.gz
	https://github.com/Pathoschild/SMAPI/archive/${SMAPI_COMMIT}.tar.gz
		-> SMAPI-${SMAPI_COMMIT}.tar.gz
	${NUGET_URIS}
	test? (
		https://github.com/Nexus-Mods/NexusMods.App/raw/${TESTDB_LFS_COMMIT}/tests/NexusMods.DataModel.SchemaVersions.Tests/Resources/Databases/SDV.4_11_2024.rocksdb.zip
			-> ${PN}-${TESTDB_LFS_COMMIT}-SDV.4_11_2024.rocksdb.zip
	)
"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3"
SLOT="0"

COMMON_DEPEND="
	app-arch/bzip2
	app-arch/lz4
	app-arch/snappy
	app-arch/zstd
	sys-libs/zlib
"
RDEPEND="
	${COMMON_DEPEND}
	app-arch/7zip
	dev-util/desktop-file-utils
	media-libs/fontconfig
	x11-misc/xdg-utils
"
DEPEND="${COMMON_DEPEND}"
BDEPEND="
	test? ( app-arch/unzip )
"

DOTNET_PKG_PROJECTS=( "${S}/src/NexusMods.App/NexusMods.App.csproj" )

DOTNET_PKG_BUILD_EXTRA_ARGS=(
	-p:Version="${MY_PV}"
	-p:DefineConstants="\"NEXUSMODS_APP_USE_SYSTEM_EXTRACTOR;INSTALLATION_METHOD_PACKAGE_MANAGER\""
)
DOTNET_PKG_TEST_EXTRA_ARGS=(
	--blame-hang-timeout 2m
	--filter "RequiresNetworking!=True&FlakeyTest!=True"
)

PATCHES=(
	"${FILESDIR}/nexusmodsapp-0.7.1-update-fully-to-dotnet9.patch"
)

src_unpack() {
	nuget_link-system-nugets
	nuget_link-nuget-archives
	unpack ${MY_P}.tar.gz
	unpack SMAPI-${SMAPI_COMMIT}.tar.gz
}

src_prepare() {
	mv -T "${WORKDIR}/SMAPI-${SMAPI_COMMIT}" "${S}/extern/SMAPI" || die

	if use test; then
		# lfs files not included in github generated archives
		cp -T \
			"${DISTDIR}/${PN}-${TESTDB_LFS_COMMIT}-SDV.4_11_2024.rocksdb.zip" \
			"${S}/tests/NexusMods.DataModel.SchemaVersions.Tests/Resources/Databases/SDV.4_11_2024.rocksdb.zip" || die
	fi

	sed -i -e 's/${INSTALL_EXEC}/NexusMods.App/' src/NexusMods.App/com.nexusmods.app.desktop || die

	# Requires networking
	sed -i \
		-e '/Test_LoadAndCache_\(RemoteImage\|ImageStoredFile\)/i    [Trait("RequiresNetworking", "True")]' \
		tests/NexusMods.UI.Tests/ImageCacheTests.cs || die

	if ! use debug; then
		# xunit doesnt support conditional unit tests like this
		sed -i \
			-e '
			/\[Fact\]/,/Constructor_WithItemsFromDifferentGames_ShouldThrowArgumentException_InDebug/ {
				s/\[Fact\]/[Fact (Skip = "requires a debug build")]/
			}
			' \
			tests/Networking/NexusMods.Networking.ModUpdates.Tests/PerFeedCacheUpdaterTests.cs || die
	fi

	default
}

src_test() {
	# https://github.com/Nexus-Mods/NexusMods.App/issues/1224#issuecomment-2060696994
	local -x USER="portage"
	virtx dotnet-pkg_src_test
}

src_install() {
	dotnet-pkg-base_install
	dotnet-pkg-base_dolauncher "/usr/share/${P}/NexusMods.App" "NexusMods.App"

	newicon Nexus-Icon.png com.nexusmods.app.png
	domenu src/NexusMods.App/com.nexusmods.app.desktop

	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "The Nexus Mods app is still in the very early stages of development. This means"
	elog "that some of the core backend functionality of the app may still change"
	elog "significantly between releases. When this changes all existing data becomes"
	elog "incompatible with the new versions and users who wish to update will need to"
	elog "start over."
	elog "To do so run:"
	elog "$ NexusMods.App uninstall-app"
	elog "See https://nexus-mods.github.io/NexusMods.App/users/Uninstall/ for further instructions"
}
