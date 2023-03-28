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
						find /d/
						"""
				},
				_#step & {
					uses: "actions/setup-go@v4"
					with: {

						cache:        false
						"go-version": "1.20"
					}
				},
				_#step & {
					uses: "actions/checkout@v3"
				},
				_#step & {
					run: """
						go env
						go env -w GOCACHE=/d/tmp/go/cache
						go env -w GOMODCACHE=/d/tmp/go/modcache
						go env

						cat <<EOD > main.go
						package main

						import "fmt"

						func main() {
							fmt.Println("Hello")
						}
						EOD

						go run main.go
						go env
						"""
				},
				_#step & {
					run: """
						pwd
						"""
				},
			]
		}
	}
}
