package workflows

_workflow1: _#bashWorkflow & {
	name: "Workflow 1"
	jobs: {
		workflow1_job1: {
			"runs-on": "windows-latest"
			steps: [
				_#step & {
					run: """
						cd d:/
						ls
						"""
				},
			]
		}
	}
}
