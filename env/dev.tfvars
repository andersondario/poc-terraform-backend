lambdas_definitions = {
    "helloworld" = {
        lambda_code_bucket = "anderson-arendt-terraform-backend"
        lambda_zip_path = "v1.zip"
        handle_path = "src/helloWorld.handle"
        runtime = "nodejs12.x"
        method = "GET"
        path = "helloworld"
    },
    "hellomessage" = {
        lambda_code_bucket = "anderson-arendt-terraform-backend"
        lambda_zip_path = "v1.zip"
        handle_path = "src/helloMessage.handle"
        runtime = "nodejs12.x"
        method = "POST"
        path = "hellomessage"
    }
}

application_name = "anderson-arendt-terraform-backend"

region = "us-east-1"
account_id = "167947257750"