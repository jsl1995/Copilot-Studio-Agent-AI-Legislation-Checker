# Copilot Studio Runtime Controls Reference (updated July 2026)

Use this reference to identify controls that unpacked agent YAML cannot establish. Verify current Microsoft Learn documentation before a formal deliverable because Copilot Studio settings and source schemas change frequently.

## Official sources

| Control area | Official documentation |
|---|---|
| Transcript saving, access, download, and retention | https://learn.microsoft.com/microsoft-copilot-studio/admin-transcript-controls |
| End-user authentication | https://learn.microsoft.com/microsoft-copilot-studio/configuration-end-user-authentication |
| Agent data policies | https://learn.microsoft.com/microsoft-copilot-studio/admin-data-loss-prevention |
| Maker-provided connector credentials | https://learn.microsoft.com/microsoft-copilot-studio/configure-no-maker-authentication |
| Personal-data export | https://learn.microsoft.com/microsoft-copilot-studio/personal-data-export |
| Session transcript contents | https://learn.microsoft.com/microsoft-copilot-studio/analytics-transcripts-studio |

## Evidence boundary

An unpacked agent describes authored components but does not prove the effective tenant, environment, channel, identity, connector, hosting, or operational configuration. Request screenshots, exports, policy records, or administrator attestations for controls outside the source package.

Do not mark an external control as absent merely because it is not represented in YAML. Use `Tenant/runtime evidence required` until the relevant configuration is inspected.

## Runtime evidence checklist

### Conversation data

- Whether conversation transcripts and associated metadata are saved to Dataverse
- Transcript retention period and deletion behavior
- Roles allowed to view or download transcripts
- Environment-group settings that override individual environment settings
- Analytics or external exports containing messages, metadata, feedback, or generated content
- Whether SharePoint grounding content is included in transcript fields

Treat free-form user input as potential personal data even when it is never assigned to an authored variable.

### Identity and access

- Published authentication mode and whether sign-in is required before conversation or only for selected topics
- Audience allowed to discover or access each published channel
- Whether restricted knowledge or actions require an authenticated and authorized identity
- Security roles for makers, administrators, transcript viewers, and connection owners
- Channel-specific identity behavior, including Teams, Microsoft 365, SharePoint, and Direct Line

`No authentication` is a supported public-agent pattern. Assess it against the sensitivity of data and actions; do not treat anonymous access as a breach by itself.

### Connectors and actions

- Whether each action uses maker-provided or end-user credentials
- Effective permissions of the connection identity
- Authorization checks within flows, APIs, Dataverse operations, and custom connectors
- Data policies governing connectors, HTTP, knowledge sources, skills, channels, and event triggers
- Least-privilege filters, columns, tables, and operations

Auth on the conversation does not prove that downstream actions execute as the end user. Inspect credential mode separately.

### Hosting, transparency, and geography

- Privacy and AI notices supplied by the host page, channel, wrapper application, or pre-chat experience
- Geographical, contractual, or identity restrictions that affect territorial-scope analysis
- Environment region, data residency, transfers, and subprocessors
- Accessibility of the complete channel experience, not only authored adaptive cards

### Operations and rights

- Data-subject request intake and fulfilment for transcripts, logs, agent content, and business records
- Incident monitoring, escalation, and serious-incident processes
- Retention and deletion schedules across Dataverse, analytics, exports, and connected systems
- Change approval, publishing controls, solution/ALM evidence, and accountable owners
