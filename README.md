# ATSNE

```
https://github.com/tercen/atsne_docker_operator.git
```
## Build

```bash
VERSION=1.1.10
docker build -t tercen/atsne:$VERSION .
docker push tercen/atsne:$VERSION
# see operator.json -- "container": "tercen/atsne:1.1.8"
git add -A && git commit -m "$VERSION" && git tag -a $VERSION -m "++" && git push && git push --tags
```



