lambdas_definitions = {
    "hello-world" = {
        lambda_code_bucket = "anderson-arendt-terraform-backend"
        lambda_zip_path = "v1.zip"
        handle_path = "src/helloWorld.handle"
        runtime = "nodejs12.x"
        method = "GET"
        path = "helloworld"
    },
    "hello-message" = {
        lambda_code_bucket = "anderson-arendt-terraform-backend"
        lambda_zip_path = "v1.zip"
        handle_path = "src/helloMessage.handle"
        runtime = "nodejs12.x"
        method = "POST"
        path = "helloworld"
    }
}

application_name = "anderson-arendt-terraform-backend"

api_base_path = "minha-oi"
api_version = "v1"

region = "us-east-1"