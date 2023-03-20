package workflows

_workflow1: _#bashWorkflow & {
	name: "Workflow 1"
	jobs: {
		workflow1_job1: {
			"runs-on": "ubuntu-latest"
			steps: [
				_#checkoutCode,
				_#step & {
					id: "unityTrailer"
					run: """
						echo "unityTrailer=$(git log -1 --pretty='%(trailers:key=Unity-Trailer,valueonly)')" >> $GITHUB_OUTPUT
						"""
				},
				_#step & {
					run: """
						echo CL is ${{ fromJSON(steps.unityTrailer.outputs.unityTrailer).CL }}
						echo patchset is ${{ fromJSON(steps.unityTrailer.outputs.unityTrailer).patchset }}
						"""
				},
				_#step & {
					if: "${{ fromJSON(steps.unityTrailer.outputs.unityTrailer) == null }}"
					run: """
						echo "No trailer set"
						"""
				},
				_#step & {
					if: "${{ fromJSON(steps.unityTrailer.outputs.unityTrailer) != null }}"
					run: """
						echo "Trailer set!"
						"""
				},
			]
		}
	}
}
