# GEMINI GLOBAL CONFIGURATION

## 1. Answer Style

- Be concise; prioritize clarity and correctness over grammar and prose.
- Default to Markdown output (lists, tables, and code blocks where helpful).
- When giving code:
  - Prefer complete, runnable examples.
  - Explain non-obvious parts with short comments or a brief bullet list.
- When asked to change code, show diffs or clearly separated "before/after" blocks.

## 2. Python, Ruff, and Formatting

- Assume modern Python 3 unless otherwise specified.
- Follow Ruff's formatting and style rules by default.
- Use a maximum line length of **120 characters**.
- Ignore the following Ruff rules when making suggestions or reviewing code:
  - `D413`, `D203`, `D213`, `S101`, `S501`, `FA100`, `COM812`, `G004`, `CPY001`.
- Prefer:
  - `snake_case` for functions, methods, and variables.
  - `PascalCase` for classes.
  - Explicit imports over star imports.
- Aim for small, focused functions and modules with clear responsibilities.
- When refactoring, keep public APIs stable unless instructed otherwise.

## 3. Zen of Python (Guiding Principles)

Treat the Zen of Python as the primary design philosophy when proposing solutions:

- Favor code that is:
  - Beautiful over ugly.
  - Explicit over implicit.
  - Simple over complex, and flat over deeply nested.
  - Readable and sparse rather than dense.
- In the face of ambiguity:
  - Refuse the temptation to guess; ask for clarification or present clearly labeled options.
- Prefer one obvious way to do things, unless strong practical concerns justify alternatives.
- If an implementation is hard to explain, treat that as a signal to simplify.
- Errors should not pass silently unless they are explicitly handled.

## 4. Jinja2 Templates

- Assume Jinja2 when working with templates unless another engine is specified.
- Keep templates:
  - Focused on presentation, with minimal business logic.
  - Using clear block/extends/include patterns.
- When generating templates, also provide:
  - Example context data.
  - Brief explanation of variables and blocks.

## 5. JSON and YAML

- JSON:
  - Use valid, minimal JSON with double-quoted keys and strings.
  - No comments; if explanation is needed, provide it outside the JSON block.
- YAML:
  - Use clear indentation and avoid unnecessary nesting.
  - Prefer explicit keys and simple scalar types where possible.
  - Add brief comments for non-obvious fields.
- For both JSON and YAML, prefer `snake_case` keys unless following an external spec.

## 6. Customer-Facing Code and Templates

- Assume code will be delivered to customers and must be:
  - Production-ready, maintainable, and secure by default.
  - Well-structured, with clear separation of concerns.
- When proposing changes:
  - Consider backward compatibility and migration steps.
  - Call out potential breaking changes explicitly.

## 7. Workflow Guidelines

- When modifying files:
  - Show a short summary of the change and then the proposed diff or new content.
- When giving command-line instructions:
  - Use POSIX-compatible shells (e.g., `bash`, `sh`) unless otherwise specified.
  - Provide a short explanation of each critical command.
- Prefer automation-oriented solutions that fit into CI/CD, DevOps, or infrastructure workflows when appropriate.

## 8. Restrictions and Defaults

- Do not add new dependencies (Python packages or tools) unless explicitly requested or clearly justified.
- Do not guess about requirements or environment details; ask for clarification instead.
- Default to secure, least-privilege patterns in code, configuration, and examples.
