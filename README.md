# "slides.nvim"

Neovim plugin for creating slides with markdown or asciidoc.
Note, this is experimental plugin and may not work as expected.

Plugin is based on TJ DeVries' video https://youtu.be/VGid4aN25iI.

## Installation

Lazy
```
require {
    "apechinsky/slides.nvim",
    config = function()
        require("apechinsky/slides").setup()
    end
}
```

### Create slides

Create slides file in markdown or asciidoc format.
Slides are defined by first level header:

* '# ' - for markdown
* '= ' - for asciidoc

### Start presentation

```lua
require("apechinsky/slides").setup()
```

* 'n' - next slide
* 'p' - previous slide
* 'q' - quit
