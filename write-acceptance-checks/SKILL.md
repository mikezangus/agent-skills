---
name: write-acceptance-checks
description: >-
  Use when adding or reviewing tests for a bug fix, writing regression or
  acceptance tests, or deciding what tests should prove for a reported issue
  or requested behavior.
---

Derive the expected observation from the requirement, an independent reference, or the recorded pre-change contract. Use the public interface on a supported runtime. When sources disagree, identify the disputed expectation and what would settle it. Check the behavior they agree on.

Inspect the existing checks from setup through assertion. Reuse a check that already exposes the defect or protects the promise. When the request calls for a new test, deliver it and exercise the requested case. For a gap in coverage, identify plausible incorrect behavior that could pass the supplied example, then vary the input or state that distinguishes it. Where relevant, consider argument positions, boundaries, failure after partial progress, and later edits. Preserve valid variations and previously valid cases so a check does not reject an allowed implementation. Require only the exception type, ordering, representation, timing, or other detail promised by the contract.

For each assertion, name the promise a failure would break. When an operation must have no effect, identify exactly what must be absent or preserved. If earlier state must survive, establish it before the operation and check both that it survives and that the prohibited change is absent. Compare a whole snapshot only if every difference you would reject violates the contract. For a structural promise, inspect or exercise the actual dependency.

Trace the test from its public entry point through the condition that caused the failure. Keep the relevant behavior of real inputs and dependencies when substituting a test double. Observe the result after the effect can occur, including deferred work or cleanup if the contract depends on it. Check that the test setup itself permits the failure to happen.

For a bug fix, run the same check on the faulty and repaired versions when both are available. Verify which assertion exposes the reported defect. If a separately implemented or differently configured version is known to satisfy the promise, run the check there too and investigate disagreements. For a test specification, give the input, expected observation, and defect it distinguishes. State which comparisons you actually ran and what remains unverified.
