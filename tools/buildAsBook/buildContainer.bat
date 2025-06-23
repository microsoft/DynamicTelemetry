
docker  build -f Dockerfile.pandoc -t "dynamictelemetry/dynamictelemetry:pandoc" .
docker volume create dev_dir
docker volume create counter_cache
