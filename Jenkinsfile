pipeline {
    agent any
	minimum_coverage = 70
	newman_workspace = C:/Users/AnomaAmbade/Desktop/git-sample/test/newman-tests
    stages{
        stage('Build Application') {
            steps {
                bat 'mvn -U clean install'
            }
        }
		/*
		stage('MUnit Tests'){
			steps {
				bat "mvn -s clean test \
				-DskipVerification=true \
				-DrequiredCoverage=${minimum_coverage}"
			}
		}
		*/
        stage('Deploy Application') {
            environment {
                ANYPOINT_CREDENTIALS = credentials('anypoint.credentials')
            }
            steps {
				echo 'My credentials'
				echo "${ANYPOINT_CREDENTIALS_USR}"
				echo "${ANYPOINT_CREDENTIALS_PSW}"
                bat "mvn clean package deploy -DmuleDeploy -DskipTests \
				-Dmule.version=4.4.0 \
				-Danypoint.username=${ANYPOINT_CREDENTIALS_USR} \
				-Danypoint.password=${ANYPOINT_CREDENTIALS_PSW} \
				-Denv=Dev \
				-Dappname=helloworld-anoma \
				-DvCore=Micro \
				-Dworkers=1 \
				-DaltDeploymentRepository=myinternalrepo::default::file:///C:/snapshots" 
            }
        }
		stage('Newman Tests') {
			steps {
				bat "nmp i -g newman newman-reporter-htmlextra"
				bat "newman run ${newman_workspace}/demo-newman-test-collection.postman_collection.json \
				--reporters=cli,htmlextra \
				--reporter-htmlextra-export ${newman_workspace}"
			}
    }
}
