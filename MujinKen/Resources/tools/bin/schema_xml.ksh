#!/bin/sh

#対象ファイルをスキーマを使用して検証を行う
#使用例：
#schema_xml.ksh {対象ファイル} {対象スキーマ}


WORK_DIR=/Users/lighttiger2505/work/product/Mujinken/workspace/MujinKen/MujinKen/Resources/data/
TARGET_FILE=${1}

if [ -z ${TARGET_FILE} ]; then
	echo "対象ファイルを指定してください。"
	exit -1
fi

SCHEMA_FILE=${2}

if [ -z ${SCHEMA_FILE} ]; then
        echo "対象スキーマを指定してください。"
        exit -1
fi

TARGET_PATH="${WORK_DIR}${TARGET_FILE}"

if [ ! -f ${TARGET_PATH} ]; then
	echo "指定したファイルは存在しません。"
	exit -1
fi

SCHEMA_PATH="${WORK_DIR}${SCHEMA_FILE}"

if [ ! -f ${TARGET_PATH} ]; then
        echo "指定したスキーマは存在しません。"
        exit -1
fi

xmllint --noout --schema ${SCHEMA_PATH} ${TARGET_PATH}

exit 0
