lvim.builtin.treesitter.ensure_installed = {
  "rust",
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

-- TODO I feel like if I could get the intermediate type hints working for rustaceanvim that would be helpful
-- vim.g.rustaceanvim.tools.inlay_hints = {
--   auto = true,
--   only_current_line = false,
--   show_parameter_hints = false,
--   parameter_hints_prefix = "<-",
--   other_hints_prefix = "=>",
--   max_len_align = false,
--   max_len_align_padding = 1,
--   right_align = false,
--   right_align_padding = 7,
--   highlight = "Comment",
-- }

lvim.builtin.which_key.mappings["R"] = {
  name = "Rust",
  r = { "<cmd>RustLsp runnables<Cr>", "Runnables" },
  t = { "<cmd>RustLsp testables<Cr>", "Testables" },
  m = { "<cmd>RustLsp expandMacro<Cr>", "Expand Macro" },
  d = { "<cmd>RustLsp debuggables<Cr>", "Debuggables" },
  b = { "<cmd>term cargo build<Cr>", "Cargo Build" },
  v = { { g = { "<cmd>RustLsp crateGraph<Cr>", "View Crate Graph" }, h = { "<cmd>RustLsp view hir<Cr>", "View HIR" }, m = { "<cmd>RustLsp view mir<Cr>", "View MIR" } }, "View" },
  o = { "<cmd>RustLsp openDocs<Cr>", "Open External Docs" },
  y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
  P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
  i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
  f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
  D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
}
