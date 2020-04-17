# GitHub Action for Scaleway

This action enables you to interact with [Scaleway](https://www.scaleway.com/) services via [the `scw` v2 command-line client](https://github.com/scaleway/scaleway-cli/tree/v2).

## Usage

1. Configure the action with the 4 required environments variables
2. Pass the command to execute using `scw`

Here's an example which starts a `DEV1-S` instance in the `fr-par-1` region:

```yaml
    - name: Create a new instance
        uses: jawher/action-scw@master
        env:
          SCW_ACCESS_KEY: ${{ secrets.SCW_ACCESS_KEY }}
          SCW_SECRET_KEY: ${{ secrets.SCW_SECRET_KEY }}
          SCW_ORGANIZATION_ID: ${{ secrets.SCW_ORGANIZATION_ID }}
          SCW_ZONE: fr-par-1
        with:
          args: instance server create image=ubuntu_bionic type=DEV1-S name=workhorse tags.0=temp tags.1=workhorse --wait -o=json

      - name: Get instance id and expose it in INSTANCE_ID env var
        run: echo ::set-env name=INSTANCE_ID::$(cat "${GITHUB_WORKSPACE}/scw.output" | jq -r '.id')

      - name: Do something with the instance
        run: ...

      - name: Delete instance
        uses: jawher/action-scw@master
        env:
          SCW_ACCESS_KEY: ${{ secrets.SCW_ACCESS_KEY }}
          SCW_SECRET_KEY: ${{ secrets.SCW_SECRET_KEY }}
          SCW_ORGANIZATION_ID: ${{ secrets.SCW_ORGANIZATION_ID }}
          SCW_ZONE: fr-par-1
        with:
          args: instance server delete server-id=${{ env.INSTANCE_ID }} with-ip=true force-shutdown=true
```


### Secrets

- `SCW_ACCESS_KEY` – **Required**: a Scaleway API token ([more info](https://www.scaleway.com/en/docs/generate-an-api-token/)).
- `SCW_SECRET_KEY` – **Required**: Scaleway API token ([more info](https://www.scaleway.com/en/docs/generate-an-api-token/)).
- `SCW_ORGANIZATION_ID` – **Required**: A Scaleway organization id


### Environment variables

We provide defaults for the following, these may also be overridden:

- `SCW_ZONE`- **Required**: Zone to target, one of `fr-par-1` or `nl-ams-1`

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).

## Credits

This action is heavily inspired from [DigitalOcean/action-doctl](https://github.com/digitalocean/action-doctl)
