
# NodeJS App + MongoDB + Jenkins Pipeline + Helm Demo

Scripts, docs, etc - to support a demo of all the things!

```
# Prepare the namespace (image management agent w/skopeo):
oc create -f https://raw.githubusercontent.com/redhat-cop/containers-quickstarts/master/.openshift/templates/jenkins-agent-image-mgmt-template.yml
oc new-app --template=jenkins-agent-image-mgmt
oc new-app --template=jenkins-ephemeral
oc create secret generic prod-credentials --from-literal=username=REDACTED --from-literal=token='REDACTED'

# Present:
# Show that we chose a base image from: https://catalog.redhat.com/software/containers/explore

# create the nodejs example as usual
oc new-app --template=nodejs-mongo-persistent -p SOURCE_REPOSITORY_URL=https://github.com/welshstew/nodejs-ex.git -p NAME=nodejs-ex

# Show the app running, routes, pvc, svc, pods, etc.  Scale via console.
# Let's add some CICD so we can have a more flexible pipeline.  Let's have a pipeline that will PUSH our image out to a CONTAINER REGISTRY so it can be used by others.
# Show JenkinsFile: https://github.com/welshstew/nodejs-ex/blob/master/openshift/pipeline/Jenkinsfile
# NOTE: destination registry / repo is hardcoded in the Jenkinsfile

oc new-app https://github.com/welshstew/nodejs-ex \
  --context-dir=openshift/pipeline --name nodejs-ex-pipeline

# Show the pipeline.  We now have CICD...  We are using various openshift jenkins plugins.

# But what about our Kubernetes/Open£shift manifests?  Our solution topology.  We need an IMAGE + MANIFESTS.
# Here's one I made earlier...  Helm Chart...
# https://github.com/welshstew/sample-helm-chart/tree/master/nodejs-mongo-persistent
# Talk a bit about helm, that this describes all the yaml that we are going to create for the app.

# show helm chart, show a helm chart install on my cluster.
helm install --set nodejs.image.tag=1.0 psarocks ./nodejs-mongo-persistent

# Pass to Tom
#  ---
#  For Tom:

git clone https://github.com/welshstew/sample-helm-chart
cd sample-helm-chart
helm install --set nodejs.image.tag=1.1 oneone ./nodejs-mongo-persistent --dry-run
helm install --set nodejs.image.tag=1.1 oneone ./nodejs-mongo-persistent

# Tom does oc get pvc, svc, route - show app running
# While Tom is showing I would create a change - and kick off a pipeline...
# Stu = Hey, i've got a change going through my pipeline! ...  swap to me to show the pipeline, demonstrate the change has been deployed to my cluster.
# I input/promote to Quay...
# Tom new version for you - v 2.1
#Tom does: 
helm upgrade --set nodejs.image.tag=2.1 oneone ./nodejs-mongo-persistent
# App is updated, v 2.1 of the image should be rolled out!
```