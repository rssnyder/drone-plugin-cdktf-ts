# drone-plugin-hcltf

a drone plugin to execute cdktf within a harness pipeline

images are tagged with `node<version>-cdktf<version>` and you can browse published versions on [dockerhub](https://hub.docker.com/r/harnesscommunity/drone-plugin-cdktf-ts/tags)

## Options

`PLUGIN_CODE_DIR`: directory in your repo where the CDKTF code is located

`PLUGIN_APP`: CDKTF app to synth

`PLUGIN_OUTPUT_DIR` (optional): directory to store resulting TF code

`PLUGIN_NPM_INSTALL_OPTIONS` (optional): additional flags to pass to `npm i` command

`PLUGIN_HCL` (optional): if set, generate output in HCL instead of JSON (default)

## usage

in an iacm pipeline:

```
- step:
    type: Plugin
    name: cdktf
    identifier: cdktf
    spec:
      connectorRef: account.harnessImage
      image: harnesscommunity/drone-plugin-cdktf-ts
      settings:
          CODE_DIR: <+workspace.envVars.CDKTF_DIR>
          APP: <+workspace.envVars.CDKTF_APP>
          OUTPUT_DIR: /harness/<+workspace.folderPath.split("/stacks")[0]>
```

where you will need to set `CDKTF_DIR` and an environment variable in your workspace to be the relitive location of your CDKTF code in your repo, and `CDKTF_APP` is set to the name of the app you want to synthisize for your pipeline.

the `folderPath` on your workspace should be set and end in `stacks/<app name>` to follow the standard output scheme of CDKTF.
