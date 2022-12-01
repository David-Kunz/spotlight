local M = {}

local o = {hl_group = 'LspReferenceText', highlight_at_cursor = false}

local namespace = vim.api.nvim_create_namespace("David-Kunz/spotlight")
M.run = function()
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
    local ts_utils = require('nvim-treesitter.ts_utils')
    local node = ts_utils.get_node_at_cursor()
    if not node then return end
    local locals = require('nvim-treesitter.locals')
    local def, scope = locals.find_definition(node, 0)
    if not def then return end
    local usages = locals.find_usages(def, scope, 0)
    for _, n in ipairs(usages) do
        if o.highlight_at_cursor or n ~= node then
            ts_utils.highlight_node(n, 0, namespace, o.hl_group)
        end
    end
end

M.setup = function(options) vim.tbl_deep_extend('force', o, options) end

return M
