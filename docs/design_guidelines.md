# Design Guidelines — ABC Wonder

## Color System

| Role | Color | Hex | Usage |
|---|---|---|---|
| Background | Soft Cream | `#FFF8E7` | Screen backgrounds |
| Alphabet | Coral | `#FF6B6B` | Alphabet section cards |
| Numbers | Teal | `#4ECDC4` | Numbers section cards |
| Days | Sunny Yellow | `#FFE66D` | Days section cards |
| Months | Soft Purple | `#A78BFA` | Months section cards |
| Text Primary | Dark Slate | `#2D3436` | Body text |
| Text Light | White | `#FFFFFF` | Text on colored cards |
| Card Shadow | Black | 10% @ 4px | Card elevation |

## Typography

| Style | Font | Size | Weight |
|---|---|---|---|
| Heading | Fredoka One | 28–36sp | Bold |
| Subheading | Nunito | 20–24sp | Bold |
| Body | Nunito | 16–20sp | Regular |
| Letter Display | Fredoka One | 72–96sp | Bold |

## Component Specs

| Component | Height | Corner Radius | Shadow |
|---|---|---|---|
| CategoryCard | 140–180 | 20 | 4dp |
| LetterCard | 80×80 / 100×100 | 16 | 2dp |
| NumberCard | 80×80 / 100×100 | 16 | 2dp |
| AudioFAB | 56 | 28 (circle) | 4dp |

## Kid-UI Principles

1. **Big targets** — min tap target 48×48dp (ideally 64×64dp)
2. **High contrast** — text always passes WCAG AA on its background
3. **Simple navigation** — always visible back button, no deep menus
4. **No dead ends** — every screen has a way back to Home
5. **Gentle feedback** — 200ms scale animation on tap, not loud sounds
6. **Consistent layout** — same visual patterns across all 4 sections

## Placeholder Strategy (until real assets arrive)

- **Letters**: Colored circle background + large white character
- **Numbers**: Colored circle background + number text + emoji row
- **Days**: Colored card with emoji centered + day name below
- **Months**: Colored card with emoji centered + month name below
