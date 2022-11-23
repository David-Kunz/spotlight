# Spotlight

A Neovim plugin to highlight the current identifier under the cursor and scope.

## Installation

Packer:

```lua
use 'David-Kunz/spotlight'
```

## Usage

```lua
require('spotlight').run()
```

## Tip

To automatically run it, you can add:

```lua
vim.api.nvim_create_autocmd("CursorHold", {callback = require('spotlight').run})
```

