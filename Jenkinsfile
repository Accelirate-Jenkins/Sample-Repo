pipeline{
  agent any 
  stages{
    stage(‘BuildApplication’){
      steps{
        bat‘mvn clean install’
      }
    }
	stage(‘DeployCloudHub’){
      environment{
        ANYPOINT_CREDENTIALS=credentials(‘anypoint.credentials’)
      }
	  steps{
  		bat 'mvn clean package deploy -DmuleDeploy -DskipTests -Dmule.version=4.4.0 -Danypoint.username=${ANYPOINT_CREDENTIALS_USR} -Danypoint.password=${ANYPOINT_CREDENTIALS_PSW} -Denv=Sandbox -Dappname=helloworld -Dbusiness=Accelirate -DvCore=Micro -Dworkers=1' 
      }
    }
  }
}