# Copilot Studio Agent — AI Legislation Checker

An agent skill that assesses a **Microsoft Copilot Studio agent** for compliance with AI legislation. Point it at an unpacked agent (the local YAML produced by cloning an agent) and it produces a severity-ranked compliance report as a self-contained HTML dashboard.

Unlike checklist tools, it establishes **jurisdiction and legal applicability before scoring** — so it doesn't report regulatory guidance as statutory breaches, and it separates what the YAML proves from what needs tenant or organisational evidence.

![AI compliance assessment report — Fluent UI dashboard with severity tiles and tabbed sections](assets/report-screenshot.png)

**[▶ View a full sample report](https://htmlpreview.github.io/?https://github.com/jsl1995/Copilot-Studio-Agent-AI-Legislation-Checker/blob/main/examples/sample-report.html)** (fictional agent) or open [`examples/sample-report.html`](examples/sample-report.html) locally.

## Quick start

1. Install the skill (Claude Code, personal scope):

   ```powershell
   git clone https://github.com/jsl1995/Copilot-Studio-Agent-AI-Legislation-Checker "$env:USERPROFILE\.claude\skills\copilot-studio-ai-compliance"
   ```

   ```bash
   git clone https://github.com/jsl1995/Copilot-Studio-Agent-AI-Legislation-Checker ~/.claude/skills/copilot-studio-ai-compliance
   ```

2. Open Claude Code in the folder containing your **unpacked agent** (see [cloning your agent](#prerequisite-clone-your-agent-locally) if you don't have one yet).
3. Run:

   ```
   /copilot-studio-ai-compliance
   ```

4. Answer the jurisdiction questions (where the organisation is established, which users are targeted, where output is used, whether access is geo-restricted), then review the report saved as `ai-compliance-report.html`.

> ⚠️ **Disclaimer:** this produces a technical compliance assessment, not legal advice. Findings should be validated by qualified legal counsel and your DPO before being relied upon.

## Compatibility

| Host | Status |
|---|---|
| Claude Code (CLI / VS Code / desktop) | Tested — primary target |
| GitHub Copilot agent mode (VS Code, CLI, cloud agent) | Format-compatible via [Agent Skills](#running-the-skill-in-github-copilot) |

Requirements: an unpacked Copilot Studio agent on disk; web search available in the host for verifying current law and for jurisdictions beyond the EU/UK; PowerShell only if you want to run the repo's validation script.

## What it does

1. **Establishes jurisdiction from operational facts** — where the organisation is established, which users are targeted, where output is used, and whether access is geographically restricted. EU AI Act and GDPR extraterritorial scope are tested separately rather than inferred from UK operation alone.
2. **Inventories source and external evidence** — `agent.mcs.yml`/`.yaml`, settings, topics, actions, triggers, workflows, knowledge files, variables and connections, plus available tenant/runtime controls such as transcripts, authentication, data policies, connector credentials, channels and retention. It labels YAML-only assessments as incomplete.
3. **Classifies the agent** under the EU AI Act (provider vs deployer role, prohibited / high-risk / limited / minimal tier) and the UK's five cross-sector AI principles.
4. **Applies requirement gates** across the EU AI Act, UK AI principles, EU/UK GDPR & DPA 2018, consumer and equality law, and platform controls. Each item records its basis type, applicability, effective status, and evidence status before it is scored.
5. **Outputs a self-contained Fluent UI-style HTML dashboard** with:
   - severity tiles in the order High, Medium, Low, followed by Advisory / future readiness and Evidence required
   - accessible tabs for Executive summary, Scope & evidence, Findings, Personal-data map, Remediation, and Coverage matrix
   - a basis type for every item: binding law, future obligation, regulatory guidance, or technical control
   - official-source links, a print-friendly layout, and a coverage-matrix audit trail that every in-scope requirement was checked
   - a Markdown fallback only when HTML generation is unavailable

## Scope and limitations

- **Built-in legal coverage is EU and UK**: EU AI Act, EU GDPR, UCPD, European Accessibility Act; UK AI principles, UK GDPR/DPA 2018, DUAA 2025, Equality Act 2010, DMCC. Other jurisdictions are **research-assisted** — the skill searches official sources live and labels those results "research-based — verify with local counsel".
- It assesses the **unpacked YAML source** plus whatever tenant/runtime evidence you provide. It does not connect to Copilot Studio, your tenant, or the Power Platform admin centre, and it cannot verify controls it cannot see — a YAML-only run is explicitly labelled as incomplete.
- It is **not a certification** and not a substitute for a DPIA, legal review, or your organisation's governance process.
- Legal references are time-sensitive; the skill verifies commencement and amendments against official sources before formal reports, which requires web access.

## Data handling

- The skill and this repo's scripts **do not upload or transmit anything**; the assessment runs entirely inside your AI client, which processes workspace content under its own data policy (check your Claude / GitHub Copilot enterprise settings).
- The assessment is **read-only**. YAML fixes or tenant changes are only proposed, and only applied with your explicit approval.
- Generated reports contain security- and privacy-relevant findings about your agent — **treat them as sensitive** and don't commit real assessments to public repos. The repo's `.gitignore` excludes `ai-compliance-report.*` and `reports/` by default.

## Repository structure

```
SKILL.md                        # the skill definition (Agent Skills format)
resources/
  eu-legislation.md             # EU AI Act, EU GDPR, UCPD, EAA — with EUR-Lex links
  uk-legislation.md             # UK AI principles, UK GDPR/DPA 2018, DUAA 2025, Equality Act, DMCC — with legislation.gov.uk/ICO links
  copilot-studio-controls.md    # Runtime evidence surfaces and Microsoft Learn links
assets/
  report-template.html          # Self-contained Fluent UI-style dashboard template
  report-screenshot.png         # Example report dashboard (shown above)
examples/
  sample-report.html            # Full sample report for a fictional agent
evals/
  cases.json                    # Regression scenarios for scope, applicability, severity and evidence
scripts/
  validate-skill.py             # Deterministic content-contract checks (Python 3, cross-platform)
  validate-skill.ps1            # Same checks for PowerShell environments (kept in sync)
```

## Prerequisite: clone your agent locally

The skill works on the **unpacked YAML source** of a Copilot Studio agent — a folder containing `agent.mcs.yml` or `agent.mcs.yaml` plus its component folders. Current clones from the VS Code extension look like this (extensions vary between `.mcs.yml` and `.mcs.yaml` — the skill accepts both, and older clones with a `variables/` folder are also supported):

```
MyAgent/
  agent.mcs.yaml                 # main agent definition
  settings.mcs.yml               # configuration settings
  connectionreferences.mcs.yml   # connection references
  topics/*.mcs.yaml              # conversation topics
  actions/*.mcs.yml              # connector actions
  trigger/*.mcs.yaml             # event triggers
  workflows/<name>/              # tools/workflows (metadata.yaml + workflow.json)
  knowledge/                     # knowledge sources
```

### Option A — Microsoft Copilot Studio extension for VS Code

1. Install the **Microsoft Copilot Studio** extension from the VS Code marketplace.
2. Sign in with an account that has access to the Power Platform environment hosting the agent.
3. Open the Copilot Studio pane, pick the environment, right-click the agent → **Clone agent**, and choose a local folder. (Or use the Command Palette: **Copilot Studio: Clone Agent**.)

### Option B — Claude Code with the Copilot Studio plugin

If you use the Copilot Studio plugin for Claude Code, run:

```
/copilot-studio:clone-agent
```

and follow the prompts (environment selection → agent selection → local folder).

## Running the skill in Claude Code

The [quick start](#quick-start) above installs to your personal skills folder (available in all projects). For a project-scoped install, clone into `<your-repo>/.claude/skills/copilot-studio-ai-compliance/` instead.

Verify the install by typing `/` in Claude Code — `copilot-studio-ai-compliance` should appear in the skill list. Then invoke it from your unpacked-agent folder, or just ask naturally: *"Run an AI compliance review of this agent."*

To update later, `git pull` in the skills folder. To uninstall, delete the folder.

## Running the skill in GitHub Copilot

GitHub Copilot supports the Agent Skills format in VS Code agent mode, Copilot CLI, the Copilot cloud agent, and code review. Install the complete skill folder (it needs `SKILL.md`, `resources/`, **and** `assets/` — the HTML template is required for the primary report output) into one of the supported locations:

- **Project:** `<your-repo>/.github/skills/copilot-studio-ai-compliance/`
- **Personal:** `~/.copilot/skills/copilot-studio-ai-compliance/`

```bash
git clone https://github.com/jsl1995/Copilot-Studio-Agent-AI-Legislation-Checker ~/.copilot/skills/copilot-studio-ai-compliance
```

Then, in Copilot Chat (agent mode) with your unpacked agent open, ask: *"Assess this agent for AI legislation compliance using the copilot-studio-ai-compliance skill."*

Notes for Copilot users:

- The skill's interactive region question becomes a plain chat question — answer it in the conversation.
- For regions other than UK/EU the skill relies on web research; enable Copilot's web search tool or supply the relevant legislation yourself.

## How findings are calibrated

The skill's core design goal is avoiding false positives: the same observation lands at a different severity depending on jurisdiction, dates, role, and audience. Examples of what a report actually contains:

| Example finding | How it's rated |
|---|---|
| No AI disclosure in an EU-facing chatbot | **High/Medium** binding-law finding only once EU AI Act Art. 50(1) is in force, applies territorially, and the AI nature isn't obvious to users; before commencement it's an **Advisory / future readiness** item |
| Anonymous public agent invoking a privileged Dataverse action with maker credentials | **High** technical security finding — conversation authentication and connector authorization are assessed separately |
| No privacy notice found in the YAML | **Evidence required** — the host page and channel experience must be checked before it can become a GDPR transparency finding |
| Automated rejection of a request with no human review | A binding automated-decision finding only when the decision is solely automated and legally significant; otherwise a guidance-level concern |

Every finding cites its legal basis with an official-source link, the applicability test that was met, and the evidence (file and line where possible).

## Keeping it current

The reference files were updated in **August 2026** and reflect the 2026 Digital Omnibus on AI (Article 50 transparency in force from 2 August 2026; standalone Annex III high-risk obligations deferred to 2 December 2027, Annex I embedded to 2 August 2028) and the DUAA 2025 commencement position. EU AI Act obligations continue phasing in through 2028 and UK legislation and guidance continue to evolve. The skill requires current official-source verification of territorial scope, commencement and amendments before formal deliverables, and live research for jurisdictions beyond the EU/UK.

If you change any skill file, run the content-contract validator with whichever runtime you have — `python3 scripts/validate-skill.py` or `.\scripts\validate-skill.ps1`. When changing jurisdiction, applicability, severity, or evidence rules, also regression-test against the scenarios in `evals/cases.json`: run the skill against each scenario (or reason through it) and check the output meets every `expected` item and none of the `must_not` items — these are judgement-based checks, not automated ones.

## License

[MIT](LICENSE) — free to use, modify, and redistribute, including commercially. Attribution appreciated.
