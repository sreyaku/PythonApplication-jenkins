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
                bat '''
                
            docker image build -t testimage:1.0 .
            docker run  stop -d -p 80:5000 testimage:1.0 
            '''
        }
        }
         }
    }

