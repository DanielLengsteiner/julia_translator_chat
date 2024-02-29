`pkg`-mode (manage packages): 
- Access: press `]`
- Exit: press `Ctrl+C`
- install package: `add PackageName`

`shell`-mode:
- Access: press `;`
- Exit: press Backspace
- current directory: `pwd`
- change directory: `cd`

Generate new Genie project:
- Enter shell and switch to desired directory
- Standard: in Julia REPL, execute `Genie.Generator.newapp_webservice("NAME")`
- MVC (has database): in Julia REPL, execute `Genie.Generator.newapp_mvc("NAME")`