# skopeo sync

## Login to Docker Hub

Docker Hub requires login to pull images, so create an account !

If you activated 2FA, create a personnal token : https://app.docker.com/settings/personal-access-tokens

Choose the following configuration :

- authorizations : `public repo read only`
- expiry : `none`

Then login then either login without 2FA

    skopeo login docker.io --authfile auth.json

Which results in `auth.json` :

    {
        "auths": {
                "docker.io": {
                        "auth": "..."
                }
        }
    }

## Sync your images

    ./sync.sh
