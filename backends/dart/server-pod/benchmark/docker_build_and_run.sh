#!/bin/bash
cd "${0%/*}"

# Build and start services for Django-Python
# cd benchmark
# bash update_requirements.sh
# cd ..
cd benchmark_server

serverpod create-migration
cd ..
docker compose build 
docker compose up -d

# Wait for the tester to finish running
echo "Waiting for tester service to complete..."
while docker compose ps tester | grep "Up" > /dev/null; do
    sleep 5
done

# Check if the tester service has exited
if docker compose ps -a tester | grep "Exit" > /dev/null; then
    echo "Tester service has completed. Proceeding to shut down..."
    # Bring down the services and remove them
    docker compose down -v
    echo "Services shut down and volumes removed."
else
    echo "Tester service did not run or has not completed. No action taken."
fi

