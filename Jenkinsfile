// @Library('jenkins-shared-library-groovy-practice') _
// pipeline {
//     agent any
// stages{
//         stage('SonarQube Scan'){
//             steps {
//                 script{
//                     scan()
//                 }
               
//             }
//         }
//             stage('python_build') {
//                 steps {
//                     script{
//                         Pythondeploy()
                
//                 }
//             }
//         }
//                 stage ("Deploy to Staging"){
//                     steps {
//                         script{
//                             deploy()
                       
//                 }
//             }
//         }
//     stage ("Upload to S3"){
//         steps {
//             script{
//                 upload()
//             }
//         }
//     }
//     }
// }

pipeline{
   agent any
    stages{
        stage('gitclone'){
            agent any
            steps{
                git credentialsId: 'bc010765-2802-482d-8502-5f629f70228a', url: 'https://github.com/sreyaku/PythonApplication-jenkins.git'
            }
        }

        stage('Dockerizing '){
            steps{
                sh '''
             docker container stop yourcontainer
             docker container rm yourcontainer
             docker image build -t testimage:1.0 .
//             //docker run  --rm -d -p 80:5000 testimage:1.0
             docker run -d -p 80:5000 --name yourcontainer testimage:1.0''' 
//               sudo docker build -t webimage:$BUILD_NUMBER .
//               sudo docker container run -itd --name webserver$BUILD_NUMBER -p 5000 webimage:$BUILD_NUMBER''' 
          
        }
        }
         }
    }

