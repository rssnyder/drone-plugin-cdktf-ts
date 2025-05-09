#!/bin/sh

# check required variables
if [ -z "${PLUGIN_CODE_DIR}" ]; then
    echo "Error: PLUGIN_CODE_DIR is not set."
    exit 1
fi

if [ -z "${PLUGIN_APP}" ]; then
    echo "Error: PLUGIN_APP is not set."
    exit 1
fi

# format optional variables
if [ -n "$PLUGIN_HCL" ]; then
    export CDKTF_HCL_FLAG="--hcl"
fi

export OUTPUT_DIR=${PLUGIN_OUTPUT_DIR-cdktf.out}

# prepare the environment for the cdktf synthesis process
cd "${PLUGIN_CODE_DIR}"

npm i "${PLUGIN_NPM_INSTALL_OPTIONS}"
npm run get

mkdir -p "${OUTPUT_DIR}"

# synthesize the tf configuration for the specified application
cdktf synth "${PLUGIN_APP}" \
  --output "${OUTPUT_DIR}" "${CDKTF_HCL_FLAG}"

echo "TF Code Generated:"
find "${OUTPUT_DIR}"
