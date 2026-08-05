# Deterministic content-contract checks for the copilot-studio-ai-compliance skill.
# Cross-platform equivalent: validate-skill.py — keep the two scripts' assertions in sync.
param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

$skillPath = Join-Path $Root 'SKILL.md'
$euPath = Join-Path $Root 'resources/eu-legislation.md'
$ukPath = Join-Path $Root 'resources/uk-legislation.md'
$platformPath = Join-Path $Root 'resources/copilot-studio-controls.md'
$templatePath = Join-Path $Root 'assets/report-template.html'
$evalPath = Join-Path $Root 'evals/cases.json'

foreach ($path in @($skillPath, $euPath, $ukPath, $platformPath, $templatePath, $evalPath)) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Required file is missing: $path"
    }
}

$skill = Get-Content -LiteralPath $skillPath -Raw -Encoding UTF8
$eu = Get-Content -LiteralPath $euPath -Raw -Encoding UTF8
$uk = Get-Content -LiteralPath $ukPath -Raw -Encoding UTF8
$platform = Get-Content -LiteralPath $platformPath -Raw -Encoding UTF8
$template = Get-Content -LiteralPath $templatePath -Raw -Encoding UTF8
$evals = Get-Content -LiteralPath $evalPath -Raw -Encoding UTF8 | ConvertFrom-Json
$assertions = 0

function Assert-Contains {
    param([string]$Text, [string]$Pattern, [string]$Description)
    $script:assertions++
    if ($Text -notmatch $Pattern) {
        throw "Missing required contract: $Description"
    }
}

function Assert-NotContains {
    param([string]$Text, [string]$Pattern, [string]$Description)
    $script:assertions++
    if ($Text -match $Pattern) {
        throw "Prohibited contract remains: $Description"
    }
}

Assert-Contains $skill 'Apply the EU AI Act and EU GDPR territorial tests separately' 'separate EU territorial tests'
Assert-Contains $skill 'YAML-only assessment - tenant/runtime and organisational controls not verified' 'YAML-only limitation'
Assert-Contains $skill 'Basis type:.*Binding law.*Future obligation.*Regulatory guidance.*Technical control' 'basis-type classification'
Assert-Contains $skill 'reasonably well-informed, observant, and circumspect' 'Article 50 obvious-interaction test'
Assert-Contains $skill 'Do not apply Article 26 high-risk deployer duties' 'Article 26 applicability gate'
Assert-Contains $skill 'do not presume every AI system requires one' 'contextual DPIA test'
Assert-Contains $skill 'For absent controls, do not manufacture a line citation' 'absence-evidence rule'
Assert-Contains $skill 'Maker-provided versus end-user credentials' 'connector credential evidence'
Assert-Contains $skill 'agent\.mcs\.yml.*or.*agent\.mcs\.yaml' 'dual-extension agent discovery'
Assert-Contains $skill 'Treat `\.mcs\.yml` and `\.mcs\.yaml` as equivalent' 'extension equivalence rule'
Assert-Contains $skill 'workflows/\*/workflow\.json' 'workflows folder inventory'
Assert-Contains $skill 'trigger/\*\.mcs\.yml' 'trigger folder inventory'
Assert-Contains $skill 'knowledge/' 'knowledge folder inventory'
Assert-NotContains $skill 'UK-facing agents are always' 'unconditional EU scope'
Assert-NotContains $skill 'Every shortfall becomes' 'automatic severity conversion'
Assert-NotContains $skill 'Use AskUserQuestion' 'runtime-specific interaction tool'
Assert-NotContains $skill '\*\*Legislation:\*\*' 'mandatory legislation field for non-legal findings'

Assert-Contains $eu 'Technical reachability from the EU alone does not prove' 'conditional EU AI Act scope'
Assert-Contains $eu 'generally applies from 2 August 2026' 'Article 50 commencement'
Assert-Contains $uk 'The principles are non-statutory' 'UK guidance status'
Assert-Contains $uk 'section 80 commenced on 5 February 2026' 'DUAA commencement'
Assert-Contains $platform 'transcripts and associated metadata are saved to Dataverse' 'transcript evidence checklist'
Assert-Contains $platform 'No authentication.*supported public-agent pattern' 'contextual authentication rule'
Assert-Contains $skill 'HTML is the primary report deliverable' 'HTML primary output'
Assert-Contains $skill 'Fluent UI-style dashboard' 'Fluent UI dashboard contract'
Assert-Contains $skill 'role="tablist"' 'accessible tab contract'
Assert-Contains $skill 'High.*Medium.*Low' 'severity tile order'
Assert-Contains $skill 'assets/report-template.html' 'HTML template reference'
Assert-Contains $template 'role="tablist"' 'template tablist'
Assert-Contains $template 'data-severity="high"' 'template High tile'
Assert-Contains $template 'data-severity="medium"' 'template Medium tile'
Assert-Contains $template 'data-severity="low"' 'template Low tile'
Assert-Contains $template 'aria-selected' 'template accessible tabs'
Assert-Contains $template '@media print' 'template print layout'
Assert-Contains $template 'filterFindings' 'severity tile filtering'
Assert-Contains $template 'data-target-tab="scope"' 'evidence tile scope target'
Assert-Contains $template 'Regimes: {{REGIMES}}' 'header regimes slot'
Assert-NotContains $template '<script[^>]+src=' 'template external script dependency'

if ($null -eq $evals.cases -or $evals.cases.Count -lt 9) {
    throw 'Expected at least nine evaluation cases.'
}

$ids = @{}
foreach ($case in $evals.cases) {
    foreach ($field in @('id', 'scenario', 'expected', 'must_not')) {
        if ($null -eq $case.$field -or $case.$field.Count -eq 0) {
            throw "Evaluation case '$($case.id)' is missing '$field'."
        }
    }
    if ($ids.ContainsKey($case.id)) {
        throw "Duplicate evaluation case id: $($case.id)"
    }
    $ids[$case.id] = $true
}

Write-Output "Content contract validation passed: $assertions assertions, $($evals.cases.Count) evaluation cases."
