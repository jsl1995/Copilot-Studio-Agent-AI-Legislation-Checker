# Copilot Studio AI Compliance Skill

An agent skill that assesses a **Microsoft Copilot Studio agent** for compliance with AI legislation. Point it at an unpacked agent (the local YAML produced by cloning an agent) and it produces a severity-ranked compliance report.

## What it does

1. **Asks which region(s) the agent will operate in** — UK, EU, UK + EU, or any other jurisdiction (other regions are researched live via web search rather than from stored reference material).
   - UK-facing agents are **always also assessed against EU law**: the EU AI Act (Art 2(1)(c)) and EU GDPR (Art 3(2)) apply extraterritorially where the agent's output is used in the EU or it serves EU users. These items are reported under an explicit *"EU law applying extraterritorially"* heading.
2. **Inventories the agent source** — `agent.mcs.yml` instructions, `settings.mcs.yml` (auth mode, content moderation, generative actions…), topics, actions, variables and connection references — and builds a personal-data map of everything the agent collects and where it goes.
3. **Classifies the agent** under the EU AI Act (provider vs deployer role, prohibited / high-risk / limited / minimal tier) and the UK's five cross-sector AI principles.
4. **Assesses a requirement catalogue** spanning the EU AI Act, UK AI principles, EU/UK GDPR & DPA 2018 (including automated decision-making as amended by the Data (Use and Access) Act 2025), consumer & equality law, and platform technical controls.
5. **Outputs a report** with:
   - 🔴 **High** / 🟠 **Medium** / 🟡 **Low** findings, each citing the specific legislative provision (instrument + article/section) with a link to the official source (EUR-Lex, legislation.gov.uk, ICO), the YAML evidence as `file:line`, a remediation, and an owner (YAML fix vs organisational action)
   - a separate list of items requiring organisational evidence (DPIA, privacy notice, retention schedule…)
   - a coverage-matrix appendix as the audit trail that every in-scope requirement was checked

> ⚠️ **Disclaimer:** this produces a technical compliance assessment, not legal advice. Findings should be validated by qualified legal counsel and your DPO before being relied upon.

## Repository structure

```
SKILL.md                        # the skill definition (Agent Skills format)
resources/
  eu-legislation.md             # EU AI Act, EU GDPR, UCPD, EAA — with EUR-Lex links
  uk-legislation.md             # UK AI principles, UK GDPR/DPA 2018, DUAA 2025, Equality Act, DMCC — with legislation.gov.uk/ICO links
```

## Prerequisite: clone your agent locally

The skill works on the **unpacked YAML source** of a Copilot Studio agent — a folder containing `agent.mcs.yml`, `settings.mcs.yml`, and `topics/`, `actions/`, `variables/` subfolders.

### Option A — Microsoft Copilot Studio extension for VS Code

1. Install the **Microsoft Copilot Studio** extension from the VS Code marketplace.
2. Sign in with an account that has access to the Power Platform environment hosting the agent.
3. Open the Command Palette (`Ctrl+Shift+P`) → **Copilot Studio: Clone agent** (or use the Copilot Studio panel).
4. Pick the environment, pick the agent, and choose a local folder.
5. You should end up with a structure like:

```
MyAgent/
  agent.mcs.yml
  settings.mcs.yml
  connectionreferences.mcs.yml
  topics/*.mcs.yml
  actions/*.mcs.yml
  variables/*.mcs.yml
```

### Option B — Claude Code with the Copilot Studio plugin

If you use the Copilot Studio plugin for Claude Code, run:

```
/copilot-studio:clone-agent
```

and follow the prompts (environment selection → agent selection → local folder).

## Running the skill in Claude Code

1. Copy this repo's contents into a skills folder:
   - **Personal (all projects):** `~/.claude/skills/copilot-studio-ai-compliance/`
   - **Project-scoped:** `<your-repo>/.claude/skills/copilot-studio-ai-compliance/`

   ```powershell
   git clone https://github.com/jsl1995/copilot-studio-ai-compliance "$env:USERPROFILE\.claude\skills\copilot-studio-ai-compliance"
   ```

   ```bash
   git clone https://github.com/jsl1995/copilot-studio-ai-compliance ~/.claude/skills/copilot-studio-ai-compliance
   ```

2. Start Claude Code in (or navigate to) the folder containing your unpacked agent.
3. Invoke the skill:

   ```
   /copilot-studio-ai-compliance
   ```

   or just ask naturally: *"Run an AI compliance review of this agent."*

4. Answer the region question when prompted, then review the report. The skill will offer to save it as `ai-compliance-report.md` and to implement the YAML-level fixes (e.g. adding an AI-disclosure message to the greeting topic).

## Running the skill in GitHub Copilot

GitHub Copilot (VS Code) has rolling support for the Agent Skills format; where it isn't available yet, the prompt-file route below works everywhere.

### Option A — Agent Skills support (where available)

Copy the skill into your repository so Copilot's agent mode can discover it:

```
<your-repo>/.github/skills/copilot-studio-ai-compliance/SKILL.md
<your-repo>/.github/skills/copilot-studio-ai-compliance/resources/...
```

Then, in Copilot Chat (Agent mode), ask: *"Assess this agent for AI legislation compliance using the copilot-studio-ai-compliance skill."*

### Option B — Prompt file (works today in any Copilot Chat)

1. Copy `SKILL.md` and the `resources/` folder into your repo, e.g. under `.github/prompts/`, renaming `SKILL.md` to `copilot-studio-ai-compliance.prompt.md` (keep `resources/` next to it and strip the YAML frontmatter if Copilot complains).
2. Open your unpacked agent folder in VS Code.
3. In Copilot Chat run the prompt file (`/copilot-studio-ai-compliance` in chat, or attach it via *Add Context → Prompt…*), or simply attach `SKILL.md` as context (`#file`) and say: *"Follow these instructions to assess the agent in this workspace."*

Notes for Copilot users:

- The skill's interactive region question becomes a plain chat question — answer it in the conversation.
- For regions other than UK/EU the skill relies on web research; enable Copilot's web search tool (`#fetch`/web search in agent mode) or supply the relevant legislation yourself.

## Example findings (from a real assessment)

| Severity | Finding | Legislation |
|---|---|---|
| 🔴 High | No "I am an AI" disclosure in the greeting topic | EU AI Act, Art 50(1) |
| 🔴 High | Placeholder escalation address (`test@...`) — no working redress route | UK principle 5 (contestability & redress) |
| 🟠 Medium | `contentModeration: Low` on a public-facing agent | UK principle 1 (safety) |
| 🟠 Medium | Automated out-of-coverage rejection with no human review route | UK GDPR Art 22 (as amended by DUAA 2025) |

## Keeping it current

The reference files state the law **as of early 2026**. EU AI Act obligations phase in through 2027 and UK legislation is evolving — the skill instructs the model to verify key dates via web search before any formal deliverable, and to research live for jurisdictions beyond the EU/UK.
