# ABC Wonder — Design System

This document defines the complete design token system extracted directly from the 188 HTML screen specifications in `stitch_abc_wonder_learning_app/`. All values are verified from the CSS/Tailwind configs embedded in the screen specs.

---

## 1. Color Tokens (MD3-inspired Palette)

### Core Surface & Background

| Token | Hex | Usage |
|-------|-----|-------|
| `surface` | `#f5faff` | Primary page backgrounds |
| `background` | `#f5faff` | App background (identical to surface in light mode) |
| `surface-bright` | `#f5faff` | Bright variant |
| `surface-dim` | `#d6dbdf` | Dimmed surface |
| `surface-container` | `#eaeef3` | Elevated container background |
| `surface-container-low` | `#eff4f9` | Low elevation container |
| `surface-container-lowest` | `#ffffff` | Highest container |
| `surface-container-high` | `#e4e9ee` | High elevation container |
| `surface-container-highest` | `#dee3e8` | Highest elevation container |
| `surface-variant` | `#dee3e8` | Variant surface |
| `inverse-surface` | `#2c3135` | Inverse surface (dark mode base) |
| `inverse-on-surface` | `#ecf1f6` | Text on inverse surface |

### Primary (Blue)

| Token | Hex | Usage |
|-------|-----|-------|
| `primary` | `#00668a` | Primary actions, active states, headings |
| `on-primary` | `#ffffff` | Text/icons on primary |
| `primary-container` | `#40c4ff` | Primary container backgrounds |
| `on-primary-container` | `#004e6b` | Text on primary-container |
| `primary-fixed` | `#c3e8ff` | Fixed primary variant |
| `primary-fixed-dim` | `#7ad0ff` | Dimmed fixed primary |
| `on-primary-fixed` | `#001e2c` | Text on primary-fixed |
| `on-primary-fixed-variant` | `#004c69` | Text variant on primary-fixed |
| `inverse-primary` | `#7ad0ff` | Inverse primary |

### Secondary (Amber/Gold)

| Token | Hex | Usage |
|-------|-----|-------|
| `secondary` | `#705d00` | Secondary elements, muted actions |
| `on-secondary` | `#ffffff` | Text on secondary |
| `secondary-container` | `#fdd400` | Gold/yellow containers, stars, rewards |
| `on-secondary-container` | `#6f5c00` | Text on secondary-container |
| `secondary-fixed` | `#ffe170` | Fixed secondary variant |
| `secondary-fixed-dim` | `#e9c400` | Dimmed fixed secondary |
| `on-secondary-fixed` | `#221b00` | Text on secondary-fixed |
| `on-secondary-fixed-variant` | `#544600` | Text variant on secondary-fixed |

### Tertiary (Pink/Rose)

| Token | Hex | Usage |
|-------|-----|-------|
| `tertiary` | `#bb0054` | Accent elements, highlights, badges |
| `on-tertiary` | `#ffffff` | Text on tertiary |
| `tertiary-container` | `#ff9bb2` | Pink container backgrounds |
| `on-tertiary-container` | `#930040` | Text on tertiary-container |
| `tertiary-fixed` | `#ffd9df` | Fixed tertiary variant |
| `tertiary-fixed-dim` | `#ffb1c1` | Dimmed fixed tertiary |
| `on-tertiary-fixed` | `#3f0018` | Text on tertiary-fixed |
| `on-tertiary-fixed-variant` | `#8f003f` | Text variant on tertiary-fixed |

### Neutral / Utility

| Token | Hex | Usage |
|-------|-----|-------|
| `on-background` | `#171c20` | Default text color |
| `on-surface` | `#171c20` | Body text (identical to on-background) |
| `on-surface-variant` | `#3e484f` | Secondary text, captions |
| `outline` | `#6e7980` | Borders, dividers |
| `outline-variant` | `#bdc8d1` | Subtle borders |
| `error` | `#ba1a1a` | Error state |
| `on-error` | `#ffffff` | Text on error |
| `error-container` | `#ffdad6` | Error container |
| `on-error-container` | `#93000a` | Text on error-container |

