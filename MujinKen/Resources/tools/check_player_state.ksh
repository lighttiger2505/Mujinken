#!/bin/ksh

#プレイヤーの状態定義ファイルの検証

FILE=player_state.xml
SCHEMA=player_state_schema.xsd
BIN_DIR=./bin

${BIN_DIR}/valid_xml.ksh ${FILE}
${BIN_DIR}/schema_xml.ksh ${FILE} ${SCHEMA}
${BIN_DIR}/format_xml.ksh ${FILE}

eixt 0
