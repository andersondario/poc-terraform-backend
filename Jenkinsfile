pipeline { 
    agent { label "node-terraform-agent"  }
    options { skipDefaultCheckout() } 
        stages { 
            stage('Checkout') {
                steps {
                    sh 'printenv'
                    checkout scm
                }
            }
            stage('Setup Terraform Remote State') {
                steps {
                    dir('terraform-infrastructure') {
                        git credentialsId: 'gitlab-https', url: 'https://gitlab.com/poc-aws/terraform-infrastructure.git'

                        dir('remote-state') {
                            catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                                sh "terraform init"
                                sh "terraform apply -var-file='${WORKSPACE}/env/dev.tfvars' -auto-approve"
                            }
                        }
                    }
                }
            }
            stage ('Build') { 
                steps {
                    sh "npm install"
                }
            }
            stage ('Test') { 
                steps {
                    sh "echo ignore"
                }
            }
            stage ('Deploy DEV') { 
                steps {
                    dir("terraform-infrastructure/applications/${APPLICATION_INFRA_NAME}") {
                        catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                            sh "terraform init"
                            sh "terraform workspace new dev"
                            sh "terraform workspace select dev"
                        }

                        sh "zip -r v1.zip ."
                        sh "aws s3 cp v1.zip s3://${APPLICATION_NAME}-dev"
                        sh "rm v1.zip"
                        sh "terraform apply -var-file='${WORKSPACE}/env/dev.tfvars' -auto-approve"
                    }
                }
            }
            stage ('Deploy HML') { 
                steps {
                    dir("terraform-infrastructure/applications/${APPLICATION_INFRA_NAME}") {
                        catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                            sh "terraform init"
                            sh "terraform workspace new hml"
                            sh "terraform workspace select hml"
                        }

                        sh "zip -r v1.zip ."
                        sh "aws s3 cp v1.zip s3://${APPLICATION_NAME}-hml"
                        sh "rm v1.zip"
                        sh "terraform apply -var-file='${WORKSPACE}/env/hml.tfvars' -auto-approve"
                    }
                }
            }
            stage('Confirm deploy PRD') {
                steps {
                    input 'Prosseguir para PRD?'
                }
            }
            stage ('Deploy PRD') { 
                steps {
                    dir("terraform-infrastructure/applications/${APPLICATION_INFRA_NAME}") {
                        catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                            sh "terraform init"
                            sh "terraform workspace new prd"
                            sh "terraform workspace select prd"
                        }

                        sh "zip -r v1.zip ."
                        sh "aws s3 cp v1.zip s3://${APPLICATION_NAME}-prd"
                        sh "rm v1.zip"
                        sh "terraform apply -var-file='${WORKSPACE}/env/prd.tfvars' -auto-approve"
                    }
                }
            }
        }           
}
