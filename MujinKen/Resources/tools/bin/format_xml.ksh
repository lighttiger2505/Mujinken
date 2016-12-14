#!/bin/sh

#対象xmlファイルのフォーマットを行う
#使用例：
#format_xml.ksh {対象ファイル}


WORK_DIR=/Users/lighttiger2505/work/product/Mujinken/workspace/MujinKen/MujinKen/Resources/data/
TARGET_FILE=${1}

if [ -z ${TARGET_FILE} ]; then
	echo "対象ファイルを指定してください。"
	exit -1
fi

TARGET_PATH="${WORK_DIR}${TARGET_FILE}"

if [ ! -f ${TARGET_PATH} ]; then
	echo "対象のファイルは存在しません。"
	exit -1
fi

xmllint --noout --format ${TARGET_PATH}

exit 0
