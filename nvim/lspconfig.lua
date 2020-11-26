require'lspconfig'.rls.setup{
    on_attach=require'completion'.on_attach
}
require'lspconfig'.hls.setup{
    on_attach=require'completion'.on_attach
}

