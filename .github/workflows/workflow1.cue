package workflows

_workflow1: _#bashWorkflow & {
	name: "Workflow 1"
	jobs: {
		workflow1_job1: {
			"runs-on": "ubuntu-latest"
			steps: [
				_#step & {
					run: """
						set -x

						echo "Pre false"
						false
						echo "Post false"
						"""
				},
			]
		}
	}
}
