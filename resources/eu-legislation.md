# EU AI & Data Legislation Reference (as of early 2026)

Supporting reference for the `copilot-studio-ai-compliance` skill. Cite findings using the instrument + article and the official links below. Verify dates via web search before formal deliverables.

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
The Act applies not only to providers/deployers established in the EU but also to providers and deployers established in a **third country (e.g. the UK) where the output produced by the AI system is used in the EU** (Art 2(1)(c)). **Practical consequence: a UK-facing agent reachable by or serving EU users is in scope — never rule the AI Act out just because deployment is UK-only.**

### Roles (Art 3)
- **Provider** — develops an AI system / GPAI model and places it on the market under its own name.
- **Deployer** — uses an AI system under its authority in a professional context. *An organisation configuring a Copilot Studio agent is normally a deployer; it can become a provider if it puts its name/trademark on a high-risk system or substantially modifies one.*

### Art 5 — Prohibited practices (check-list)
Subliminal or purposefully manipulative techniques causing significant harm; exploiting vulnerabilities (age, disability, social/economic situation); social scoring; predictive policing based solely on profiling; untargeted facial-image scraping; emotion recognition in workplace/education; biometric categorisation inferring sensitive attributes; real-time remote biometric ID in public spaces (law enforcement, narrow exceptions).

### Art 6 + Annex III — High-risk areas (summary)
Biometrics; critical infrastructure; education & vocational training; **employment/worker management**; access to essential private & public services (incl. credit scoring, insurance pricing, emergency dispatch); law enforcement; migration/border; justice & democratic processes. A system is high-risk if it is a safety component of these or makes/materially influences such decisions. Art 6(3) carve-out: narrow procedural tasks, improving prior human activity, etc. — must be documented.

### Art 50 — Transparency (limited-risk; applies to chatbots)
- 50(1): people must be informed they are interacting with an AI system, unless obvious to a reasonably well-informed person. **Practical test: does the first agent message say it's an AI/virtual assistant?**
- 50(2): synthetic audio/image/video/text content must be marked machine-readably (provider duty).
- 50(4): deployers of deep fakes / AI text published to inform the public must disclose.

### Art 26 — Deployer obligations (relevant even for non-high-risk, as good practice; mandatory for high-risk)
Use per provider's instructions for use; assign human oversight to competent persons; ensure input data is relevant; monitor operation; keep logs; inform workers/affected persons where required; report serious incidents.

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
| DPIA (Art 35) | Innovative tech + systematic processing → likely required — organisational |
| Data subject rights (Arts 15–22) | Agent can route "delete/see my data" requests correctly |
| Processors (Art 28) | Microsoft DPA, environment data residency — organisational |
| Special category data (Art 9) | Any collected or likely volunteered? Handling rules present? |

## 3. Consumer & accessibility law

- **Unfair Commercial Practices Directive 2005/29/EC** — a bot must not mislead about being human, about capabilities, or about material transaction information (Arts 6–7, misleading actions/omissions).
- **European Accessibility Act — Directive (EU) 2019/882** — consumer-facing digital services (incl. e-commerce interfaces) must meet accessibility requirements from 28 June 2025; check adaptive-card-only flows have accessible alternatives.
