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
                        git credentialsId: 'gitlab-https', url: 'https://github.com/andersondarioo/poc-terraform-infrastructure.git'

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
                    sh "zip -r v1.zip ."
                    sh "aws s3 cp v1.zip s3://${APPLICATION_NAME}"
                    sh "rm v1.zip"

                    dir("terraform-infrastructure/applications/${APPLICATION_INFRA_NAME}") {
                        catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                            sh "terraform init"
                            sh "terraform workspace new dev"
                        }
                        sh "terraform workspace select dev"
                        sh "terraform apply -var-file='${WORKSPACE}/env/dev.tfvars' -auto-approve"
                    }
                }
            }
            stage ('Deploy HML') { 
                steps {
                    sh "zip -r v1.zip ."
                    sh "aws s3 cp v1.zip s3://${APPLICATION_NAME}"
                    sh "rm v1.zip"

                    dir("terraform-infrastructure/applications/${APPLICATION_INFRA_NAME}") {
                        catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                            sh "terraform init"
                            sh "terraform workspace new hml"
                        }
                        sh "terraform workspace select hml"
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
                    sh "zip -r v1.zip ."
                    sh "aws s3 cp v1.zip s3://${APPLICATION_NAME}"
                    sh "rm v1.zip"


                    dir("terraform-infrastructure/applications/${APPLICATION_INFRA_NAME}") {
                        catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') {
                            sh "terraform init"
                            sh "terraform workspace new prd"
                            sh "terraform workspace select prd"
                        }

                        sh "terraform apply -var-file='${WORKSPACE}/env/prd.tfvars' -auto-approve"
                    }
                }
            }
        }           
}
