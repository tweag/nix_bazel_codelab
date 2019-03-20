sh_test(
	name = "integration_test",
	srcs = ["integrationtest.sh"],
	data = [
		"//go/cmd/server:go-server",
		"//java/src/main/java/bazel/bootcamp:JavaLoggingClient",
	], 
	tags = ["exclusive"]
)