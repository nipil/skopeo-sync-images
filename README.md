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

See [documentation](https://github.com/containers/skopeo/blob/main/docs/skopeo-sync.1.md#yaml-file-content-used-source-for---src-yaml) for YAML format.

Edit YAML sync specifications :

    spec.multi-arch.yaml
    spec.single-arch.yaml

Then synchronize your desired images :

    rm -Rf single-arch-images
    mkdir -p single-arch-images
	./sync.sh -d single-arch-images -a auth.json spec.single-arch.yaml
	tar zcvf single-arch-images.tar single-arch-images

    rm -Rf multi-arch-images
    mkdir -p multi-arch-images
	./sync.sh -d multi-arch-images -a auth.json -m spec.multi-arch.yaml
	tar zcvf multi-arch-images.tar multi-arch-images
