def newman_workspace = "C:/Users/AnomaAmbade/Desktop/git-sample/test/newman-tests"
def newman = "C:/Users/AnomaAmbade/AppData/Roaming/npm/newman"
minimum_coverage = 70

pipeline {
    agent any
	
    stages{
        stage('Build Application') {
            steps {
                bat 'mvn -U clean install'
            }
        }
		
		stage('MUnit Tests'){
			steps {
				bat "mvn clean test \
				-DskipVerification=true \
				-DrequiredCoverage=${minimum_coverage}"
			}
		}
		
		stage('SonarQube Analysis'){
			tools{
				jdk 'Java-jdk-11'
			}
			environment {
				SONARQUBE_TOKEN = credentials('sonarqube.login.token')
			}
			steps{
			
				//bat 'mvn clean verify'
				bat "set JAVA_HOME=$jdk"
				bat "mvn sonar:sonar \
				-DskipVerification=true \
				-DskipTests \
				-Dsonar.projectKey=hello-world-sonar \
				-Dsonar.host.url=http://localhost:9000 \
				-Dsonar.login=${SONARQUBE_TOKEN}"
			}
		}
		
        stage('Deploy Application') {
            environment {
                ANYPOINT_CREDENTIALS = credentials('anypoint.credentials')
            }
            steps {
				//echo 'My credentials'
				//echo "${ANYPOINT_CREDENTIALS_USR}"
				//echo "${ANYPOINT_CREDENTIALS_PSW}"
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
				bat "npm i -g newman newman-reporter-htmlextra"
				bat " ${newman} run ${newman_workspace}/demo-newman-test-collection.postman_collection.json \
				--reporters=cli,htmlextra \
				--reporter-htmlextra-export ${newman_workspace}"
			}
		}
	}
}
