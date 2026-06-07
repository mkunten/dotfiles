#/bin/bash
set -euo pipefail

mise use -g dotnet@latest
dotnet tool install -g dotnet-counters
dotnet tool install -g dotnet-dump
dotnet tool install -g dotnet-trace
dotnet tool install -g dotnet-t4 # code generator
dotnet tool install -g dotnet-ef # EF Core
dotnet tool install -g dotnet-repl
dotnet tool install -g csharp-ls

echo 'run "exec $SHELL -l"'
exit 0
