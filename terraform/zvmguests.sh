#!/bin/bash

authtoken=$(curl -s -k -i https://icicmgt1.z.stg.ibm:5000/v3/auth/tokens \
  -H "Content-Type: application/json" \
  -H "Vary: X-Auth-Token, X-Subject-Token" \
  -H "Accept: application/json" \
  -d '{"auth":{"scope":{"project":{"domain":{"name":"Default"},"name":"ibm-default"}},
       "identity":{"password":{"user":{"domain":{"name":"Default"},"password":"lnx4vm","name":"root"}},"methods":["password"]}}
}' | grep -i X-Subject-Token | awk '{print $2;}' )

tfservers=$(TF_CLI_CONFIG_FILE=.terraform.rc /opt/go/bin/terraform output -json | jq '.[].value |.[]| .vm_name '| paste -sd, -)

(echo "Name z/VM-ID" && \
curl -s -k https://icicmgt1.z.stg.ibm:8774/v2.1/205d7f7dc28c4de692df3acc7439485f/servers/detail \
        -H "X-Auth-Token: ${authtoken}" \
        | jq -r --argjson tfservers "[${tfservers}]" ' .servers[] | select([.name] | inside($tfservers)) | "\(.name) \(.["OS-EXT-SRV-ATTR:instance_name"])"' ) \
| column -t

# Invalidate the token
curl -s -k https://icicmgt1.z.stg.ibm:5000/v3/auth/tokens \
        -H "X-Auth-Token: ${authtoken}" \
        -H "X-Subject-Token: ${authtoken}" -X DELETE
