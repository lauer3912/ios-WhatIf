# What If Machine — Feature List

## Overview
- **App Name**: What If Machine
- **Bundle ID**: com.ggsheng.WhatIf
- **Concept**: Enter any absurd hypothetical question, receive a pseudo-scientific "research report" back
- **Target**: 欧美青少年/青年 (13-35岁)，喜欢 memes/搞怪内容/知识分享

---

## Feature Categories

### 1. Home / Input Screen
1. Large "What if..." text input field with placeholder
2. Generate button (primary CTA)
3. Scrollable horizontal chips with example questions
4. Tap chip → auto-fill input → generate
5. Particle/sparkle background animation
6. App logo and tagline

### 2. Result / Report Screen
7. Question display at top
8. "Research Report" card with 5 sections:
   - Executive Summary (humorous conclusion)
   - Methodology (absurd research methods)
   - Key Findings (stats with comedic values)
   - Critical Analysis (counterarguments in funny tone)
   - References (fake/joke citations)
9. Share button → native share sheet
10. Back navigation

### 3. AI Report Generation (Simulated)
11. Randomize report sections per question
12. Template-based content generation with variable insertions
13. Consistent humorous tone across all sections
14. Different "findings" per generation (randomized stats)

### 4. Examples System
15. 10+ pre-loaded example "What If" questions
16. Questions refresh or cycle on each view
17. Tap-to-generate from example

### 5. Visual Design
18. Dark purple background (#1A0A2E)
19. Electric amber (#FFB347) accent for buttons/labels
20. Cyan (#00D4FF) for example chips and secondary accents
21. Card-based UI with glass-morphism effects
22. Subtle particle animation in background

### 6. Share & Social
23. Share text summary of question + conclusion
24. Copy to clipboard functionality
25. Native iOS share sheet integration

### 7. Settings
26. Rate App link
27. Share App link
28. About screen (version info)
29. Clear History option

### 8. History (Future)
30. Local storage of past questions
31. History list view
32. Re-run previous questions

---

## Total: 30 Features ✅ (≥30 target met)

---

## UI Structure

- **HomeViewController**: Input + examples + particles
- **ResultViewController**: Question + report card + share
- **SettingsViewController**: Simple settings list

Single navigation stack (Home → Result)

---

## Technical Notes

- UIKit based (iOS 16+)
- No backend required — all report generation is template-based random
- Particle animation via CAEmitterLayer
- Share via UIActivityViewController
- Local storage for history (future phase)