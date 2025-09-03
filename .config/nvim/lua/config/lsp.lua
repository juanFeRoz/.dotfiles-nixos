vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')
vim.lsp.enable('jdtls')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        vim.keymap.set({ 'n', 'i' }, '<C-Space>', '<C-x><C-o>', {})
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {})
        vim.keymap.set({ 'n', 'x' }, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', {})
        vim.keymap.set('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', {})
        vim.keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', {})
    end,
})

vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess:append('c')

local function tab_complete()
    if vim.fn.pumvisible() == 1 then
        -- navigate to next item in completion menu
        return '<Down>'
    end

    local c = vim.fn.col('.') - 1
    local is_whitespace = c == 0 or vim.fn.getline('.'):sub(c, c):match('%s')

    if is_whitespace then
        -- insert tab
        return '<Tab>'
    end

    local lsp_completion = vim.bo.omnifunc == 'v:lua.vim.lsp.omnifunc'

    if lsp_completion then
        -- trigger lsp code completion
        return '<C-x><C-o>'
    end

    -- suggest words in current buffer
    return '<C-x><C-n>'
end

local function tab_prev()
    if vim.fn.pumvisible() == 1 then
        -- navigate to previous item in completion menu
        return '<Up>'
    end

    -- insert tab
    return '<Tab>'
end

vim.keymap.set('i', '<Tab>', tab_complete, { expr = true })
vim.keymap.set('i', '<S-Tab>', tab_prev, { expr = true })
