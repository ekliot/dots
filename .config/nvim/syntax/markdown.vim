syntax region mdWikiLink matchgroup=mdWikiBrackets start=/\[\[/ end=/\]\]/ keepend display oneline contains=mdWikiAliasedLink
syntax match mdWikiAliasedLink "[^\[\]]\+|" contained conceal
