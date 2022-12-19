def workspace = "C:/Users/AnomaAmbade/Desktop/git-sample/test"
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
				bat 'mvn clean verify'
				bat "mvn sonar:sonar \
				-Dsonar.projectKey=hello-world-sonar \
				-Dsonar.host.url=http://localhost:9000 \
				-Dsonar.login=${SONARQUBE_TOKEN}"
			}
		}
		
		stage(JMeter){
			steps{
				bat 'set OUT=jmeter.save.saveservice.output_format'
				bat "set JMX=${workspace}/jmeter-tests/TestHelloWorldJenkins.jmx"
				bat "set JTL=${workspace}/jmeter-tests/TestHelloWorldJenkins.report.jtl"
				bat 'C:/apache-jmeter-5.5/bin/jmeter -j %OUT%=xml -n -t %JMX% -l %JTL%'
			}
		}
		
        stage('Deploy Application') {
            environment {
                ANYPOINT_CREDENTIALS = credentials('anypoint.credentials')
            }
            steps {
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
				bat "${newman} run ${workspace}/newman-tests/demo-newman-test-collection.postman_collection.json \
				--reporters=cli,htmlextra \
				--reporter-htmlextra-export ${workspace}/newman_tests"
			}
		}
	}
}
