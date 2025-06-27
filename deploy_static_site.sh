#!/bin/bash

# Exit on any error
set -e

# === CONFIGURATION ===
PROJECT_ID="driven-saga-456008-m4"
BUCKET_NAME="rawatportfolio"   
REGION="us-central1"                    
SOURCE_DIR="*"             

gcloud config set project "$PROJECT_ID"

# === 2. Create the GCS bucket ===
# gsutil mb -l "$REGION" -p "$PROJECT_ID" gs://"$BUCKET_NAME"

# === 3. Enable static website hosting ===
gsutil web set -m index.html -e 404.html gs://"$BUCKET_NAME"

# === 4. Upload website files ===
gsutil cp -r "$SOURCE_DIR"/* gs://"$BUCKET_NAME"

# === 5. Make all files publicly readable ===
gsutil iam ch allUsers:objectViewer gs://"$BUCKET_NAME"

# === 6. Output website URL ===
echo ""
echo "✅ Website deployed successfully!"
echo "🌐 Visit: http://storage.googleapis.com/$BUCKET_NAME/index.html"


# chmod +x deploy_static_site.sh
# ./deploy_static_site.sh
