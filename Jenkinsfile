@Library('github.com/fabric8io/fabric8-pipeline-library@master')
def utils = new io.fabric8.Utils()
def flow = new io.fabric8.Fabric8Commands()
def project = 'fabric8-ui/fabric8-ui-openshift-nginx'
def tempVersion
def imageName = 'fabric8/fabric8-openshift-nginx'

dockerNode{
      if (utils.isCI()){
        checkout scm
        container(name: 'docker') {
            tempVersion = "SNAPSHOT-${env.BRANCH_NAME}-${env.BUILD_NUMBER}"

            stage ('build snapshot image'){
                sh "docker build -t ${imageName}:${tempVersion} ."
            }

            stage ('push snapshot image'){
                sh "docker push ${imageName}:${tempVersion}"
            }
        }
        stage('notify'){
            def changeAuthor = env.CHANGE_AUTHOR
            if (!changeAuthor){
                error "no commit author found so cannot comment on PR"
            }
            def pr = env.CHANGE_ID
            if (!pr){
                error "no pull request number found so cannot comment on PR"
            }
            def message = "@${changeAuthor} snapshot fabric8-ui-openshift-nginx image is available for testing.  `docker pull ${imageName}:${tempVersion}`"
            container('docker'){
                flow.addCommentToPullRequest(message, pr, "fabric8-ui/fabric8-ui-openshift-nginx")
            }
        }
      } else if (utils.isCD()){
        git "https://github.com/${project}.git"
        sh "git remote set-url origin git@github.com:${project}.git"
        def version
        version = utils.getLatestVersionFromTag()
        
        container(name: 'docker') {
          stage ('build snapshot image'){
              sh "docker build -t ${imageName}:${version} ."
          }

          stage ('push snapshot image'){
              sh "docker push ${imageName}:${version}"
              sh "docker push ${imageName}:latest"
          }
        }
      }
}
