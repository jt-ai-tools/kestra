# Fork CI external-service guards

Normal build, test, local secret detection, and same-repository CI reports remain enabled. Deployments, package publication, automatic content changes, paid/live APIs, and external uploads run only in `kestra-io/kestra`.

## Pinned scanner boundary

The backend reusable workflow and TruffleHog composite are copied from [kestra-io/actions](https://github.com/kestra-io/actions/tree/176fd1157db8717e1a7df8b0090fdabf534433f3) at commit `176fd1157db8717e1a7df8b0090fdabf534433f3`. Original source comments and helper scripts are retained. No standalone LICENSE/NOTICE file was present in that source tree; no new license is asserted here.

Local files:
- `.github/workflows/fork-backend-tests.yml`: same backend tests/report steps, with only its scanner action changed to the local copy.
- `.github/actions/fork-scan-trufflehog/`: original scanner plus `--no-verification` when `GITHUB_ACTIONS=true` and `GITHUB_REPOSITORY` is not exactly `kestra-io/kestra` (missing identity also blocks live verification). Local/non-GitHub/upstream behavior is unchanged.

The unchanged executable `drop-examples.sh` and exclusion file are required by the composite. The frontend reusable does not invoke TruffleHog and is not copied. The scanner still reports local detections; fork findings are unverified and must not be described as confirmed working credentials.

Caller workflows withhold external telemetry/cloud credentials in forks. `settings.gradle` disables remote Develocity cache and build-scan publishing only for fork GitHub Actions; local caches and normal tests remain. The cloud plugin-schema embedding input is enabled only upstream.

Maintenance: compare these pinned copies with the upstream source during future synchronizations and reapply/review the fork-only verification flag. Other upstream reusable/composite actions retain their existing references and were inspected at this snapshot; future upstream changes require re-review. These safeguards were statically reviewed; a full Gradle build was not executed during synchronization.

Pinned source Git blobs:
- `.github/workflows/kestra-oss-backend-tests.yml`: `a7f279e15644784354ee2f4d44a37047b2ec1499` (mode 100644)
- `composite/scan-trufflehog/action.yml`: `0efa55964a1b1a25469477b4ba5654b912e5c3a4` (mode 100644)
- `composite/scan-trufflehog/drop-examples.sh`: `9578c7ef8d557b8f049f71266f048bb2406f6b42` (mode 100755)
- `composite/scan-trufflehog/trufflehog-exclude.txt`: `43ce6e6edf22b677033c71fc164aa93ce17b30a5` (mode 100644)
