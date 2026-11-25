---
name: assign-responsibilities
description: Refactor or extend code with multiple operations, dispatch branches, or duplicated behavior shared by callers. Use when implementing a feature or changing existing code requires deciding where validation, operation-specific logic, shared rules, functions, or modules belong.
---

Start at the requested entry points. Follow each path to the code that decides its result. In a new app, trace the requested user actions the same way before choosing files. Read any project instructions that assign ownership. Identify which requirement governs each decision and which callers rely on it.

Ask what should happen if that requirement changes. When every affected caller must follow the change, implement the rule once with the code that owns its meaning. Route each caller through that definition. A caller should be able to obtain the result without importing another caller's private machinery. When one policy can change while another stays fixed, give each its own named definition, even if their values agree today. They can still call the same calculation with different inputs.

When changing a dispatcher, inspect each existing and added branch for operation-specific behavior and shared routing. Ask what a change to one operation’s validation or effect would touch. If it requires editing the routing body, move that independently varying behavior to a named owner when the change is within scope, then recheck. A branch that only routes or passes data can stay in the dispatcher; leave unrelated code outside the authorized change alone.

Keep steps together when they jointly produce one result. Extract a named operation when callers need the same rule or a caller would otherwise implement a decision that changes independently. Keep private declarations with the operation they support. When one policy can be changed through a single interface, group its implementation and private helpers behind that interface. Use the language’s file and module boundaries to hide those details, let a consumer load the operation independently, or follow an adopted layout rule. Name it after the behavior or decision a maintainer would change.

Check the implemented paths. Trace shared decisions from every affected caller to their definition, including defaults and fallbacks. Exercise the change through those callers. For independent policies, vary one and check both results. If independent use motivated a module boundary, run the consumer with the unnecessary component absent. Correct the code when the observed effects differ from the intended ones.
