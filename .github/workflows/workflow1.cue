package workflows

_workflow1: _#bashWorkflow & {
	name: "Workflow 1"
	jobs: {
		workflow1_job1: {
			"runs-on": "windows-latest"
			steps: [
				_#step & {
					run: """
						pwd
						cd d:/
						ls
						"""
				},
				_#step & {
					uses: "actions/setup-go@v4"
					with: {

						cache:        false
						"go-version": 1.20
					}
				},
				_#step & {
					run: """
						go env
						"""
				},
			]
		}
	}
}
