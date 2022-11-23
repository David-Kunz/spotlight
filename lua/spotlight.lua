local M = {}

local namespace = vim.api.nvim_create_namespace("David-Kunz/sneak")
M.run = function()
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
    local ts_utils = require('nvim-treesitter.ts_utils')
    local node = ts_utils.get_node_at_cursor()
    if not node or node:type() ~= 'identifier' then return end
    local text = vim.treesitter.query.get_node_text(node, 0)
    local parser = require('nvim-treesitter.parsers').get_parser()
    local query_string = '((identifier) @identifier (#match? @identifier "^' ..
                             text .. '$"))'
    local ok, query = pcall(vim.treesitter.query.parse_query, parser:lang(),
                            query_string)
    if not ok then return end
    local tree = parser:parse()[1]
    for _, n in query:iter_captures(tree:root(), 0) do
        ts_utils.highlight_node(n, 0, namespace, "TermCursor")
    end
end

return M
