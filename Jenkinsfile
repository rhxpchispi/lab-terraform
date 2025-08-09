pipeline {
    agent any
    environment {
        CREDENCIALES_AWS = credentials('AWS')
    }
    stages {
        stage('Terraform init') {
            steps {
                sh '''
            	export AWS_ACCESS_KEY_ID=$CREDENCIALES_AWS_USR
                export AWS_SECRET_ACCESS_KEY=$CREDENCIALES_AWS_PSW
            
            	terraform init

            	unset AWS_ACCESS_KEY_ID
                unset AWS_SECRET_ACCESS_KEY
             '''
            }
        }
        stage('Terraform plan') {
            steps {
                sh '''
            	export AWS_ACCESS_KEY_ID=$CREDENCIALES_AWS_USR
                export AWS_SECRET_ACCESS_KEY=$CREDENCIALES_AWS_PSW
            
            	terraform plan

            	unset AWS_ACCESS_KEY_ID
                unset AWS_SECRET_ACCESS_KEY
             '''
            }
        }
        stage('Terraform apply') {
            steps {
                timeout(time: 2) {
                    input message: '¿Aprueba el deployment?', ok: 'SI'
                }
                sh '''
                export AWS_ACCESS_KEY_ID=$CREDENCIALES_AWS_USR
                export AWS_SECRET_ACCESS_KEY=$CREDENCIALES_AWS_PSW
                
                terraform apply -auto-approve
                
                unset AWS_ACCESS_KEY_ID
                unset AWS_SECRET_ACCESS_KEY
                '''
            }
        }
        stage('Terraform destroy?') {
            steps {
                timeout(time: 2) {
                    input message: '¿Desea limpiar la estructura creada?', ok: 'SI'
                }
                sh '''
                export AWS_ACCESS_KEY_ID=$CREDENCIALES_AWS_USR
                export AWS_SECRET_ACCESS_KEY=$CREDENCIALES_AWS_PSW
                
                terraform destroy -auto-approve
                
                unset AWS_ACCESS_KEY_ID
                unset AWS_SECRET_ACCESS_KEY
                '''
            }
        }
    }
}
