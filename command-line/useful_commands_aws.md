aws ecr describe-images --repository-name staging --image-ids imageTag=stagingtest.zenpepper.com

aws ecr describe-images \
--repository-name staging \
--output text \
--query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[*]' \
| tr '\t' '\n' \
| tail -1

aws ecr list-images --repository-name staging --filter tagStatus=ANY --query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[0]' --output text | grep staging-sync
aws ecr describe-images --repository-name staging \
--query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[sync]' --output yaml \
| tail -n 3 | awk -F'- ' '{print $2}'

aws ecr describe-repositories --output text | awk '{print $5}' | while read line; do  aws ecr list-images --repository-name $line --filter tagStatus=UNTAGGED --query 'imageIds[*]' --output text | while read imageId; do aws ecr batch-delete-image --repository-name $line --image-ids imageDigest=$imageId; done; done




aws ecr describe-images --repository-name staging --query "sort_by(imageDetails,& imagePushedAt)[ * ].imageTags[ 0 ]" 
| grep -w 'stagingtest.zenpepper.com'|head -n -3 |  
| while read imageId; do aws ecr batch-delete-image --repository-name $line --image-ids imageDigest=$imageId; done; done



aws ecr describe-images \
    --region us-east-2 \
    --repository-name staging \
    --filter tagStatus=TAGGED \
    | jq -c '.imageDetails[] | select([.imageTags[] == "sync"] | any)'

    aws ecr describe-images --repository-name staging --query "sort_by(imageDetails,& imagePushedAt)[ * ].imageTags[ * ]" | grep -w 'sync'


  aws ecr describe-images --repository-name staging --query "sort_by(imageDetails,& imagePushedAt)[ * ].imageTags[ * ]" | grep -w 'sync'

  aws ecr batch-delete-image \
    --repository-name staging \
    --image-ids imageTag="stagingtest.zenpepper.com.origin.newZenpepper-staging.1a078280a0"

    aws ecr describe-images --repository-name staging \
--query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[0]' --output yaml \
| head -n -3 | awk -F'- ' '{print $2}'


aws ecr describe-images --repository-name staging --query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[0]' --output json | grep -w 'sync' | head -n -3

ECR_REPO="staging"

# Create a file with the list of AWS ECR tags, with one tag per line
aws ecr list-images --repository-name staging --filter "tagStatus=ANY" \
     --query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[0]' --output json | grep -w 'sync' | head -n -3 --output text \
    | cut -f2 > ecr-image-tags-staging.txt

# For each tag, delete the image on AWS ECR
cat ecr-image-tags-${ECR_REPO}.txt | xargs -I {} \
    aws ecr batch-delete-image --repository-name staging --image-ids imageTag=

    aws ecr describe-images --repository-name staging --query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[0]' | grep -w 'sync' | head -n -3

cat ecr-image-tags-sync.txt | xargs -I {}
aws ecr describe-images --repository-name staging --query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[0]' | grep -w 'sync' | head -n -3 > ecr-image-tags-sync.txt
sed 's|,||;s|"||;s|"||;' ecr-image-tags-sync.txt




