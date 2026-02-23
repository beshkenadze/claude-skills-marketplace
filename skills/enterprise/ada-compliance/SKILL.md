---
name: ada-compliance
description: Audit websites, apps, and facilities for ADA compliance. Use when reviewing accessibility, conducting WCAG audits, preparing for ADA deadlines, or checking digital/physical accessibility requirements.
version: 1.0.0
---

# ADA Compliance

## Overview

Guides ADA compliance audits for digital properties (websites, apps, PDFs) and physical facilities. Covers WCAG 2.1 Level AA requirements, ADA Title II/III obligations, and actionable remediation steps.

## Instructions

When conducting an ADA compliance review:

1. **Determine scope** — ask the user:
   - Digital (website/app), physical (facility), or both?
   - Title II (government) or Title III (private business)?
   - Target standard: WCAG 2.1 AA (required) or WCAG 2.2 AA (recommended)?

2. **For digital audits**, evaluate against the four WCAG principles (POUR):
   - **Perceivable** — alt text, captions, contrast, reflow, text spacing
   - **Operable** — keyboard access, no traps, timing, navigation, input modalities
   - **Understandable** — language, predictability, error handling, labels
   - **Robust** — valid HTML, ARIA, status messages

3. **For physical facility audits**, evaluate:
   - Parking, exterior routes, entrances, interior circulation
   - Restrooms, signage, service counters, communication systems

4. **Prioritize findings** — critical (blocks access), major (significant barrier), minor (inconvenience)

5. **Provide remediation guidance** — concrete fixes with code examples for digital, specification references for physical

6. **Note deadline context** — Title II: April 24, 2026 (50K+ pop) / April 26, 2027 (under 50K)

## Digital Accessibility Checklist

### Perceivable

| Criterion | Requirement | Level |
|---|---|---|
| 1.1.1 Non-text Content | Alt text on meaningful images; decorative images marked with empty alt | A |
| 1.2.2 Captions (Prerecorded) | Synchronized captions on all prerecorded video | A |
| 1.2.4 Captions (Live) | Captions on live video content | AA |
| 1.2.5 Audio Description | Audio descriptions for prerecorded video | AA |
| 1.3.1 Info and Relationships | Structure conveyed through semantic HTML, not just visual styling | A |
| 1.3.2 Meaningful Sequence | Reading order preserved in DOM | A |
| 1.3.4 Orientation | Content not locked to single display orientation | AA |
| 1.3.5 Identify Input Purpose | Autocomplete attributes on identity/personal fields | AA |
| 1.4.1 Use of Color | Color not sole means of conveying info | A |
| 1.4.3 Contrast (Minimum) | 4.5:1 for normal text, 3:1 for large text (18pt+ or 14pt+ bold) | AA |
| 1.4.4 Resize Text | Content functional at 200% zoom | AA |
| 1.4.5 Images of Text | Real text used instead of images of text | AA |
| 1.4.10 Reflow | No horizontal scroll at 320px width (1280px at 400%) | AA |
| 1.4.11 Non-text Contrast | 3:1 contrast for UI components and meaningful graphics | AA |
| 1.4.12 Text Spacing | No loss of content when overriding line-height, spacing, word/letter spacing | AA |
| 1.4.13 Content on Hover/Focus | Hover/focus-triggered content is dismissable, hoverable, and persistent | AA |

### Operable

| Criterion | Requirement | Level |
|---|---|---|
| 2.1.1 Keyboard | All functionality available via keyboard | A |
| 2.1.2 No Keyboard Trap | Focus can always be moved away from any component | A |
| 2.1.4 Character Key Shortcuts | Single-character shortcuts can be turned off or remapped | A |
| 2.2.1 Timing Adjustable | Time limits can be turned off, adjusted, or extended | A |
| 2.2.2 Pause, Stop, Hide | Moving/auto-updating content can be paused, stopped, or hidden | A |
| 2.3.1 Three Flashes | No content flashes more than 3 times per second | A |
| 2.4.1 Bypass Blocks | Skip navigation mechanism present | A |
| 2.4.2 Page Titled | Descriptive, unique page titles | A |
| 2.4.3 Focus Order | Tab order matches logical reading order | A |
| 2.4.4 Link Purpose | Link purpose determinable from link text or context | A |
| 2.4.5 Multiple Ways | More than one way to find pages (search, sitemap, nav) | AA |
| 2.4.6 Headings and Labels | Headings and labels are descriptive | AA |
| 2.4.7 Focus Visible | Keyboard focus indicator is visible | AA |
| 2.5.1 Pointer Gestures | Multi-point/path gestures have single-pointer alternatives | A |
| 2.5.2 Pointer Cancellation | Down-events don't trigger actions; up-event completes or can abort | A |
| 2.5.3 Label in Name | Visible label text is contained in the accessible name | A |
| 2.5.4 Motion Actuation | Motion-triggered functions have UI controls and can be disabled | A |

### Understandable

| Criterion | Requirement | Level |
|---|---|---|
| 3.1.1 Language of Page | `lang` attribute on `<html>` element | A |
| 3.1.2 Language of Parts | `lang` attribute on content in a different language | AA |
| 3.2.1 On Focus | No unexpected context change on focus | A |
| 3.2.2 On Input | No unexpected context change on input without prior notice | A |
| 3.2.3 Consistent Navigation | Navigation order consistent across pages | AA |
| 3.2.4 Consistent Identification | Same functionality identified consistently across pages | AA |
| 3.3.1 Error Identification | Input errors described in text | A |
| 3.3.2 Labels or Instructions | Labels or instructions provided for user input | A |
| 3.3.3 Error Suggestion | Suggested corrections provided when errors detected | AA |
| 3.3.4 Error Prevention | Submissions for legal/financial/data are reversible, verified, or confirmed | AA |

