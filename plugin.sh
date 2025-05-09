#!/bin/sh

# check required variables

## where is the cdktf code stored
if [ -z "${PLUGIN_CODE_DIR}" ]; then
    echo "Error: PLUGIN_CODE_DIR is not set."
    exit 1
fi

## what app are we synthesizing
if [ -z "${PLUGIN_APP}" ]; then
    echo "Error: PLUGIN_APP is not set."
    exit 1
fi

# format optional variables

## should we output hcl instead of json
if [ -n "$PLUGIN_HCL" ]; then
    export CDKTF_HCL_FLAG="--hcl"
    echo "Setting --hcl"
fi

## we need a tf binary locally, allow the user to mount their own and set this
if [ -z "${TERRAFORM_BINARY_NAME}" ]; then
    export TERRAFORM_BINARY_NAME=tofu
    echo "Setting TERRAFORM_BINARY_NAME=tofu"
fi

## let the user specify an output location, otherwise use the default
export OUTPUT_DIR=${PLUGIN_OUTPUT_DIR-cdktf.out}

# prepare the environment for the cdktf synthesis process

cd "${PLUGIN_CODE_DIR}"

npm i "${PLUGIN_NPM_INSTALL_OPTIONS}" || exit 1
npm run get || exit 1

mkdir -p "${OUTPUT_DIR}"

# synthesize the tf configuration for the specified application

cdktf synth "${PLUGIN_APP}" \
  --output "${OUTPUT_DIR}" "${CDKTF_HCL_FLAG}" || exit 1

echo "TF Code Generated:"
find "${OUTPUT_DIR}"
