---
name: copilot-studio-ai-compliance
description: Use when asked to assess an unpacked Microsoft Copilot Studio agent (agent.mcs.yml/.yaml clone) for AI-legislation, EU AI Act, GDPR/UK GDPR, consumer, or equality compliance, for example "AI compliance review", "EU AI Act check", "is this agent compliant", "AI legislation assessment", or "regulatory review of this agent/copilot". Not for editing agent YAML (use the copilot-studio plugin skills) or scoring instruction quality (use copilot-studio-instruction-audit).
license: MIT (see LICENSE)
---

# Copilot Studio AI Legislation Compliance Assessor

Assess Microsoft Copilot Studio agents as an AI governance specialist. Ground every conclusion in evidence, state the legal applicability test, and do not convert guidance or technical recommendations into statutory breaches.

> **Always include this disclaimer:** This is a technical compliance assessment, not legal advice. Findings should be validated by qualified legal counsel and the organisation's DPO before being relied upon.

## Step 0 - Locate the agent and define the evidence boundary

Find the unpacked agent root containing `agent.mcs.yml` **or** `agent.mcs.yaml`. If several candidates exist, ask the user which one to assess. If neither file can be found, do not guess or assess unrelated YAML: ask the user for the path to the unpacked agent, or explain how to clone one locally first (Copilot Studio VS Code extension, or the Copilot Studio plugin's clone command).

Clone layouts vary by extension version and mix extensions within one clone (for example `agent.mcs.yaml` beside `settings.mcs.yml`, and `topics/*.mcs.yaml` beside `actions/*.mcs.yml`). Treat `.mcs.yml` and `.mcs.yaml` as equivalent everywhere, inventory every folder actually present, and note unrecognized files in the report rather than skipping them.

Inventory the source evidence:

| File(s) | Signals to extract |
|---|---|
| `agent.mcs.yml` / `agent.mcs.yaml` | Purpose, persona, instructions, PII handling, escalation, injection resilience, grounding, fallback rules, model capabilities |
| `settings.mcs.yml` / `settings.mcs.yaml` | Authentication, access policy, moderation, model knowledge, file analysis, generative actions, connectability, language |
| `topics/*.mcs.yml` / `*.mcs.yaml` | Disclosure, data collection, automated decisions, escalation, errors, confirmation and consent steps |
| `actions/*.mcs.yml` / `*.mcs.yaml` | External destinations, data written or retrieved, filters, action authorization, connector use |
| `workflows/*/metadata.yaml`, `workflows/*/workflow.json` | Tool and workflow definitions, external destinations, data written or retrieved, autonomous invocation |
| `trigger/*.mcs.yml` / `*.mcs.yaml` | Event triggers and non-conversational invocation paths |
| `variables/*.mcs.yml` / `*.mcs.yaml` (older layouts) | Declared and persisted data fields |
| `connectionreferences.mcs.yml` / `.yaml`, `.mcs/conn.json` | Connector footprint and declared data-flow destinations |
| `knowledge/` files (for example `knowledge/files/*.yaml`, `knowledge/*.knowledge.mcs.yml`, and `knowledge/*.topic.*.mcs.yml` files whose `kind` is `KnowledgeSourceConfiguration`) | Grounding scope, source sensitivity, copyright and access implications; duplicate or unlisted sources compared with the instructions |
| `.mcs/botdefinition.json` | Component inventory and state (active or inactive), publish metadata |

A missing folder from one layout generation (for example no `variables/` in a current clone, or no `workflows/` in an older one) is a layout difference, not an evidence gap.

Request or identify tenant/runtime evidence when available:

- Conversation-transcript saving, access, download, and retention settings
- Published channels, authentication configuration, and host-page controls
- Environment and environment-group data policies
- Maker-provided versus end-user connector credentials
- Security roles, connection permissions, and least-privilege configuration
- Environment region, data residency, and cross-border transfer information
- Privacy notice, retention schedule, DPIA, lawful-basis record, incident process, and DSR process

Read `resources/copilot-studio-controls.md` for the platform evidence surfaces and official Microsoft documentation.

Build a personal-data map covering both structured fields and free-form conversation content. Include user messages, generated replies, transcripts, telemetry or metadata, action payloads, knowledge retrieval content, and exported analytics where evidence supports them.

Separate conclusions into three evidence layers:

1. **Source-observable** - established from the unpacked files.
2. **Tenant/runtime evidence required** - depends on environment, channel, policy, credential, transcript, or hosting configuration.
3. **Organisational evidence required** - depends on governance documents or operational processes.

If only unpacked YAML is available, label the report **"YAML-only assessment - tenant/runtime and organisational controls not verified"**. Never describe that evidence boundary as a complete compliance determination.

## Step 1 - Establish jurisdiction and effective law

Use the runtime's structured user-input tool when one is available; otherwise ask concise questions in chat. Establish these facts rather than inferring them from a single region label:

1. Where is the operating organisation established?
2. Which countries are users located in or intentionally targeted from?
3. Where will the agent's output be used?
4. Is access technically or contractually restricted by geography?

Load references according to the answers:

- **EU in scope** - read `resources/eu-legislation.md` when the operator/deployer is in the EU, the system is placed on the EU market, output is used in the EU, or EU data subjects are offered services or monitored under the relevant instrument's test.
- **UK in scope** - read `resources/uk-legislation.md` when the operator or intended service is in the UK.
- **UK only on established facts** - do not state that EU law applies merely because a UK service could technically be reached from the EU. Record EU exposure as conditional when EU use or targeting is plausible but unverified.
- **Other jurisdictions** - research current AI-specific, data-protection, consumer, and sectoral law using official sources. Mark the result **"research-based - verify with local counsel"**.

Apply the EU AI Act and EU GDPR territorial tests separately. The AI Act Article 2 and GDPR Article 3 are not interchangeable.

Before a formal or client-facing report, verify from official sources:

- the current date and commencement status of each relied-upon duty;
- amendments, commencement regulations, and transitional provisions;
- whether the cited rule is binding law, regulator guidance, a future obligation, or a technical control.

Use stored references as a starting point, not as proof that a time-sensitive rule is current.

## Step 2 - Determine role, use case, and risk classification

### EU AI Act role

Determine role from the facts. An organisation using Copilot Studio is commonly a deployer, while Microsoft supplies underlying platform and model capabilities. Also test whether the organisation develops or has an AI system developed and places it on the market or puts it into service under its own name, substantially modifies a high-risk system, or changes its intended purpose. State uncertainties instead of assuming that every Copilot Studio customer has the same role.

### EU AI Act risk and obligation gates

Walk the following gates in order and cite evidence:

1. **Prohibited practice (Article 5)** - identify manipulative practices, exploitation of vulnerability, social scoring, prohibited biometric uses, or other applicable categories. If a credible signal exists, report a High red flag and require legal review.
2. **High-risk (Article 6 and Annex I/III)** - determine whether the system makes or materially influences a listed decision. Apply exclusions and document the reasoning.
3. **Transparency (Article 50)** - test the specific paragraph, responsible role, effective date, and the Article 50(1) exception where interaction with AI is obvious to a reasonably well-informed, observant, and circumspect person.
4. **Other/minimal risk** - state which mandatory duties remain and which controls are advisory good practice.

Do not apply Article 26 high-risk deployer duties as mandatory requirements to a non-high-risk agent.

### UK framing

Assess the five cross-sector AI principles as non-statutory regulatory guidance unless current binding law or sector-specific rules impose the same control. Identify the regulator and legal provision that would make a finding enforceable; otherwise label it guidance or good practice.

## Step 3 - Apply applicability gates and assess requirements

For every requirement, record:

- **Basis type:** Binding law / Future obligation / Regulatory guidance / Technical control
- **Applicability:** why the rule applies, does not apply, or depends on facts not yet established
- **Effective status:** in force / future dated / transitional / unverified
- **Evidence status:** Met / Shortfall / N/A / Conditional / Tenant-runtime evidence required / Organisational evidence required

Use **Conditional** when the requirement's territorial, role, or date test depends on facts that are not established. The row names the test and the missing facts and is not rated. If a finding is raised about a Conditional row, the finding's Applicability field states the condition and the row links to the finding.

Never rate a requirement as Met without evidence. Never turn missing external evidence into a confirmed source-code defect.

**Evidence-required rows:** the report contains one evidence-required row per coverage requirement (A1-F6) whose evidence status is Tenant-runtime or Organisational evidence required. Each row gives the requirement ID, every piece of evidence needed for that requirement, and the owner. Open Step 1 facts and Conditional rows are listed in Scope & evidence under their own headings and are not evidence-required rows.

### A - EU AI Act (assess when its territorial test is met; Conditional when it depends on unestablished facts; N/A when it is not met)

- A1. Article 5 prohibited practices - in force; assess relevant categories
- A2. Article 6 and Annex I/III risk classification - document use-case facts, exclusions, and effective dates
- A3. Article 50(1) interaction disclosure - check responsible role, effective date, and the "obvious" exception
- A4. Article 50 synthetic or public-interest content duties - assess only for relevant content and role
- A5. Article 26 deployer duties - mandatory only when the system is high-risk; otherwise identify chosen controls as good practice
- A6. Article 4 AI literacy - organisational evidence

### B - UK AI principles and sector guidance

- B1. Safety, security, and robustness
- B2. Appropriate transparency and explainability
- B3. Fairness
- B4. Accountability and governance
- B5. Contestability and redress

Label these as non-statutory unless tied to an applicable binding provision enforced by the relevant regulator.

### C - Data protection

Apply EU GDPR, UK GDPR/DPA 2018, or both only after territorial scope is established.

- C1. Lawful basis for each purpose - organisational evidence
- C2. Data minimisation across structured fields, free-text messages, transcripts, and action payloads
- C3. Transparency information at or before collection; check the agent, host page, and channel experience
- C4. Solely automated significant decisions; distinguish ordinary routing or inconvenience from legal or similarly significant effects
- C5. DPIA - apply the statutory "likely high risk" test and current regulator criteria; do not presume every AI system requires one
- C6. Retention and deletion across business records, transcripts, telemetry, and exports
- C7. Special-category or highly sensitive data handling
- C8. Risk-appropriate security under Article 32; do not treat authentication as the only control
- C9. Processor/sub-processor, residency, and transfer evidence
- C10. Data-subject-rights routing and operational fulfilment

### D - Consumer and equality law

Determine whether the service, transaction, user group, territorial scope, and statutory exemptions bring each instrument into scope before scoring:

- D1. Misleading identity, capability, or material information
- D2. Pre-contract information where the agent forms or facilitates a relevant transaction
- D3. Accessibility and non-discrimination for the applicable service and audience

### E - Platform technical controls

Treat these as technical controls unless an identified legal duty requires the specific measure:

- E1. Moderation appropriate to audience and use case
- E2. Model knowledge consistent with grounding and accuracy claims
- E3. Autonomous generative actions governed by instructions and authorization
- E4. Browsing, code execution, and file analysis justified and constrained
- E5. Connections, actions, queries, and credentials follow least privilege
- E6. Authentication appropriate to data sensitivity, user population, and action authorization

### F - Tenant/runtime controls

- F1. Transcript saving, access, download, retention, and deletion
- F2. Published channels, geographical restrictions, and host-page notices
- F3. Environment/group data policies and connector governance
- F4. Maker-provided versus end-user credentials
- F5. Security roles and administrative access
- F6. Environment region, residency, transfers, logging, and incident evidence

## Step 4 - Rate and report findings

Rate severity only after determining basis type, applicability, effective status, impact, and evidence confidence:

- **High** - strong evidence of a likely breach of binding law currently in force, a prohibited-practice signal, exposure of restricted data/actions, or another condition that blocks safe go-live.
- **Medium** - a material partial control, unresolved applicability with credible exposure, or a security/governance weakness requiring remediation.
- **Low** - a limited-impact improvement with low immediate exposure.
- **Advisory / future readiness** - non-statutory guidance, good practice, or a duty not yet in force. Do not call this a breach.
- **Evidence required** - tenant/runtime or organisational evidence is unavailable. Do not severity-rate the absence unless the organisation confirms the control is missing.

Examples are context-dependent, not fixed severities:

- Missing AI disclosure may be a future-readiness item, a current Article 50 shortfall, or N/A under the obvious-interaction exception depending on date and facts.
- Anonymous access can be appropriate for a public FAQ or high risk when restricted data or privileged actions are exposed.
- Missing human review matters under automated-decision rules only when the decision is solely automated and legally or similarly significant; it can still be a guidance-based usability concern otherwise.
- A privacy notice absent from YAML is an evidence request until the host page and channel experience are checked.

Use this finding format:

```markdown
### <ID> - <High/Medium/Low/Advisory> - <Title>
- **Basis type:** <Binding law / Future obligation / Regulatory guidance / Technical control>
- **Basis:** <instrument and article/section, official guidance, or named technical standard>
- **Official links:** <official source for each basis: EUR-Lex, legislation.gov.uk, regulator guidance, or Microsoft Learn>
- **Applicability:** <facts and test establishing why it applies, or the condition it depends on>
- **Effective status:** <in force / future dated / transitional / verified on date>
- **Evidence:** <file:line for present evidence; for an absence, list files and search/control checked; for external controls, state evidence required>
- **Remediation:** <concrete and proportionate fix>
- **Owner:** <YAML / Tenant administrator / Security / Privacy / Legal / Operations>
```

For absent controls, do not manufacture a line citation. Record the files or configuration surfaces inspected, the expected signal, and that no match was found.

## Report output

HTML is the primary report deliverable. Read and reuse `assets/report-template.html` as the structural and visual baseline. Offer to save the completed report as `ai-compliance-report.html` in the agent folder. The HTML must be self-contained: do not depend on a CDN, JavaScript framework, remote font, or external runtime to render the report.

### Fluent UI dashboard contract

Build the first viewport as a quiet, information-dense Fluent UI-style dashboard:

- Use Segoe UI or a system sans-serif stack, Fluent UI neutral tokens, restrained blue accent tokens, 4-8px radii, clear borders, and accessible contrast. Do not use gradients, decorative blobs, or marketing-style hero content.
- Show the agent name, assessment date, evidence boundary, jurisdiction status, regimes, and disclaimer in a compact header.
- Show severity tiles in this exact order: **High**, **Medium**, **Low**. Follow them with **Advisory / future readiness** and **Evidence required** tiles. Each tile must show a count and activate its corresponding tab; severity tiles must filter the Findings view and the Evidence required tile must open Scope & evidence.
- Add an accessible tab strip using `role="tablist"`, `role="tab"`, `aria-selected`, `aria-controls`, and `role="tabpanel"`. Include tabs for **Executive summary**, **Scope & evidence**, **Findings**, **Personal-data map**, **Remediation**, and **Coverage matrix**.
- Keep one active tab visible at a time, support mouse and keyboard activation, and preserve the selected tab in the URL hash when practical. Do not hide important findings solely behind hover states.
- Render each finding as a semantic `article` or card with its ID, severity, basis type, applicability, effective status, evidence, remediation, owner, and official links. Use text labels in addition to colour.
- Keep the coverage matrix searchable or horizontally scrollable on small screens. Ensure tables, cards, tab labels, and long evidence paths wrap without clipping.
- Include a print-friendly layout and a visible note when the report is YAML-only or has unverified tenant/runtime evidence.
- The High, Medium, Low, and Advisory / future readiness tiles count finding cards of that severity. The **Evidence required** tile counts the evidence-required rows listed in Scope & evidence (one per coverage requirement, as defined in Step 3); those items are not finding cards. Verify both sets of counts and that every in-scope coverage row is represented. Do not invent charts or scores unsupported by the evidence.

Use the template's placeholders as data slots, not as literal report content. Escape user-controlled agent names, evidence text and URLs before inserting them into HTML. If the runtime cannot create or save HTML, provide the Markdown structure below as a fallback and state that HTML generation was unavailable. Markdown is not the primary output when HTML generation is possible.

### HTML data contract

The generated file must contain:

1. A summary header and the required severity tiles.
2. One tab panel for every section listed above.
3. A findings data set whose counts drive the tiles, with no severity inferred from colour alone.
4. The standard disclaimer in the header or executive-summary panel.
5. Official source links near each legal or guidance basis.
6. A coverage matrix containing every A-F requirement, including N/A, Conditional, and evidence-required rows.

## Markdown fallback structure

Offer to save the fallback as `ai-compliance-report.md` only when HTML cannot be produced, or as a companion file when the user requests both.

```markdown
# AI Compliance Assessment - <Agent Name>
**Assessed:** <date> | **Evidence boundary:** <scope> | **Jurisdictions:** <facts>
**Regimes assessed:** <list with effective status>
**Disclaimer:** <standard disclaimer>

## 1. Executive summary
<risk classification, evidence limitations, counts by severity and advisory/evidence status>

## 2. Scope, assumptions, and evidence limitations
<territorial facts, files inspected, tenant/runtime evidence received or missing>

## 3. Agent profile and personal-data map
<include free text, transcripts, metadata, actions, destinations, retention evidence>

## 4. Role, risk, and applicability classification
<role evidence, risk tier, territorial tests, commencement dates>

## 5. Findings
<binding-law findings first, then technical risks, advisory/future readiness, and evidence requests>

## 6. Remediation plan
<separate YAML, tenant/admin, security, privacy/legal, and operational actions>

## 7. Controls working as intended
<genuine strengths with evidence>

## Appendix - Coverage matrix
| Ref | Requirement | Basis type | Applicability | Effective status | Evidence status | Finding/evidence |
```

After presenting the report, offer to implement YAML-level fixes only when appropriate authoring tools are available. Confirm tool availability and request approval before any tenant or production change.
