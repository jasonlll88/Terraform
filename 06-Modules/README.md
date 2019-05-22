Modules will helpo us to avoid a lack of organization, a lack of reusability, and difficulties in management for teams.

When you modify adding or deleting any module you must re-run `terraform init`

It's safe to use because it doesn't look for a new version of the module, that is made with the flag `-upgrade`

In this example we're going to create a few resources that could have some cost in AWS.

The resources are examples client and server instances for consul