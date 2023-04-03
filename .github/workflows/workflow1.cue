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

						  git --version

						  mkdir tmpgit
						  cd tmpgit
						  git init
						  git config user.name cueckoo
						  git config user.email cueckoo@gmail.com
						  git remote add origin  https://review.gerrithub.io/cue-lang/cue

						  # We also (temporarily) get the default branch in order that
						  # we can "restore" the trybot repo to a good state for the
						  # current (i.e. previous) implementation of trybots which
						  # used PRs. If the target branch in the trybot repo is not
						  # current, then PR creation will fail because GitHub claims
						  # it cannot find any link between the commit in a PR (i.e.
						  # the CL under test in the previous setup) and the target
						  # branch which, under the new setup, might well currently
						  # be the commit from a CL.
						  git fetch origin master

						  git fetch origin refs/changes/52/551352/5
						  git checkout -b master FETCH_HEAD
						  echo "here"
						"""
				},
			]
		}
	}
}
