# ATSNE

```
https://github.com/tercen/atsne_docker_operator.git
```
## Build

```bash
docker build -t tercen/atsne:1.1.8 .
docker push tercen/atsne:1.1.8
# see operator.json -- "container": "tercen/atsne:1.1.8"
git add -A && git commit -m "1.1.8" && git tag -a 1.1.8 -m "++" && git push && git push --tags
```



