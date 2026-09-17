-- Completion and AI assistants

return {
  { "hrsh7th/nvim-cmp", event = "InsertEnter", opts = {} },

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {},
  },

  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
    build = "bundled_build.lua", -- Installs required mcp-hub npm module
    config = function()
      require("mcphub").setup({
        use_bundled_binary = true,
        port = 37373,
        config = vim.fn.expand("~/.config/mcphub/servers.json"),
        extensions = {
          avante = {
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          },
        },
      })
    end,
  },

  {
    "dq1Mango/avante.nvim",
    branch = "main",
    build = "make", -- pass source=true to the build if you want to build from source
    event = "VeryLazy",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- optional deps
      "nvim-tree/nvim-web-devicons",
      "hrsh7th/nvim-cmp",
      "zbirenbaum/copilot.lua",
      "ibhagwan/fzf-lua",
      "stevearc/dressing.nvim",
      "folke/snacks.nvim",
      "echasnovski/mini.nvim",
      "3rd/image.nvim",
      "hakonharnes/img-clip.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
      "ravitemer/mcphub.nvim",
    },
    opts = {
      mode = "agentic",
      behaviour = {
        auto_approve_tool_permissions = false,
      },
      instructions_file = "AGENTS.md",

      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,

      provider = "claude",
      providers = {
         claude = {
            auth_type = "max",
            model = "claude-sonnet-5",
            endpoint = "https://api.anthropic.com",
            timeout = 30000, -- Timeout in milliseconds
        },
        ["claude-sonnet5"] = {
            __inherited_from = "claude",
            endpoint = "https://api.anthropic.com",
            auth_type = "max",
            model = "claude-sonnet-5",
            timeout = 30000, -- Timeout in milliseconds
        },
        ["claude-opus5"] = {
            __inherited_from = "claude",
            endpoint = "https://api.anthropic.com",
            auth_type = "max",
            model = "claude-opus-5",
            timeout = 30000, -- Timeout in milliseconds
        },
        ["claude-fable5"] = {
            __inherited_from = "claude",
            endpoint = "https://api.anthropic.com",
            auth_type = "max",
            model = "claude-fable-5",
            timeout = 30000, -- Timeout in milliseconds
        },
        copilot = {
            model = "claude-sonnet-4.5",
            -- model = "gpt-5-mini",
            endpoint = "https://api.githubcopilot.com",
            allow_insecure = false,
            timeout = 10 * 60 * 1000,
            max_completion_tokens = 1000000,
            reasoning_effort = "high",
        },
      },
      web_search_engine = {
        provider = "searxng",
        proxy = nil,
      },
    },
  },
}

