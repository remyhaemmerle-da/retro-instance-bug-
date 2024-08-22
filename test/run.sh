#!/bin/bash
set -xe

# we assume canton is started with ../canton.conf

daml ledger  upload-dar --host localhost --port 12011
daml ledger  upload-dar --host localhost --port 12021

daml build
daml script --dar .daml/dist/test-1.0.0.dar --ledger-host localhost --ledger-port 12011 --upload-dar false  --script-name Test:setup1   --output-file output1
cat output1

sleep 2
daml script --dar .daml/dist/test-1.0.0.dar --ledger-host localhost --ledger-port 12021 --upload-dar false  --script-name Test:setup2    --input-file output1 --output-file output2
cat output2

sleep 2
daml script --dar .daml/dist/test-1.0.0.dar --ledger-host localhost --ledger-port 12011 --upload-dar false  --script-name Test:proposal1 --input-file output2 --output-file output3
cat output3

sleep 2
daml script --dar .daml/dist/test-1.0.0.dar --ledger-host localhost --ledger-port 12021 --upload-dar false  --script-name Test:accept2    --input-file output3 --output-file output4
cat output4

sleep 2
daml script --dar .daml/dist/test-1.0.0.dar --ledger-host localhost --ledger-port 12011 --upload-dar false  --script-name Test:bug2       --input-file output4 --output-file output5
cat output5

