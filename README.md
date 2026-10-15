# Agent skills

[Agent skills](https://agentskills.io) for design, research, and writing.

| Skill | Use it to |
| --- | --- |
| [investigation](investigation/SKILL.md) | Research questions, compare explanations, and assess what sources and observations establish. |
| [natural-language-composition](natural-language-composition/SKILL.md) | Write and revise statements and instructions, checking references, conditions, qualifications, and connections between statements. |
| [representation-design](representation-design/SKILL.md) | Choose names, definitions, categories, and encodings; preserve required distinctions when transforming information. |
| [structural-design](structural-design/SKILL.md) | Decide what belongs together, what should be separate, and how the parts depend on each other. |

## Installation

[Skills CLI](https://github.com/vercel-labs/skills):

```sh
npx skills add mikezangus/agent-skills --global
```

Install script:

```sh
bash -o pipefail -c 'curl -fsSL https://raw.githubusercontent.com/mikezangus/agent-skills/master/install.sh | bash -s -- "$@"' --
```

Arguments after the final `--`:

```text
[--target-directory DIRECTORY] [SKILL ...]

--target-directory DIRECTORY  Install directory (default: ~/.agents/skills)
SKILL                         Skill to install (default: all skills)
```

Existing installations of selected skills are replaced.

## License

[MIT](LICENSE).
