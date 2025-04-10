# slides.nvim

Test neovim plugin.

Neovim plugin for creating slides with markdown or asciidoc.
Note, this is experimental plugin and may not work as expected.

Plugin is based on TJ DeVries' video https://youtu.be/VGid4aN25iI.

## Installation

Lazy
```
return {
    "apechinsky/slides.nvim",
    main = 'apechinsky/slides',
}
```

### Create slides

Create slides file in markdown or asciidoc format.
Slides are defined by second level header:

* '## ' - for markdown
* '== ' - for asciidoc

### Start presentation

* Start presentation:
  * Option 1: `:Slides` - Command
  * Option 2: require("apechinsky/slides").start() - Lua call

* Control presentation
  * 'n' - next slide
  * 'p' - previous slide
  * 'q' - quit
