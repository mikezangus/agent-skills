# Agent skills

[Agent skills](https://agentskills.io) for authoring skills, assigning code responsibilities, and writing acceptance checks.
To list the skills and their descriptions from a local checkout, run `npx skills add . --list`.

## Installation

To install from the current checkout, run `npx skills add . --global` from the repository root.

[Skills CLI](https://github.com/vercel-labs/skills):

```sh
npx skills add mikezangus/agent-skills --global
```

Install script:

```sh
curl -fsSL https://raw.githubusercontent.com/mikezangus/agent-skills/master/install.sh | bash
```

For optional arguments, replace `bash` with:

```text
bash -s -- [--target-directory DIRECTORY] [SKILL ...]

--target-directory DIRECTORY  Install directory (default: ~/.agents/skills)
SKILL                         Skill to install (default: all skills)
```

Existing installations of selected skills are replaced.
