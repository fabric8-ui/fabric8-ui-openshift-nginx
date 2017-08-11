#!/usr/bin/groovy
@Library('github.com/fabric8io/fabric8-pipeline-library@master')
def dummy
dockerTemplate{
  dockerNode{
    if (env.BRANCH_NAME.startsWith('PR-')) {
      goCI{
        githubOrganisation = 'fabric8-ui'
        dockerOrganisation = 'fabric8'
        project = 'fabric8-ui-openshift-nginx'
        dockerBuildOptions = '--file Dockerfile'
      }
    } else if (env.BRANCH_NAME.equals('master')) {
      goRelease{
        githubOrganisation = 'fabric8-ui'
        dockerOrganisation = 'fabric8'
        project = 'fabric8-ui-openshift-nginx'
        dockerBuildOptions = '--file Dockerfile'
      }
    }
  }
}