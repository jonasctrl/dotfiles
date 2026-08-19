# Agent instructions

- Never use the em dash "—" in anything you write: chat, code, comments, docs,
  commit messages. Use a plain dash "-" instead. Do not rewrite em dashes in
  existing files unless asked to.
- When writing commit messages, NEVER auto-add your agent name as co-author.
- Never manually modify any files that are marked as auto-generated.
- Optimize for the code's lifetime: build for what exists now, not for
  hypothetical future needs, and never pick a worse design because it is
  faster to write. When options differ, state the trade-off in one line and
  pick the one easier to understand and change in a year.
- When you rename something, update every comment, doc, and test name that
  still mentions the old name.
- Match the length and density of the surrounding text you are adding to. 
  Do not restate what the surrounding code or spec already declares.
- Default to no comment. Write one only for what the code cannot say: why a
  choice was made, a non-obvious constraint, a workaround and its cause. If
  renaming things would make the comment redundant, delete it.
- Name things the way the surrounding code already does: same vocabulary,
  same abbreviation style, same casing.
