---
name: web-search
description: Search the web, fetch page content, clone GitHub repos, extract PDFs, and understand YouTube videos. Use when you need current information, documentation, or external resources.
---

Use the web access tools available in your harness (in DSH: `web_search`,
`web_fetch`, `web_clone`, `web_youtube` from pi-web-access; other harnesses
have equivalent tools).

## When to use
- Error messages you don't understand
- Documentation for libraries/frameworks
- Current best practices or API changes
- Solutions to problems not evident from the codebase
- Version-specific behavior or changelogs
- YouTube tutorials or conference talks about a topic
- GitHub repositories you need to explore

## Tools (DSH example)

### web_search
Search the web. Zero-config — works out of the box with Exa MCP.
```text
web_search("typescript 5.4 satisfies operator error")
web_search("next.js 14 app router middleware redirect")
```

### web_fetch
Fetch and extract clean text content from any URL.
```text
web_fetch("https://github.com/vercel/next.js/issues/12345")
```

### web_clone
Clone a GitHub repository locally for exploration.
```text
web_clone("https://github.com/vercel/next.js")
```

### web_youtube
Get transcript and understand YouTube videos.
```text
web_youtube("https://youtube.com/watch?v=...", question="What is the main point?")
```

## Search strategy
1. Be specific — include version numbers, error codes, or exact function names
2. Start narrow, then broaden if no results
3. After getting search results, use web_fetch on promising URLs
4. For GitHub repos, use web_clone to get local access instead of web_fetch
5. For YouTube content, use web_youtube for transcripts and analysis
