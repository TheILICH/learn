git add .
git commit -m "commit"
git push

# Start auto-exporting all variables
set -a

# Set your environment variable
export TAG=$(git rev-parse --short HEAD)

# Stop auto-exporting all variables
set +a


# Use envsubst to replace the placeholder
envsubst < templ.json > task.json

aws ecs register-task-definition --cli-input-json task.json