### Robust

| Criterion | Requirement | Level |
|---|---|---|
| 4.1.2 Name, Role, Value | All UI components have accessible name, role, and state | A |
| 4.1.3 Status Messages | Status messages conveyed to assistive tech without receiving focus | AA |

## Physical Facility Checklist

### Parking
- Correct number of accessible spaces (1 per 25 for first 100)
- At least one van-accessible space per lot
- Access aisles 60" minimum width
- ISA signage mounted 60"+ above ground
- Firm, stable, slip-resistant surface

### Exterior Routes
- Accessible route from parking to entrance (36" minimum width)
- Passing spaces 60" x 60" on long routes (200ft+)
- Curb ramps at level changes
- Ramp slope max 1:12, handrails on both sides
- Level landings at top and bottom of ramps

### Entrances
- At least one accessible entrance
- 32" minimum clear door opening
- Hardware operable with one hand, no tight grasping
- Threshold max 1/2"
- Adequate maneuvering clearance

### Interior
- Corridors 36" minimum width
- Stable, firm, slip-resistant floors
- Protruding objects detectable by cane (max 4" between 27"-80" height)
- Elevator access to all public floors (controls at 48" max, Braille markings)

### Restrooms
- At least one accessible restroom per floor
- 60" turning radius
- Grab bars on side and rear walls
- Toilet seat 17"-19" height
- Sink rim 34" max, knee clearance underneath
- Lever or sensor faucets

### Signage
- Raised characters and Braille on room identification signs
- Mounted on latch side, 48"-60" from floor
- High contrast text/background

## Compliance Process

1. **Inventory** all digital assets and physical spaces
2. **Audit** — automated scan + manual testing + assistive tech testing (automated tools catch only 30-40%)
3. **Prioritize** — critical barriers first, then major, then minor
4. **Remediate** in phases with documented timelines
5. **Publish accessibility statement** with contact for reporting barriers
6. **Train staff** on accessible content creation and customer service
7. **Update procurement** to require WCAG 2.1 AA in vendor contracts
8. **Monitor continuously** — re-audit quarterly or after major changes

## Key Context

### Who Must Comply
- **Title II**: State and local governments (all sizes, no exemptions)
- **Title III**: Businesses open to the public (15+ employees). No formal technical standard yet, but courts and DOJ reference WCAG 2.1 AA

### Penalties
- First Title III violation: up to $75,000
- Subsequent violations: up to $150,000
- Title II: DOJ consent decrees, remediation orders
- Private lawsuits: injunctive relief + attorney fees

### Exceptions (Title II digital only)
- Archived content (pre-compliance, not updated, in designated archive)
- Pre-existing documents (created before deadline)
- Third-party content (not posted at agency's discretion)
- Confidential password-protected individual documents

### Common Pitfalls
- Relying solely on automated tools (miss 60-70% of issues)
- Using accessibility overlay widgets (25% of 2024 lawsuits targeted overlay users)
- Assuming older facilities are "grandfathered" (they are not)
- Forgetting third-party vendor liability (you remain legally responsible)

## Examples

### Example: Website Audit Request

**Input:** "Review our website for ADA compliance"

**Response approach:**
1. Ask for URL or code to review
2. Check against WCAG 2.1 AA criteria systematically (POUR principles)
3. Report findings by severity (critical/major/minor)
4. Provide specific code fixes for each issue
5. Recommend testing with NVDA/VoiceOver + keyboard-only navigation

### Example: New Feature Accessibility Check

**Input:** "We're adding a modal dialog, what ADA requirements apply?"

**Response approach:**
1. Focus trap management (2.1.2)
2. Keyboard dismiss with Escape (2.1.1)
3. Focus return to trigger element on close (2.4.3)
4. ARIA role="dialog" and aria-labelledby (4.1.2)
5. Visible focus indicators (2.4.7)
6. Content on hover/focus requirements if tooltip-like (1.4.13)

### Example: Facility Compliance Question

**Input:** "Our office building was built in 1995, do we need ADA upgrades?"

**Response approach:**
1. Clarify that older facilities are NOT grandfathered
2. Explain "readily achievable barrier removal" obligation for Title III
3. Walk through the physical checklist areas relevant to their space
4. Note that access should be re-evaluated annually
5. Mention tax incentives (Disabled Access Credit up to 50%, Section 190 deduction up to $15,000)

## Guidelines

- Always distinguish between Title II (government) and Title III (private business) requirements
- Reference specific WCAG success criteria by number when reporting digital issues
- Reference 2010 ADA Standards section numbers for physical facility issues
- Note that WCAG 2.2 is recommended for future-proofing even though 2.1 is the legal minimum
- Never recommend overlay widgets as a compliance solution
- Emphasize that automated testing alone is insufficient
- Include remediation priority (critical > major > minor)
- Mention applicable deadlines based on entity type

## References

- ADA.gov: https://www.ada.gov/
- WCAG 2.1: https://www.w3.org/TR/WCAG21/
- WCAG Quick Reference: https://www.w3.org/WAI/WCAG22/quickref/
- ADA Facility Checklist: https://adachecklist.org/
- 2010 ADA Standards: https://www.ada.gov/law-and-regs/design-standards/
- U.S. Access Board: https://www.access-board.gov/ada/
