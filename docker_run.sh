# docker run --name hayabusa -d -p 50003:8000 -v /server/dev/django_todo/app/hayabusa/db.sqlite3:/server/hayabusa/db.sqlite3 hayabusa/app:latest
kubectl apply -f ./deployment/server-deployment.yaml --record
