{ config, pkgs, inputs, ... }:
{
  programs.nixvim = {
    enable = true;

    colorschemes.tokyonight = {
      enable = true;
      transparent = true;
    };

    plugins = {
      alpha = {
        enable = true;
	      theme = "dashboard";
      };
      lualine.enable = true;
      treesitter.enable = true;
      nvim-tree.enable = true;
      comment-nvim.enable = true;
      tmux-navigator.enable = true;
      which-key.enable = true;
      nvim-autopairs.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<leader>fg" = {
            action = "live_grep";
            desc = "Find word";
          };
          "<leader>sf" = {
            action = "find_files";
            desc = "Find file";
          };
        };
      };
      gitsigns = {
        enable = true;
        signcolumn = true;
        signs = {
          add = {text = "+";};
          change = {text = "~";};
          delete = {text = "_";};
          topdelete = {text = "‾";};
          changedelete = {text = "~";};
	        };
      };
      lsp = {
        enable = true;
        servers = {
          lua-ls.enable = true;
          clangd.enable = true;
          pyright.enable = true;
          nixd.enable = true;
	      };
      };
      luasnip.enable = true;
      friendly-snippets.enable = true;
      cmp = {
        enable = true;
	      autoEnableSources = true;
	      settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "path";}
            {name = "buffer";}
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = false })";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-h>" = "cmp.mapping.scroll_docs(-4)";
            "<C-l>" = "cmp.mapping.scroll_docs(4)";
          };
        };
      };
    };

    # clipboard.providers.wl-copy = {
    #   enable = true;
    #   package = pkgs.wl-clipboard;
    # };

    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      mouse = "a";
      wrap = false;
      smartindent = true;
      autoindent = true;
      ignorecase = true;
      smartcase = true;
      breakindent = true;
      hlsearch = false;
      clipboard = "unnamedplus";
    };

    autoCmd = [
      {
        event = [ "BufEnter" "BufWinEnter" ];
        pattern = [ "*.nix" ];
        command = "set shiftwidth=2";
      }
      {
        event = [ "BufEnter" "BufWinEnter" ];
        pattern = [ "*.nix" ];
        command = "set tabstop=2";
      }
      {
        event = [ "BufEnter" "BufWinEnter" ];
        pattern = [ "*.nix" ];
        command = "set expandtab";
      }
    ];

    extraConfigLua = ''
      vim.cmd[[ highlight LineNr guifg=#fbe790 ]]
    '';

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        mode = "i";
        key = "jk";
        action = "<esc>";
      }
      {
        mode = "n";
        key = "<leader>`";
        action = ":NvimTreeToggle<cr>";
      }
      {
        mode = "n";
        key = "[d";
        action = "vim.diagnostics.goto_prev";
      }
      {
        mode = "n";
        key = "[d";
        action = "vim.diagnostics.goto_next";
      }
    ];
  };
}
