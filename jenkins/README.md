# jenkins

This assignment deploys sample application in all private instances using declarative pipeline. Same task was also performed using shared pipeline.

## Stages of pipeline

- Preparation: Download git repository
- Build: Docker build and publish
- Deploy: Deploy on all private instances by using AWS CLI commands on shell script.

