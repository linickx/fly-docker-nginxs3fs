#!/bin/sh
echo user_allow_other >> /etc/fuse.conf
chown nginx /dev/fuse
chown nginx /mnt/
if [ -n "$BUCKET_NAME" ]; then
    if [ ! -d "/mnt/$BUCKET_NAME" ]; then
        mkdir "/mnt/$BUCKET_NAME"
        chown nginx "/mnt/$BUCKET_NAME"
        mkdir "/mnt/.$BUCKET_NAME.cache"
        chown nginx "/mnt/.$BUCKET_NAME.cache"
        su nginx -s /bin/sh -c "s3fs $BUCKET_NAME /mnt/$BUCKET_NAME -o url=https://fly.storage.tigris.dev -o use_cache=/mnt/.$BUCKET_NAME.cache -o allow_other -o use_path_request_style"
    fi
else
    echo "Variable BUCKET_NAME is not Set"
fi
