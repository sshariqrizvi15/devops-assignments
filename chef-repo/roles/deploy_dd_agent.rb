name 'deploy_dd_agent'
description 'Role that deploys Datadog components to servers'

default_attributes(
  'datadog' => {
    'api_key' => 'd0b3c5be03f3e9bfc021b503b5bd6ced',
    'application_key' => '4667878b608e4e8bcb908dacc44255a71eb6eab7',
    'agent6' => true,
  }
)

run_list %w(
  recipe[datadog::dd-agent]
)

