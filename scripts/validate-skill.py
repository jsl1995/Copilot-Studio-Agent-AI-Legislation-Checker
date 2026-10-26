#!/usr/bin/env python3
"""Deterministic content-contract checks for the copilot-studio-ai-compliance skill.

Cross-platform equivalent of validate-skill.ps1 (which requires PowerShell).
Keep the two scripts' assertions in sync when editing either.

Usage: python3 scripts/validate-skill.py [skill-root]
"""
import json
import re
import sys
from pathlib import Path

root = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parent.parent

paths = {
    "skill": root / "SKILL.md",
    "eu": root / "resources/eu-legislation.md",
    "uk": root / "resources/uk-legislation.md",
    "platform": root / "resources/copilot-studio-controls.md",
    "template": root / "assets/report-template.html",
    "evals": root / "evals/cases.json",
}

for name, path in paths.items():
    if not path.is_file():
        sys.exit(f"Required file is missing: {path}")

text = {name: path.read_text(encoding="utf-8") for name, path in paths.items()}
assertions = 0
failures = []


def assert_contains(doc, pattern, description):
    global assertions
    assertions += 1
    if not re.search(pattern, text[doc], re.DOTALL):
        failures.append(f"Missing required contract: {description}")


def assert_not_contains(doc, pattern, description):
    global assertions
    assertions += 1
    if re.search(pattern, text[doc], re.DOTALL):
        failures.append(f"Prohibited contract remains: {description}")


assert_contains("skill", r"Apply the EU AI Act and EU GDPR territorial tests separately", "separate EU territorial tests")
assert_contains("skill", r"YAML-only assessment - tenant/runtime and organisational controls not verified", "YAML-only limitation")
assert_contains("skill", r"Basis type:.*Binding law.*Future obligation.*Regulatory guidance.*Technical control", "basis-type classification")
assert_contains("skill", r"reasonably well-informed, observant, and circumspect", "Article 50 obvious-interaction test")
assert_contains("skill", r"Do not apply Article 26 high-risk deployer duties", "Article 26 applicability gate")
assert_contains("skill", r"do not presume every AI system requires one", "contextual DPIA test")
assert_contains("skill", r"For absent controls, do not manufacture a line citation", "absence-evidence rule")
assert_contains("skill", r"Maker-provided versus end-user credentials", "connector credential evidence")
assert_contains("skill", r"agent\.mcs\.yml.*or.*agent\.mcs\.yaml", "dual-extension agent discovery")
assert_contains("skill", r"Treat `\.mcs\.yml` and `\.mcs\.yaml` as equivalent", "extension equivalence rule")
assert_contains("skill", r"workflows/\*/workflow\.json", "workflows folder inventory")
assert_contains("skill", r"trigger/\*\.mcs\.yml", "trigger folder inventory")
assert_contains("skill", r"knowledge/", "knowledge folder inventory")
assert_not_contains("skill", r"UK-facing agents are always", "unconditional EU scope")
assert_not_contains("skill", r"Every shortfall becomes", "automatic severity conversion")
assert_not_contains("skill", r"Use AskUserQuestion", "runtime-specific interaction tool")
assert_not_contains("skill", r"\*\*Legislation:\*\*", "mandatory legislation field for non-legal findings")

assert_contains("skill", r"(?m)^description: Use when [^\n]{0,480}$", "trigger-only description under 500 characters")
assert_not_contains("skill", r"(?m)^## Evaluation", "maintainer evaluation section in runtime skill")
assert_not_contains("skill", r"Verify that dashboard counts equal the finding cards", "ambiguous evidence-required tile count")
assert_contains("skill", r"Evidence required\*\* tile counts the evidence-required rows", "evidence-required tile count source")

assert_contains("eu", r"Technical reachability from the EU alone does not prove", "conditional EU AI Act scope")
assert_contains("eu", r"generally applies from 2 August 2026", "Article 50 commencement")
assert_contains("eu", r"Representative \(Art 27\)", "EU GDPR Art 27 representative")
assert_contains("uk", r"Representative \(UK GDPR Art 27\)", "UK GDPR Art 27 representative")
assert_contains("uk", r"The principles are non-statutory", "UK guidance status")
assert_contains("uk", r"section 80 commenced on 5 February 2026", "DUAA commencement")
assert_contains("platform", r"transcripts and associated metadata are saved to Dataverse", "transcript evidence checklist")
assert_contains("platform", r"No authentication.*supported public-agent pattern", "contextual authentication rule")
assert_contains("skill", r"HTML is the primary report deliverable", "HTML primary output")
assert_contains("skill", r"Fluent UI-style dashboard", "Fluent UI dashboard contract")
assert_contains("skill", r'role="tablist"', "accessible tab contract")
assert_contains("skill", r"High.*Medium.*Low", "severity tile order")
assert_contains("skill", r"assets/report-template\.html", "HTML template reference")
assert_contains("template", r'role="tablist"', "template tablist")
assert_contains("template", r'data-severity="high"', "template High tile")
assert_contains("template", r'data-severity="medium"', "template Medium tile")
assert_contains("template", r'data-severity="low"', "template Low tile")
assert_contains("template", r"aria-selected", "template accessible tabs")
assert_contains("template", r"@media print", "template print layout")
assert_contains("template", r"filterFindings", "severity tile filtering")
assert_contains("template", r'data-target-tab="scope"', "evidence tile scope target")
assert_contains("template", r"Regimes: \{\{REGIMES\}\}", "header regimes slot")
assert_not_contains("template", r"<script[^>]+src=", "template external script dependency")

evals = json.loads(text["evals"])
cases = evals.get("cases") or []
if len(cases) < 9:
    failures.append("Expected at least nine evaluation cases.")

seen_ids = set()
for case in cases:
    for field in ("id", "scenario", "expected", "must_not"):
        if not case.get(field):
            failures.append(f"Evaluation case '{case.get('id', '?')}' is missing '{field}'.")
    case_id = case.get("id")
    if case_id in seen_ids:
        failures.append(f"Duplicate evaluation case id: {case_id}")
    seen_ids.add(case_id)

if failures:
    print("\n".join(failures))
    sys.exit(1)

print(f"Content contract validation passed: {assertions} assertions, {len(cases)} evaluation cases.")