### Module-Specific Card Colors (from Magical Hub)

| Module | Container Color | Border Color | Progress Fill |
|--------|----------------|--------------|---------------|
| Alphabet Adventure | `#40c4ff` (primary-container) | `#004e6b` | `#c3e8ff` |
| Number Kingdom | `#fdd400` (secondary-container) | `#6f5c00` | `#ffe170` |
| Colors World | `#ff9bb2` (tertiary-container) | `#930040` | `#ffd9df` |
| Shapes Factory | `#7ad0ff` | `#004e6b` | `#ffffff` |
| Days Playground | `#ffe170` | `#544600` | `#ffffff` |
| Month Explorer | `#ffd9df` | `#3f0018` | `#ffffff` |

---

## 2. Typography

### Font Families

| Role | Font | Weights |
|------|------|---------|
| Headlines / Display | Plus Jakarta Sans | 700 (Bold), 800 (ExtraBold) |
| Body / Labels | Nunito Sans | 600 (SemiBold), 700 (Bold) |

### Font Size Presets

| Token | Size | Line Height | Weight | Letter Spacing | Usage |
|-------|------|-------------|--------|----------------|-------|
| `display-hero` | 48px | 1.1 | 800 | -0.02em | Hero text, large numbers, letter display |
| `headline-lg` | 32px | 1.2 | 700 | — | Screen titles (tablet) |
| `headline-lg-mobile` | 28px | 1.2 | 700 | — | Screen titles (mobile) |
| `body-xl` | 24px | 1.4 | 600 | — | Body content, subtitles |
| `label-bold` | 18px | 1.2 | 700 | — | Button labels, badges, nav text |

### Material Symbols (Icons)

- Icon set: **Material Symbols Outlined**
- Default size: 32px (can vary 20-48px)
- Use `font-variation-settings: 'FILL' 1` for filled variants
- Key icons used across the app: `arrow_back`, `smart_toy`, `volume_up`, `home`, `arrow_forward_ios`, `star`, `sort_by_alpha`, `123`, `palette`, `category`, `today`, `calendar_month`, `auto_awesome_motion`, `school`, `settings_account_box`, `family_history`, `close`, `lock`, `help`

---

## 3. Spacing System

| Token | Value | Usage |
|-------|-------|-------|
| `unit` | 8px | Base grid unit |
| `touch-target-min` | 64px | Minimum interactive area |
| `gutter` | 24px | Between grid items |
| `margin-mobile` | 24px | Page margins on phone |
| `margin-tablet` | 48px | Page margins on tablet (600dp+) |

### Common Spacing Values

| Context | Value |
|---------|-------|
| Card padding | `spacing-unit * 3` = 24px |
| Between sections | `spacing-unit * 4` = 32px |
| Page top padding (below AppBar) | `spacing-unit * 11` = 88px |
| Bottom nav offset | `spacing-unit * 4` = 32px (with safe area) |
| Grid gap (home screen) | `spacing-unit * 3` = 24px |

---

## 4. Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `DEFAULT` | 16px (1rem) | Cards, containers |
| `lg` | 32px (2rem) | Large cards, modals |
| `xl` | 48px (3rem) | Hero sections, banners |
| `full` | 9999px | Circular elements, pills, avatars |

---

## 5. Shadows & Elevation

### Rim Shadows (3D Button Effect)

| Token | Value | Usage |
|-------|-------|-------|
| `rim-primary` | `0 6px 0 0 #004c69` | Primary buttons, letter cards |
| `rim-tertiary` | `0 6px 0 0 #8f003f` | Tertiary colored buttons |
| `rim-secondary` | `0 6px 0 0 #544600` | Secondary colored buttons |
| `squishy-btn` | `0 6px 0 0 <darker-variant>` | 6px bottom rim, disappears + translateY 6px on press |
| `squish-click` | `0 4px 0 0 <border-color>` | Module cards, 4px rim + active: translateY |

