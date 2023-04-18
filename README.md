# C++ Template Project with SFML and CMake

Small starter project for starting C++ with Visual Studio Code on Windows with the Microsoft Visual Studio Command Line Tools and on MacOS.

#### Prepare Third-Party Libraries

For using third-party libraries, run the script setup.ps1 / setup.sh to download and build the third party libraries. After that, open the command palette in Visual Studio Code and execute the "CMake: Delete Cache and Reconfigure" task.
Then the project can be build with the Visual Studio Cmake tools.

#### Setup Visual Studio Code

- Install Visual Studio Code and add C/C++ Extension Pack

- Create the file .vscode/settings.json for code formatting:
```
{
    "C_Cpp.clang_format_fallbackStyle": "{ BasedOnStyle: Google, IndentWidth: 4, IndentPPDirectives: BeforeHash, IncludeBlocksStyle: Regroup, ColumnLimit: 0  }"
}
```
If you want to format the code with Allman Style braces, add "BreakBeforeBraces: Allman" to the styles.

- Create a .vscode/launch.json configuration to setup the debugger launch task:

Windows:
```
{
    "version": "0.2.0",
    "configurations": [
        
        {
            "name": "Start Debug",
            "type": "cppvsdbg",
            "request": "launch",
            "program": "${workspaceFolder}/target/cpp-template.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${fileDirname}",
            "environment": [],
            "console": "integratedTerminal"
        }

    ]
}
```

MacOS:
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Start Debug",
            "type": "cppdbg",
            "request": "launch",
            "program": "${workspaceFolder}/target/cpp-template",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${fileDirname}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "lldb"
        }

    ]
}
```