# Agent Avengers

## Tech Stack
- Python (Django, FastAPI, Flask)
- C# (ASP.NET Core, Entity Framework Core)
- Angular
- React

## Agent & Skill Architecture
This project contains a library of reusable Claude Code sub-agents and skills.

- **Agents** (`.claude/agents/`): Role-focused definitions with lean prompts. Framework knowledge is injected via the `skills:` field, not embedded in agent prompts.
- **Skills** (`.claude/skills/`): Framework-specific conventions (Python, C#, Angular, React) shared across agents.
- **Self-improvement**: The `self-improver` agent monitors agent performance and updates skills/agents/config. See below.
- **Experimentation**: The `lab-runner` agent prototypes new agents and skills in an isolated worktree. See below.

## Continuous Improvement Protocol
IMPORTANT: Two meta-agents run automatically in the background. Launch them without being asked.

### self-improver (fixes what exists)
Launch in the background after completing any substantive task -- code implementation, debugging, code review, test writing, refactoring, or any work involving other sub-agents.

Triggers:
- After any sub-agent returns results
- After fixing a bug or resolving an error
- After a code review is completed
- After tests are written or fixed
- After any refactoring session
- When an agent produces poor, incorrect, or off-target output
- At the end of a multi-step implementation task

### lab-runner (explores what's missing)
Launch in the background when gaps are identified that can't be fixed by editing existing definitions -- new agents needed, new skills needed, or structural reorganization required. Runs in an isolated worktree so experiments never affect working definitions.

Triggers:
- When the self-improver identifies a gap requiring a new agent or skill
- When a task has no matching agent and is handled manually
- When the same detailed instructions are given repeatedly for similar tasks
- When a new framework version, library, or tool is adopted
- Periodically after several work sessions to explore improvements proactively
