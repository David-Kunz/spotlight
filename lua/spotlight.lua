local M = {}


local namespace = vim.api.nvim_create_namespace("David-Kunz/sneak")
M.run = function()
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)

    local ts_utils = require('nvim-treesitter.ts_utils')

    local node = ts_utils.get_node_at_cursor()
    if not node then return end

    local locals = require('nvim-treesitter.locals')

    local def, scope = locals.find_definition(node, 0)
    if not def then return end

    local containing_scope = locals.containing_scope(node, 0)
    if not containing_scope then return end
    ts_utils.highlight_node(containing_scope, 0, namespace, "CursorLine")

    local usages = locals.find_usages(def, scope, 0)
    if not usages then return end

    for _, n in ipairs(usages) do
      ts_utils.highlight_node(n, 0, namespace, "TermCursor")
    end

end

return M
