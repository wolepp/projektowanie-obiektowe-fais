#!/bin/sh

echo "Testing Dogsapp!"

POST_CMD=$(cat <<-END
curl -XPOST localhost:5000/dog \
-H "Content-Type: application/json" \
-d '{
    "owner": "Wojtek",
    "breed": "corgi"    
}'
END
)

GET_CMD=$(cat <<-END
curl -XGET localhost:5000/dog/1
END
)

UPDATE_CMD=$(cat <<-END
curl -XPUT localhost:5000/dog \
-H "Content-Type: application/json" \
-d '{
    "id": 1,
    "owner": "Ktoś",
    "breed": "corgi"
}'
END
)

DELETE_CMD=$(cat <<-END
curl -XDELETE localhost:5000/dog/1
END
)

COMMANDS=(
    "$POST_CMD"
    "$GET_CMD"
    "$UPDATE_CMD"
    "$DELETE_CMD"
)

for c in "${COMMANDS[@]}"
do
    echo ""
    echo "$c"
    sleep 1
    eval "$c"
done
echo ""