### Box Shadows

| Token | Value | Usage |
|-------|-------|-------|
| `toy-shadow` | `0 10px 20px -5px rgba(0,103,138,0.15)` | Module cards, robot speech bubble |
| `card-shadow` | `0 10px 20px -10px rgba(0,0,0,0.05)` | Standard card elevation |
| `inner-glow-top` | `inset 0 4px 0 0 rgba(255,255,255,0.2)` | Card inner top highlight |
| `bead-active` | `inset 0 -3px 0 rgba(0,0,0,0.1), inset 0 2px 2px rgba(255,255,255,0.8)` | Active progress dot |
| `bead-inactive` | `inset 0 -3px 0 rgba(0,0,0,0.1), inset 0 2px 2px rgba(255,255,255,0.8)` | Inactive progress dot |

---

## 6. Animation & Interaction Patterns

### Press / Tap Effects

| Pattern | CSS/Flutter | Behavior |
|---------|-------------|----------|
| **pressable-3d** | `translateY(4px)` + `box-shadow: none` on `:active` | Standard 3D press: element moves down, rim shadow disappears |
| **press-effect** | `translateY(4px)` + `box-shadow: none` on `:active` | Used on lighter cards (parent dashboard) |
| **squish-click** | `scale(0.95)` + `translateY` + border-bottom compensation | Module cards in magical hub |
| **squishy-btn** | `translateY(6px)` + rim disappears | Primary action buttons with 6px rim |
| **rim-button** | Same as pressable-3d | General purpose 3D buttons |

### Continuous Animations

| Animation | Keyframes | Duration | Usage |
|-----------|-----------|----------|-------|
| **floating-bounce** | `translateY(0)` → `translateY(-15px)` → `translateY(0)` | 3s ease-in-out infinite | Mascot, hero elements |
| **animate-float-1/2/3** | `translateY` + rotation oscillation | Varying (staggered) | Number kingdom cards |
| **float-slow** | `translateY(-10px)` + slight rotation | Slow | Shape factory elements |
| **float-mascot** | Complex multi-stop translation + rotation | Custom | Robot mascot in shape factory |
| **bounce** | CSS bounce (Y oscillation) | 3s ease-in-out infinite | Robot mascot in magical hub |
| **shimmer-bg** | Gradient sweep across surface | 2s linear infinite | Loading skeleton states |

### Triggered Animations

| Animation | Trigger | Keyframes | Duration |
|-----------|---------|-----------|----------|
| **wiggle** | Tap on character | `rotate(-5deg) scale(1.1)` → `rotate(5deg) scale(1.1)` → reset | 0.3s |
| **apple-wiggle** | Tap on apple character | Same as wiggle | 0.3s + 1s bubble visible |
| **pulse-ring** | Tap on interactive element | Scale 0→1.5, opacity 1→0 | 0.5s |
| **sticker-zoom** | Tap on sticker | Scale from 0 to 1.25 | 0.2s spring |
| **press-pop** | Button press | scale(0.95) → immediate release | 0.1s |

### Transition Effects

| Transition | Duration | Curve | Usage |
|-----------|----------|-------|-------|
| Scale on hover | 0.15s | ease | Interactive elements scale(1.05) |
| Fade overlay | 0.5s | ease | Parent gate dismissal |
| Opacity bubble | 0.3s | ease | Speech bubble show/hide |
| Drop/fade | 0.7s | ease | Falling apple animation |
| Slide in | 0.3s | easeInOut | Page transitions (GoRouter) |

---

## 7. Layout Patterns

### Every Screen Shares This Structure

