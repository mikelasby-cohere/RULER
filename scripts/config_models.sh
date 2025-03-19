# Copyright (c) 2024, NVIDIA CORPORATION.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

TEMPERATURE="0.0" # greedy  # TODO: MATCH QWEN-LM EXAMPLE?
TOP_P="1.0"
TOP_K="32"
REPETITION_PENALTY="1.0"
SEQ_LENGTHS=(
    131072
    65536
    32768
    16384
    8192
    4096
)

MODEL_SELECT() {
    MODEL_NAME=$1
    MODEL_DIR=$2
    ENGINE_DIR=$3
    
    case $MODEL_NAME in
        llama2-7b-chat)
            MODEL_PATH="${MODEL_DIR}/llama2-7b-chat-hf"
            MODEL_TEMPLATE_TYPE="meta-chat"
            MODEL_FRAMEWORK="vllm"
            ;;
        llama3.1-8b-chat)
            MODEL_PATH="${MODEL_DIR}/llama3.1-8b-Instruct"
            MODEL_TEMPLATE_TYPE="meta-llama3"
            MODEL_FRAMEWORK="vllm"
            ;;
        Qwen2.5-7B-Instruct-1M)
            MODEL_PATH="${MODEL_DIR}/models--Qwen--Qwen2.5-7B-Instruct-1M/snapshots/e28526f7bb80e2a9c8af03b831a9af3812f18fba/"
            MODEL_TEMPLATE_TYPE="qwen"
            MODEL_FRAMEWORK="vllm"
            TEMPERATURE="0.7" # MATCH QWEN-LM EXAMPLE?
            TOP_P="0.8"
            TOP_K="20"
            REPETITION_PENALTY="1.05"
            ;;
        Qwen2.5-14B-Instruct-1M)
            MODEL_PATH="${MODEL_DIR}/models--Qwen--Qwen2.5-14B-Instruct-1M/snapshots/620fad32de7bdd2293b3d99b39eba2fe63e97438/"
            MODEL_TEMPLATE_TYPE="qwen"
            MODEL_FRAMEWORK="vllm"
            TEMPERATURE="0.7" # MATCH QWEN-LM EXAMPLE?
            TOP_P="0.8"
            TOP_K="20"
            REPETITION_PENALTY="1.05"
            ;;
        jamba1.5-mini)
            MODEL_PATH="${MODEL_DIR}/Jamba-1.5-Mini"
            MODEL_TEMPLATE_TYPE="jamba"
            MODEL_FRAMEWORK="vllm"
            ;;
        gpt-3.5-turbo)
            MODEL_PATH="gpt-3.5-turbo-0125"
            MODEL_TEMPLATE_TYPE="base"
            MODEL_FRAMEWORK="openai"
            TOKENIZER_PATH="cl100k_base"
            TOKENIZER_TYPE="openai"
            OPENAI_API_KEY=""
            AZURE_ID=""
            AZURE_SECRET=""
            AZURE_ENDPOINT=""
            ;;
        gpt-4-turbo)
            MODEL_PATH="gpt-4"
            MODEL_TEMPLATE_TYPE="base"
            MODEL_FRAMEWORK="openai"
            TOKENIZER_PATH="cl100k_base"
            TOKENIZER_TYPE="openai"
            OPENAI_API_KEY=""
            AZURE_ID=""
            AZURE_SECRET=""
            AZURE_ENDPOINT=""
            ;;
        gemini_1.0_pro)
            MODEL_PATH="gemini-1.0-pro-latest"
            MODEL_TEMPLATE_TYPE="base"
            MODEL_FRAMEWORK="gemini"
            TOKENIZER_PATH=$MODEL_PATH
            TOKENIZER_TYPE="gemini"
            GEMINI_API_KEY=""
            ;;
        gemini_1.5_pro)
            MODEL_PATH="gemini-1.5-pro-latest"
            MODEL_TEMPLATE_TYPE="base"
            MODEL_FRAMEWORK="gemini"
            TOKENIZER_PATH=$MODEL_PATH
            TOKENIZER_TYPE="gemini"
            GEMINI_API_KEY=""
            ;;
        c3_r7b)
            MODEL_PATH="/root/cohere_ckpt/c3-7b-hf/hugging_face/poseidon"
            MODEL_TEMPLATE_TYPE="cohere"
            MODEL_FRAMEWORK="vllm"
            ;;
        c3_r7b_sparse)
            MODEL_PATH="/root/cohere_ckpt/c3-7b-hf/hugging_face/sparse"
            MODEL_TEMPLATE_TYPE="cohere"
            MODEL_FRAMEWORK="vllm"
            ;;
    esac


    if [ -z "${TOKENIZER_PATH}" ]; then
        if [ -f ${MODEL_PATH}/tokenizer.model ]; then
            TOKENIZER_PATH=${MODEL_PATH}/tokenizer.model
            TOKENIZER_TYPE="nemo"
        else
            TOKENIZER_PATH=${MODEL_PATH}
            TOKENIZER_TYPE="hf"
        fi
    fi


    echo "$MODEL_PATH:$MODEL_TEMPLATE_TYPE:$MODEL_FRAMEWORK:$TOKENIZER_PATH:$TOKENIZER_TYPE:$OPENAI_API_KEY:$GEMINI_API_KEY:$AZURE_ID:$AZURE_SECRET:$AZURE_ENDPOINT"
}
