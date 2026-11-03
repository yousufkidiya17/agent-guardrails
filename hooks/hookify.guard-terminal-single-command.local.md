---
name: guard-terminal-single-command
enabled: true
event: bash
pattern: (;\s*|&&\s*|\|\|\s*)
action: warn
---

[STRICT TERMINAL GUARDRAIL HOOK]
Maximum 1 terminal command per response turn is allowed. Never chain speculative commands using semicolons or boolean operators without observing output first.
