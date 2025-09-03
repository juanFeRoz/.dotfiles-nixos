return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        local npairs = require("nvim-autopairs")

        npairs.setup({})

        -- Add custom rule for /* */
        local Rule = require("nvim-autopairs.rule")
        npairs.add_rule(Rule("/*", "*/", "c"))
    end
}