```
┌─ TopAppBar (fixed, 64px) ────────────────────┐
│ [← back]    [Title]             [robot icon]  │
├───────────────────────────────────────────────┤
│                                               │
│              Main Content Area                 │
│         (flex-grow, scrollable)                │
│                                               │
├───────────────────────────────────────────────┤
│  BottomNavBar (fixed, ~96px, rounded top)     │
│  [Tab1]    [Active Tab]    [Tab3]    [Tab4]   │
└───────────────────────────────────────────────┘
```

### Bottom Navigation Bar

- Fixed at bottom, rounded top corners
- Height: ~96px (including safe area padding)
- Background: `surface-container` with top shadow
- Active tab: raised with rim shadow (`translateY(-4px)`)
- Inactive tabs: flat with `on-surface-variant` color
- Tabs vary by context:
  - **Learning screens**: Back / Hub / Next
  - **Hub**: Play / Learn / Parents
  - **Parent dashboard**: Hub / Stickers / Robot / Daily / Parents

---

## 8. Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Phone (small) | 360dp | Single column, mobile margins |
| Phone (typical) | 412dp | Single column, mobile margins |
| Tablet (7") | 600dp+ | Multi-column, tablet margins (48px) |
| Tablet (10") | 800dp+ | Multi-column, tablet margins |

---

## 9. Dark Mode Support

The HTML specs include `darkMode: "class"` in Tailwind config. Dark mode tokens use the same color variable names but with adjusted values:

- `surface` → darker variant
- `surface-container` → `#2c3135` (inverse-surface)
- Text colors invert via `dark:` prefixed classes

Current app scope: light mode first. Dark mode is future scope.

---

## 10. Reusable CSS Class Catalog (→ Flutter Widgets)

These CSS classes from the HTML specs directly map to Flutter widgets:

| CSS Class | Flutter Widget | Source File(s) |
|-----------|---------------|----------------|
| `.pressable-3d` | `Pressable3D` | All screens |
| `.squish-click` | `SquishButton` | `magical_hub_1`, module cards |
| `.squishy-btn` / `.squishy-btn-secondary` | `SquishyButton` | `number_kingdom`, `colors_world` |
| `.rim-primary` / `.rim-secondary` / `.rim-tertiary` | `RimDecoration` | `alphabet_adventure_a` |
| `.tactile-card` | `TactileCard` | `number_kingdom` |
| `.bead-progress-segment` / `.bead-progress-active` | `BeadProgress` | `alphabet_adventure_a` |
| `.inner-glow-top` | `InnerGlowTop` | All card types |
| `.toy-shadow` | `ToyShadow` | `magical_hub_1`, `sticker_museum` |
| `.floating-bounce` / `.animate-float` | `AnimatedFloat` | All learning screens |
| `.apple-wiggle` | `WiggleAnimation` | `alphabet_adventure_a` |
| `.pulse-ring` | `PulseRing` | `shapes_factory` |
| `.shimmer-bg` | `ShimmerLoading` | `parent_progress_dashboard` |
| `.sparkle-overlay` | `SparkleOverlay` | `alphabet_adventure_a` |
| `.metallic-gold` / `.metallic-silver` | `MetallicGradient` | `achievements_hub` |
| `.gem-ruby` / `.gem-sapphire` / `.gem-emerald` | `GemGradient` | `achievements_hub` |
| `.badge-3d` | `AchievementBadge3D` | `achievements_hub` |
| `.sticker-card` / `.sticker-slot` | `StickerCard` / `StickerSlot` | `sticker_museum` |
| `.felt-texture` | `FeltTextureBackground` | `sticker_museum` |
| `.scrapbook-page` | `ScrapbookPage` | `sticker_museum` |
| `.blueprint-pattern` / `.glow-tube` / `.workshop-bg` | `BlueprintBackground` | `robot_lab` |
| `.press-effect` | `PressEffect` | `parent_dashboard` |
| `.rim-button` | `RimButton` | `sticker_museum` |
| `.tab-active` | `CategoryTab` | `sticker_museum` |
