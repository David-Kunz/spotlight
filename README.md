# Spotlight

A Neovim plugin to highlight the current identifier under the cursor.

## Installation

Packer:

```lua
use 'David-Kunz/spotlight'
```

## Usage

```lua
require('spotlight').run()
```

## Options

```lua
require('spotlight').setup(options)
```

with the following options (with defaults):

```lua
options = {hl_group = 'LspReferenceText'}
```

## Tip

To automatically run it after the cursor was moved:

- with a small delay:

```lua
vim.api.nvim_create_autocmd("CursorHold", {callback = require('spotlight').run})
```

- instantaneously:


```lua
vim.api.nvim_create_autocmd("CursorMoved", {callback = require('spotlight').run})
```


