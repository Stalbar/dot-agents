# Slop Pattern Catalog

Use this catalog to detect and remove artificial AI writing patterns.

---

## 1. Chatbot Residue & Delivery Artifacts
- **Throat-clearing openers**: *"In this document, we will explore..."*, *"It is important to remember..."*, *"Let's dive in..."* -> **Fix**: State the point immediately.
- **Generic cheerleading endings**: *"The future looks bright..."*, *"Only time will tell..."*, *"In conclusion, this unlocks..."* -> **Fix**: End on the last concrete fact, command, or open question.
- **Diff narration**: *"The function now works..."* -> **Fix**: Describe the current behavior directly.

---

## 2. Empty Buzzwords & Inflation
- **High-signal buzzword clusters**: `delve into`, `testament to`, `tapestry`, `in today's landscape`, `at its core`, `plays a crucial role`, `seamless`, `robust`, `transformative`, `multifaceted`, `leverage`, `foster`, `utilize`.
- **False significance**: Labelling ordinary architectural choices as "revolutionary", "groundbreaking", or "pivotal".
- **Abstract claims**: Saying "improves developer velocity" without specifying the exact changed step or metric.

---

## 3. Structural Tics & Metronomic Cadence
- **Rule-of-three reflex**: Forcing every list into exactly 3 items. Use the natural count.
- **Binary reveals**: *"It's not just X, but Y"* -> State Y directly.
- **Em dash addiction (`—`)**: Overusing em dashes to inject dramatic pauses. Use periods or simple commas.
- **Decorative formatting**: Gratuitous emojis (`🚀`, `✨`, `🔥`), bolding every 3rd word, or bullet lists that repeat heading text.

---

## 4. Preservation Rules
- Never rewrite code, commands, type names, URLs, identifiers, or citations.
- Never invent metrics, anecdotes, or facts to make vague prose seem concrete.
- Do not flag precise technical, legal, or scientific terminology.
