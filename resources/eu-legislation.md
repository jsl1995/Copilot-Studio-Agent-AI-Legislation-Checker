# EU AI & Data Legislation Reference (updated July 2026)

Supporting reference for the `copilot-studio-ai-compliance` skill. Cite findings using the instrument and article with the official links below. Verify territorial scope, current consolidated text, and commencement before formal deliverables.

## Official sources

| Instrument | Official link |
|---|---|
| EU AI Act — Regulation (EU) 2024/1689 | https://eur-lex.europa.eu/eli/reg/2024/1689/oj |
| EU GDPR — Regulation (EU) 2016/679 | https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32016R0679 |
| Unfair Commercial Practices Directive 2005/29/EC | https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32005L0029 |
| European Accessibility Act — Directive (EU) 2019/882 | https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32019L0882 |
| AI Act Explorer (unofficial, article-level navigation) | https://artificialintelligenceact.eu/the-act/ |

When citing an AI Act article in a finding, link the EUR-Lex page and name the article (EUR-Lex HTML anchors follow the pattern `#art_50`), e.g. `EU AI Act, Art 50(1) — [Regulation (EU) 2024/1689](https://eur-lex.europa.eu/eli/reg/2024/1689/oj)`.

## 1. EU AI Act — Regulation (EU) 2024/1689

Entered into force 1 August 2024. Phased application:

| Date | What applies |
|---|---|
| 2 Feb 2025 | Prohibited practices (Art 5); AI literacy (Art 4) |
| 2 Aug 2025 | GPAI model obligations; governance; penalties |
| 2 Aug 2026 | Most remaining obligations incl. Art 50 transparency and Annex III high-risk |
| 2 Aug 2027 | High-risk AI embedded in regulated products (Annex I) |

### Territorial scope (Art 2) — extraterritorial reach
The Act applies to the actors listed in Article 2. Article 2(1)(c) includes providers and deployers established in a third country where output produced by the AI system is used in the EU. Establish actual or intended EU use from deployment, users, contracts, channels, and operational facts. Technical reachability from the EU alone does not prove that output is used there; record uncertain exposure as conditional rather than declaring the Act applicable.

### Roles (Art 3)
- **Provider** — develops an AI system or GPAI model, or has one developed, and places it on the market or puts it into service under its own name or trademark.
- **Deployer** — uses an AI system under its authority in a professional context. An organisation configuring Copilot Studio is commonly a deployer, but role classification depends on how the resulting system is developed, branded, supplied, modified, and put into service. Apply Article 25 separately where a high-risk system is involved.

### Art 5 — Prohibited practices (check-list)
Subliminal or purposefully manipulative techniques causing significant harm; exploiting vulnerabilities (age, disability, social/economic situation); social scoring; predictive policing based solely on profiling; untargeted facial-image scraping; emotion recognition in workplace/education; biometric categorisation inferring sensitive attributes; real-time remote biometric ID in public spaces (law enforcement, narrow exceptions).

### Art 6 + Annex III — High-risk areas (summary)
Biometrics; critical infrastructure; education & vocational training; **employment/worker management**; access to essential private & public services (incl. credit scoring, insurance pricing, emergency dispatch); law enforcement; migration/border; justice & democratic processes. A system is high-risk if it is a safety component of these or makes/materially influences such decisions. Art 6(3) carve-out: narrow procedural tasks, improving prior human activity, etc. — must be documented.

### Art 50 — Transparency (generally applies from 2 August 2026)
- 50(1): providers must ensure that systems intended to interact directly with natural persons inform them that they are interacting with AI, unless this is obvious to a reasonably well-informed, observant, and circumspect person in the circumstances. Check the responsible role, effective date, complete user experience, and the exception rather than treating an exact greeting phrase as the statutory test.
- 50(2): synthetic audio/image/video/text content must be marked machine-readably (provider duty).
- 50(4): deployers of deep fakes / AI text published to inform the public must disclose.

### Art 26 — Deployer obligations for high-risk AI systems
Article 26 duties apply to deployers of high-risk AI systems. They include use according to instructions, competent human oversight, relevant and sufficiently representative input data where controlled by the deployer, monitoring, logs, notices, and incident cooperation. For non-high-risk agents, similar controls may be useful good practice but must not be described as mandatory Article 26 duties.

### Art 4 — AI literacy
Providers and deployers must ensure sufficient AI literacy of staff operating AI systems. Organisational evidence: training records, usage guidance.

### Penalties (Art 99)
Up to €35m / 7% global turnover (prohibited practices); €15m / 3% (most other obligations).

## 2. EU GDPR — Regulation (EU) 2016/679

### Territorial scope (Art 3) — extraterritorial reach
Applies to controllers/processors outside the EU when **offering goods or services to data subjects in the EU** or **monitoring their behaviour** (Art 3(2)). A UK organisation whose agent serves EU customers is in scope.

### Essentials for a data-collecting agent

| Requirement (article) | What to look for in a Copilot Studio agent |
|---|---|
| Lawful basis (Art 6) | Documented per purpose — organisational evidence |
| Transparency (Arts 12–14) | Privacy notice linked/offered at point of collection (greeting or first data ask) |
| Data minimisation (Art 5(1)(c)) | Variables/topics capture only what the stated purpose needs; instructions refuse volunteered excess PII |
| Purpose limitation (Art 5(1)(b)) | Data written only to systems serving the stated purpose (check actions) |
| Accuracy (Art 5(1)(d)) | Validation/lookup before storing; confirmation summary before submit |
| Storage limitation (Art 5(1)(e)) | Retention schedule — organisational evidence |
| Security (Art 32) | Authentication mode, access control, channel security, connector scope |
| Automated decision-making (Art 22) | Solely automated decisions with legal/similarly significant effect require a basis + safeguards: disclosure, human intervention, right to contest |
| DPIA (Art 35) | Apply the "likely to result in a high risk" test, regulator lists, and relevant criteria. Innovative technology is a risk indicator, not a universal trigger by itself — organisational evidence |
| Data subject rights (Arts 15–22) | Agent can route "delete/see my data" requests correctly |
| Processors (Art 28) | Microsoft DPA, environment data residency — organisational |
| Special category data (Art 9) | Any collected or likely volunteered? Handling rules present? |

## 3. Consumer & accessibility law

- **Unfair Commercial Practices Directive 2005/29/EC** — a bot must not mislead about being human, about capabilities, or about material transaction information (Arts 6–7, misleading actions/omissions).
- **European Accessibility Act — Directive (EU) 2019/882** — applies to listed products and services, including specified electronic communications, consumer banking, transport-related elements, e-books and e-commerce services, subject to territorial, service, and exemption tests. Do not apply it to every consumer-facing chatbot without first establishing that the underlying service is in scope.
