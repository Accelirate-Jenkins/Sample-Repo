pipeline {
    agent any
    stages{
        stage('Build Application') {
            steps {
                bat 'mvn -U clean install'
            }
        }
        stage('Deploy Application') {
            environment {
                ANYPOINT_CREDENTIALS = credentials('anypoint.credentials')
            }
            steps {
                bat 'mvn clean package deploy -DmuleDeploy -DskipTests \
				-Dmule.version=4.4.0 \
				-Danypoint.username=${ANYPOINT_CREDENTIALS_USR} \
				-Danypoint.password=${ANYPOINT_CREDENTIALS_PSW} \
				-Denv=Sandbox \
				-Dappname=helloworld \
				-Dbusiness=Accelirate \
				-DvCore=Micro \
				-Dworkers=1 \
				-DaltDeploymentRepository=myinternalrepo::default::file:///C:/snapshots' 
            }
        }
    }
}