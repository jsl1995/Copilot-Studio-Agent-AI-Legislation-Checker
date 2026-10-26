# UK AI & Data Legislation Reference (updated August 2026)

Supporting reference for the `copilot-studio-ai-compliance` skill. Cite findings using the instrument and section with the official links below. Verify current law, commencement, and regulator guidance before formal deliverables.

> **EU exposure is conditional:** load `eu-legislation.md` when facts indicate that output is used in the EU or the organisation offers goods or services to, or monitors, EU data subjects. Do not infer EU applicability solely from UK operation or technical reachability. Apply the EU AI Act and EU GDPR territorial tests separately.

## Official sources

| Instrument / guidance | Official link |
|---|---|
| UK GDPR (retained Regulation (EU) 2016/679) | https://www.legislation.gov.uk/eur/2016/679/contents |
| Data Protection Act 2018 | https://www.legislation.gov.uk/ukpga/2018/12/contents |
| Data (Use and Access) Act 2025 | https://www.legislation.gov.uk/ukpga/2025/18/contents |
| DUAA 2025 (Commencement No. 6) Regulations 2026 — SI 2026/82 | https://www.legislation.gov.uk/uksi/2026/82/contents/made |
| Equality Act 2010 | https://www.legislation.gov.uk/ukpga/2010/15/contents |
| Digital Markets, Competition and Consumers Act 2024 | https://www.legislation.gov.uk/ukpga/2024/13/contents |
| Consumer Rights Act 2015 | https://www.legislation.gov.uk/ukpga/2015/15/contents |
| Online Safety Act 2023 | https://www.legislation.gov.uk/ukpga/2023/50/contents |
| AI white paper "A pro-innovation approach to AI regulation" (2023) | https://www.gov.uk/government/publications/ai-regulation-a-pro-innovation-approach |
| ICO — Guidance on AI and data protection | https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/artificial-intelligence/guidance-on-ai-and-data-protection/ |
| ICO — Explaining decisions made with AI | https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/artificial-intelligence/explaining-decisions-made-with-artificial-intelligence/ |

Section-level links on legislation.gov.uk follow the pattern `https://www.legislation.gov.uk/ukpga/2010/15/section/20` — cite the specific section in findings (e.g. `Equality Act 2010, s.20 (reasonable adjustments)`).

## 1. UK AI regulatory framework

No single cross-sector AI act is in force. The 2023 white paper sets five cross-sector principles for existing regulators (ICO, FCA, CMA, Ofcom, EHRC, MHRA and others) to interpret within their remits:

1. Safety, security and robustness
2. Appropriate transparency and explainability
3. Fairness
4. Accountability and governance
5. Contestability and redress

The principles are non-statutory and context-specific. Do not cite a principle alone as proof of a legal breach. Identify the binding law, sector rule, or regulator power that applies; otherwise label the finding regulatory guidance or good practice.

As of August 2026 there is still no cross-sector UK AI act, and none is currently expected imminently. Relevant developments to check when assessing:

- The King's Speech 2026 announced a **Regulating for Growth Bill** putting regulatory sandboxes on a statutory footing (verify its progress and whether it affects the assessed sector).
- The **Crime and Policing Act 2026** (Royal Assent 29 April 2026) contains AI- and online-safety-related provisions — check relevance for public-facing agents.
- In January 2026 the government asked major regulators to publish plans for enabling safe AI innovation — check the relevant sector regulator's current AI guidance.
- A private member's Artificial Intelligence (Regulation) Bill remains before Parliament but is not law.

Verify any post-August 2026 legislation or regulator rules before formal deliverables.

## 2. UK GDPR + Data Protection Act 2018

Same core structure as EU GDPR. Key AI-specific points:

- **Automated decision-making (UK GDPR Articles 22A–22D, inserted by section 80 of the Data (Use and Access) Act 2025)**: section 80 commenced on 5 February 2026 via the Commencement No. 6 Regulations ([SI 2026/82](https://www.legislation.gov.uk/uksi/2026/82/contents/made)), which brought the principal DUAA data-protection provisions into force; further provisions commenced 19 June 2026 and some ICO governance provisions follow later. Articles 22A–22D replace the former Article 22 prohibition with a permission-plus-safeguards model: significant decisions based solely on automated processing require safeguards including information, representations, human intervention, and contestability, with stricter rules where special-category data is used. Verify the current consolidated text and any regulations made under the new powers.
- **ICO guidance**: use "Guidance on AI and data protection", "Explaining decisions made with AI", and current DPIA guidance. A DPIA is required where processing is likely to result in high risk. Innovative technology generally requires a DPIA when combined with another relevant risk criterion or when the circumstances otherwise meet the statutory test.

### Essentials for a data-collecting agent

| Requirement (provision) | What to look for in a Copilot Studio agent |
|---|---|
| Lawful basis (UK GDPR Art 6) | Documented per purpose — organisational evidence |
| Transparency (UK GDPR Arts 12–14) | Privacy notice linked/offered at point of collection |
| Data minimisation (Art 5(1)(c)) | Variables/topics capture only what the purpose needs; instructions refuse volunteered excess PII |
| Purpose limitation (Art 5(1)(b)) | Data written only to systems serving the stated purpose |
| Accuracy (Art 5(1)(d)) | Validation/lookup before storing; confirmation summary before submit |
| Storage limitation (Art 5(1)(e)) | Retention schedule — organisational evidence |
| Security (Art 32) | Authentication mode, access control, channel security, connector scope |
| ADM (Art 22 as amended by DUAA 2025) | Auto accept/reject with significant effect → safeguards: disclosure, human route, contest route |
| DPIA (Art 35; DPA 2018 s.64 for law-enforcement processing) | Apply the likely-high-risk test and current ICO mandatory list; do not presume every AI system requires one — organisational |
| Data subject rights (Arts 15–22) | Agent routes "delete/see my data" requests correctly |
| Processors (Art 28) | Microsoft DPA, environment data residency — organisational |
| Representative (UK GDPR Art 27) | Controller or processor with no UK establishment and in scope under UK GDPR Art 3(2) must designate a UK representative, with the same occasional-processing and public-authority exemptions as the EU text. Assess separately from any EU representative — organisational evidence |
| Special category data (Art 9; DPA 2018 Sch 1) | Any collected or likely volunteered? Handling rules present? |

## 3. Other UK statutes relevant to a customer-facing agent

- **Equality Act 2010** — anticipatory reasonable-adjustments duty (ss.20–21, s.29 for services); accessibility of the chat interface and adaptive cards; no indirectly discriminatory gating rules (s.19).
- **Digital Markets, Competition and Consumers Act 2024** — unfair commercial practices regime (Part 4, Ch 1; replaced the CPRs 2008): assess whether the overall commercial practice is misleading about identity, capabilities, or material transaction information. The Act does not create a universal standalone chatbot-disclosure rule.
- **Consumer Rights Act 2015** — pre-contract information where the agent forms contracts/bookings (Part 1, Ch 2).
- **Online Safety Act 2023** — only if the agent is part of a user-to-user or search service (rare for enterprise bots).
