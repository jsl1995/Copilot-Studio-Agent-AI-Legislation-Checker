# UK AI & Data Legislation Reference (as of early 2026)

Supporting reference for the `copilot-studio-ai-compliance` skill. Cite findings using the instrument + section and the official links below. Verify via web search before formal deliverables — UK AI legislation is evolving.

> **Important:** a UK-facing agent must ALSO be assessed against EU legislation — the EU AI Act (Art 2(1)(c)) and EU GDPR (Art 3(2)) apply extraterritorially where output is used in the EU or services are offered to EU data subjects. Load `eu-legislation.md` as well and report those items under "EU law applying extraterritorially".

## Official sources

| Instrument / guidance | Official link |
|---|---|
| UK GDPR (retained Regulation (EU) 2016/679) | https://www.legislation.gov.uk/eur/2016/679/contents |
| Data Protection Act 2018 | https://www.legislation.gov.uk/ukpga/2018/12/contents |
| Data (Use and Access) Act 2025 | https://www.legislation.gov.uk/ukpga/2025/18/contents |
| Equality Act 2010 | https://www.legislation.gov.uk/ukpga/2010/15/contents |
| Digital Markets, Competition and Consumers Act 2024 | https://www.legislation.gov.uk/ukpga/2024/13/contents |
| Consumer Rights Act 2015 | https://www.legislation.gov.uk/ukpga/2015/15/contents |
| Online Safety Act 2023 | https://www.legislation.gov.uk/ukpga/2023/50/contents |
| AI white paper "A pro-innovation approach to AI regulation" (2023) | https://www.gov.uk/government/publications/ai-regulation-a-pro-innovation-approach |
| ICO — Guidance on AI and data protection | https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/artificial-intelligence/guidance-on-ai-and-data-protection/ |
| ICO — Explaining decisions made with AI | https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/artificial-intelligence/explaining-decisions-made-with-artificial-intelligence/ |

Section-level links on legislation.gov.uk follow the pattern `https://www.legislation.gov.uk/ukpga/2010/15/section/20` — cite the specific section in findings (e.g. `Equality Act 2010, s.20 (reasonable adjustments)`).

## 1. UK AI regulatory framework

No single AI act. The 2023 white paper sets **five cross-sector principles** applied by existing regulators (ICO, FCA, CMA, Ofcom, EHRC, MHRA…):

1. Safety, security and robustness
2. Appropriate transparency and explainability
3. Fairness
4. Accountability and governance
5. Contestability and redress

Watch for: any UK AI bill progressing after early 2026 (verify before formal deliverables).

## 2. UK GDPR + Data Protection Act 2018

Same core structure as EU GDPR. Key AI-specific points:

- **Automated decision-making (UK GDPR Art 22, as amended by the Data (Use and Access) Act 2025)**: UK rules were relaxed — solely automated decisions with significant effects are permitted (outside special-category data) **provided safeguards exist**: informing the individual, right to human intervention, right to make representations and contest. Special-category data still needs explicit consent or a substantial-public-interest basis.
- **ICO guidance**: "Guidance on AI and data protection", "Explaining decisions made with AI" (with the Alan Turing Institute), and the ICO's position on generative AI. A DPIA is expected for most AI systems processing personal data.

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
| DPIA (Art 35; DPA 2018 s.64 for law-enforcement processing) | Likely required — organisational |
| Data subject rights (Arts 15–22) | Agent routes "delete/see my data" requests correctly |
| Processors (Art 28) | Microsoft DPA, environment data residency — organisational |
| Special category data (Art 9; DPA 2018 Sch 1) | Any collected or likely volunteered? Handling rules present? |

## 3. Other UK statutes relevant to a customer-facing agent

- **Equality Act 2010** — anticipatory reasonable-adjustments duty (ss.20–21, s.29 for services); accessibility of the chat interface and adaptive cards; no indirectly discriminatory gating rules (s.19).
- **Digital Markets, Competition and Consumers Act 2024** — unfair commercial practices regime (Part 4, Ch 1; replaced the CPRs 2008): a bot must not mislead about being human, about capabilities, or about material booking/contract information.
- **Consumer Rights Act 2015** — pre-contract information where the agent forms contracts/bookings (Part 1, Ch 2).
- **Online Safety Act 2023** — only if the agent is part of a user-to-user or search service (rare for enterprise bots).
